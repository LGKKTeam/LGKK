//
//  SPBaseTabBarViewController.swift
//  drivethrough
//
//  Created by Duc iOS on 3/17/17.
//  Copyright © 2017 SP. All rights reserved.
//

import UIKit

open class SPBaseTabBarViewController: UITabBarController {
    
    open func goto(classVC: AnyClass, animated: Bool) {
        if let arrayVc = self.viewControllers {
            //BFS
            for (index,vc) in arrayVc.enumerated() {
                if vc.isKind(of: classVC) {
                    self.selectedIndex = index
                    return
                }
            }
            
            for (index, vc) in arrayVc.enumerated() {
                if let vc = vc as? UINavigationController {
                    for vcLv1 in vc.viewControllers {
                        if vcLv1.isKind(of: classVC) {
                            self.selectedIndex = index
                            vc.popToViewController(vcLv1, animated: animated)
                            return
                        }
                    }
                    
                } else if let vc = vc as? UIPageViewController {
                    if let arrayLv1 = vc.viewControllers {
                        for vcLv1 in arrayLv1 {
                            if vcLv1.isKind(of: classVC) {
                                self.selectedIndex = index
                                vc.setViewControllers([vcLv1], direction: .forward, animated: animated, completion: nil)
                                return
                            }
                        }
                    }
                }
            }
            
        } else {
            print("Invalid viewcontroller class")
        }
    }
}
