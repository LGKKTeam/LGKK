//
//  SPBaseModel.swift
//  spDirect
//
//  Created by Admin on 2/20/17.
//  Copyright © 2017 SiliconPrime. All rights reserved.
//

import UIKit
import ObjectMapper
import Realm
import RealmSwift

open class RealmString: Object {
    open dynamic var stringValue = ""
}

open class SPBaseModel: Object, Mappable {
    
    open func mapping(map: Map) {
    }
    
    open dynamic var _id: String = ""
    
    required public init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    required public init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required public init(map: Map) {
        super.init()
        
        _id <- map["_id"]
    }
    
    required public init() {
        super.init()
    }
    
    override open class func primaryKey() -> String? {
        return "_id"
    }
}

open class ListTransform<T:Object> : TransformType where T:Mappable {
    
    public typealias Object = List<T>
    public typealias JSON = [[String:Any]]
    
    let mapper = Mapper<T>()
    
    public init() {
    }
    
    open func transformFromJSON(_ value: Any?) -> List<T>? {
        let result = List<T>()
        if let tempArr = value as? [Any] {
            for entry in tempArr {
                let mapper = Mapper<T>()
                if let model:T = mapper.map(JSONObject: entry) {
                    result.append(model)
                }
            }
        }
        return result
    }
    
    open func transformToJSON(_ value: Object?) -> JSON? {
        var results = [[String:Any]]()
        if let value = value {
            for obj in value {
                let json = mapper.toJSON(obj)
                results.append(json)
            }
        }
        return results
    }
}

open class ISODateTransform: DateFormatterTransform {
    
    public init() {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        super.init(dateFormatter: formatter)
    }
}

infix operator <-

/// Object of Realm's List type
public func <- <T: Mappable>(left: List<T>, right: Map) {
    var array: [T]?
    
    if right.mappingType == .toJSON {
        array = Array(left)
    }
    
    array <- right
    
    if right.mappingType == .fromJSON {
        if let theArray = array {
            left.append(objectsIn: theArray)
        }
    }
}

/// Object of Realm's RealmOptional type
public func <- <T>(left: RealmOptional<T>, right: Map) {
    var optional: T?
    
    if right.mappingType == .toJSON {
        optional = left.value
    }
    
    optional <- right
    
    if right.mappingType == .fromJSON {
        if let theOptional = optional {
            left.value = theOptional
        }
    }
}
