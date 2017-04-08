//
//  UIWindow+MTExtension.swift
//  MobileTrading
//
//  Created by Nguyen Minh on 4/8/17.
//  Copyright © 2017 AHDEnglish. All rights reserved.
//

import UIKit

extension UIWindow {
    public func sp_set(rootViewController newRootVC: UIViewController, withTransition transition: CATransition? = nil) {
        let previousViewController = rootViewController
        if let transition = transition {
            // Add the transition
            layer.add(transition, forKey: kCATransition)
        }
        rootViewController = newRootVC
        // Update status bar appearance using the new view controllers appearance - animate if needed
        if UIView.areAnimationsEnabled {
            UIView.animate(withDuration: CATransaction.animationDuration()) {
                newRootVC.setNeedsStatusBarAppearanceUpdate()
            }
        } else {
            newRootVC.setNeedsStatusBarAppearanceUpdate()
        }
        /// The presenting view controllers view doesn't get removed from the window as its currently transistioning and presenting a view controller
        if let transitionViewClass = NSClassFromString("UITransitionView") {
            for subview in subviews where subview.isKind(of: transitionViewClass) {
                subview.removeFromSuperview()
            }
        }
        if let previousViewController = previousViewController {
            // Allow the view controller to be deallocated
            previousViewController.dismiss(animated: false) {
                // Remove the root view in case its still showing
                previousViewController.view.removeFromSuperview()
            }
        }
    }
}
