//
//  AppDelegate.swift
//  DemoVideoByGPU
//
//  Created by Nguyen Minh on 5/2/17.
//  Copyright © 2017 AHDEnglish. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow.init(frame: UIScreen.main.bounds)
        let vc = CaptureVideoViewController()
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        return true
    }
}
