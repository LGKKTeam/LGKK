//
//  AppDelegate.swift
//  DemoSwiftLint
//
//  Created by Nguyen Minh on 5/4/17.
//  Copyright © 2017 AHDEnglish. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let _id: String? = "asdkasldk"
    
    var window: UIWindow?
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // override point for customization after application launch. asdkasdlaks, alsdajsdlkasd
        print(_id as Any)
        
        let mys_Table: UITableView? = UITableView()
        print(mys_Table as Any)
        
        let bool1: Bool = false
        guard bool1 else {
            print("test1 my")
            return true
        }
        print(_id as Any)
        return true
    }
}
