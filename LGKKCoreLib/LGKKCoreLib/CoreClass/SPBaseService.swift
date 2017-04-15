//
//  SPBaseService.swift
//  spDirect
//
//  Created by Admin on 2/15/17.
//  Copyright © 2017 SiliconPrime. All rights reserved.
//

import Foundation
import Moya
import Alamofire
import CocoaLumberjack
import ObjectiveC
import ObjectMapper

open class SPBaseService: TargetType {
    open var urlHost: String {
        return "Need implemented in sub-class"
    }

    open var domainString: String {
        return "Need implemented in sub-class"
    }
    
    public init() {}
    
    private class DefaultAlamofireManager: Alamofire.SessionManager {
        static let sharedManager: DefaultAlamofireManager = {
            let configuration = URLSessionConfiguration.default
            configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
            configuration.timeoutIntervalForRequest = 60
            configuration.timeoutIntervalForResource = 60
            configuration.requestCachePolicy = .useProtocolCachePolicy
            return DefaultAlamofireManager(configuration: configuration)
        }()
    }
    
    open var headers: [String: String] {
        get {
            return [:]
        }
    }
    
    open var endpointClosure: (SPBaseService) -> Endpoint<SPBaseService> {
        get {
            return {
                [unowned self] (target: SPBaseService) -> Endpoint<SPBaseService> in
                let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
                return defaultEndpoint.adding(newHTTPHeaderFields: self.headers)
            }
        }
    }
    
    open var sampleEndpointClosure: (SPBaseService) -> Endpoint<SPBaseService> {
        get {
            return {
                (target: SPBaseService) -> Endpoint<SPBaseService> in
                let url = target.baseURL.appendingPathComponent(target.path).absoluteString
                return Endpoint(url: url, sampleResponseClosure: {.networkResponse(200, target.sampleData)}, method: target.method, parameters: target.parameters)
            }
        }
    }
    
    open lazy var requestClosure: ((Endpoint<SPBaseService>, @escaping MoyaProvider<SPBaseService>.RequestResultClosure) -> Void) = MoyaProvider.defaultRequestMapping
    open lazy var stubClosure: (SPBaseService) -> Moya.StubBehavior = MoyaProvider.neverStub
    open lazy var stubClosure1: (SPBaseService) -> Moya.StubBehavior = MoyaProvider.immediatelyStub
    open lazy var stubClosure2: (SPBaseService) -> Moya.StubBehavior = MoyaProvider.delayedStub(1)
    
    open var networkLoggerVerbose: Bool = false
    
    open lazy var plugins: [NetworkLoggerPlugin] = [
        NetworkLoggerPlugin(
            verbose: self.networkLoggerVerbose,
            responseDataFormatter: SPBaseService.JSONResponseDataFormatter)
    ]
    
    open var baseProvider: MoyaProvider<SPBaseService> {
        get {
            return MoyaProvider<SPBaseService>(
                endpointClosure: endpointClosure,
                requestClosure: requestClosure,
                stubClosure: stubClosure,
                manager: DefaultAlamofireManager.sharedManager,
                plugins: plugins,
                trackInflights: false
            )
        }
    }
    
    open var sampleProvider: MoyaProvider<SPBaseService> {
        get {
            return MoyaProvider<SPBaseService>(
                endpointClosure: sampleEndpointClosure,
                requestClosure: requestClosure,
                stubClosure: stubClosure1,
                manager: DefaultAlamofireManager.sharedManager,
                plugins: plugins,
                trackInflights: false
            )
        }
    }
    
    static func JSONResponseDataFormatter(_ data: Data) -> Data {
        do {
            let dataAsJSON = try JSONSerialization.jsonObject(with: data)
            let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
            return prettyData
        } catch {
            return data // fallback to original data if it can't be serialized.
        }
    }
    
    open var wrongDataFormatString: String {
        return "Wrong data format!"
    }
    
    /// Generic request-making method
    public func start<T>(parser: @escaping (Moya.Response) throws -> T?, completion: @escaping (SPBaseError?, T?) -> Void) -> Cancellable {
        return baseProvider.request(self) { [unowned self] (result) in
            do {
                let response = try result.dematerialize()
                switch response.statusCode {
                case 200 :
                    if let data = try parser(response) {
                        completion(nil, data)
                    } else {
                        let error = NSError(domain: self.domainString, code: 0, userInfo: [NSLocalizedFailureReasonErrorKey: self.wrongDataFormatString])
                        completion(SPBaseError.wrapError(error), nil)
                    }
                    break
                    
                default:
                    let responseJSON = try response.mapJSON() as? Dictionary<String, Any>
                    if let responseModel = Mapper<SPBaseResponseModel>().map(JSONObject: responseJSON) {
                        if let status = responseModel.status, let code = responseModel.code, code != .NONE {
                            let spError = SPBaseError(status: status, code: code, response: responseJSON)
                            switch spError {
                            case .none:
                                break
                            default:
                                completion(spError, nil)
                                return
                            }
                        }
                    }
                    
                    var error: NSError
                    if let json = try response.mapJSON() as? [String: Any],
                        let status = json["status"] as? Int,
                        let message = json["message"] as? String,
                        let code = json["code"] as? String {
                        error = NSError(domain: self.domainString, code: status, userInfo:[NSLocalizedFailureReasonErrorKey: message, "code": code])
                    } else {
                        error = NSError(domain: self.domainString, code: response.statusCode, userInfo:[NSLocalizedFailureReasonErrorKey: "Unexpected error"])
                    }
                    completion(SPBaseError.wrapError(error), nil)
                    break
                }
                
            } catch {
                if error.localizedDescription == "cancelled" {
                    return
                }
                completion(SPBaseError.wrapError(error), nil)
            }
        }
    }
    
    @available(*, deprecated, message: "no longer available ...")
    open func startWithErrorHandling(completion: @escaping Moya.Completion) -> Cancellable {
        return baseProvider.request(self) { [unowned self] (result) in
            do {
                switch result {
                case .success(let response):
                    switch response.statusCode {
                    case 200 :
                        completion(.success(response))
                    default:
                        var error: NSError
                        if let json = try response.mapJSON() as? [String: Any],
                            let status = json["status"] as? Int,
                            let message = json["message"] as? String,
                            let code = json["code"] as? String {
                            error = NSError(domain: self.domainString,
                                            code: status,
                                            userInfo: [NSLocalizedFailureReasonErrorKey: message,
                                                       "code": code])
                        } else {
                            error = NSError(domain: self.domainString, code: response.statusCode, userInfo: [NSLocalizedFailureReasonErrorKey: "Unexpected error"])
                        }
                        completion(.failure(MoyaError.underlying(error)))
                    }
                case .failure(let error):
                    completion(.failure(MoyaError.underlying(error)))
                }
            } catch let error {
                completion(.failure(MoyaError.underlying(error)))
            }
        }
    }
    
    @available(*, deprecated, message: "no longer available ...")
    open func start(completion: @escaping Moya.Completion) -> Cancellable {
        return baseProvider.request(self, completion: completion)
    }
    
    open func startSample(completion: @escaping Moya.Completion) -> Cancellable {
        return sampleProvider.request(self, completion: completion)
    }
    
    //MARK: - Moya methods
    open var baseURL: URL {
        return URL(string: urlHost)!
    }
    
    open var path: String {
        return ""
    }
    
    open var method: Moya.Method {
        return .post
    }
    
    open var parameters: [String: Any]? {
        return nil
    }
    
    open var parameterEncoding: ParameterEncoding {
        switch self.method {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
    
    open var sampleData: Data {
        return "test sample data".data(using: .utf8)!
    }
    
    open var task: Task {
        return .request
    }
    
    open var validate: Bool {
        return false
    }
}

//MARK: - Moya Response
public extension Moya.Response {
    public func mapNSArray() throws -> NSArray {
        let any = try self.mapJSON()
        guard let array = any as? NSArray else {
            throw MoyaError.jsonMapping(self)
        }
        return array
    }
}

open class BaseMappableClosure<T: BaseMappable> {
    
    public init() {}
    
    open lazy var closureObject:(Moya.Response) throws -> T? = {(response) -> T? in
        let responseJSON = try response.mapJSON()
        return Mapper<T>().map(JSONObject: responseJSON)
    }
    
    open lazy var closureListObject:(Moya.Response) throws -> [T]? = {(response) -> [T]? in
        let responseJSON = try response.mapJSON()
        return Mapper<T>().mapArray(JSONObject: responseJSON)
    }
}

open class NoneBaseMappableClosure {
    
    public init() {}
    
    open lazy var noneMappableClosure:(Moya.Response) throws -> Dictionary<String, Any>? = {(response) -> Dictionary<String, Any>? in
        if let data = try response.mapJSON() as? Dictionary<String, Any> {
            return data
        } else {
            return nil
        }
    }
}
