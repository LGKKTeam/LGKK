//
//  SPBaseListModel.swift
//  spDirect
//
//  Created by Admin on 2/21/17.
//  Copyright © 2017 SiliconPrime. All rights reserved.
//

import UIKit
import ObjectMapper
import Realm
import RealmSwift

open class SPBaseListModel: SPBaseModel {
    dynamic var count: Int = 0
    
    override open func mapping(map: Map) {
        super.mapping(map: map)

        count <- map["count"]
    }
}
