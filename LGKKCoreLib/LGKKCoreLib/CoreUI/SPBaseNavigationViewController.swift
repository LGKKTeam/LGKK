//
//  SPBaseNavigationViewController.swift
//  spDirect
//
//  Created by HoangHo on 2/14/17.
//  Copyright © 2017 SiliconPrime. All rights reserved.
//

import UIKit

open class SPBaseNavigationViewController: UINavigationController {
    
    deinit {
        print("Deinit \(self)")
    }
    
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return topViewController?.supportedInterfaceOrientations ?? .all
    }
}
