//
//  SPBaseResponseModel.swift
//  spDirect
//
//  Created by Admin on 2/21/17.
//  Copyright © 2017 SiliconPrime. All rights reserved.
//

import UIKit
import ObjectMapper
import Realm
import RealmSwift

open class SPBaseResponseModel: SPBaseModel {
    open var code: SPAPICode? {
        get { return SPAPICode(rawValue: privateCode) }
        set { privateCode = newValue?.rawValue ?? SPAPICode.NONE.rawValue }
    }
    open var status: SPAPIStatus? {
        get { return SPAPIStatus(rawValue: privateStatus)}
        set { privateStatus = newValue?.rawValue ?? SPAPIStatus.statusSuccess.rawValue }
    }
    
    private dynamic var privateCode = SPAPICode.NONE.rawValue
    private dynamic var privateStatus = SPAPIStatus.statusSuccess.rawValue
    open dynamic var message: String?
    open dynamic var pattern: String?
    open dynamic var instance: String?
    
    override open func mapping(map: Map) {
        super.mapping(map: map)

        code <- (map["code"], EnumTransform())
        status <- (map["status"], EnumTransform())
        message <- map["message"]
        pattern <- map["pattern"]
        instance <- map["instance"]
    }
}
