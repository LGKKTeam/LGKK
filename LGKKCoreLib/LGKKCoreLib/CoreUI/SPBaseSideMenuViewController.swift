//
//  SPBaseSideMenuViewController.swift
//  spDirect
//
//  Created by Admin on 2/19/17.
//  Copyright © 2017 SiliconPrime. All rights reserved.
//

import UIKit
import LGSideMenuController
import CocoaLumberjack

public enum SPSideMenuStyle {
    case normal
    case scaleFromBig
    case slideAbove
    case slideBelow
    case scaleFromLitter
    case blurredRootViewCover
    case blurrSideViewCover
    case blurrSideViewBackground
    case lanscapeAlwayVisible
    case statusBarAlwayVisible
    case gestureAreaFullScreen
    case custom
}

open class SPBaseSideMenuViewController: LGSideMenuController {
    
    fileprivate var type: SPSideMenuStyle?
    
    deinit {
        DDLogDebug("Deinit \(self)")
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
        setupSideMenu(type: .normal)
    }
}

extension SPBaseSideMenuViewController {
    fileprivate func setupSideMenu(type: SPSideMenuStyle) {
        self.type = type
        
        let greenCoverColor = UIColor(red: 0.0, green: 0.1, blue: 0.0, alpha: 0.3)
        let purpleCoverColor = UIColor(red: 0.1, green: 0.0, blue: 0.1, alpha: 0.3)
        let regularStyle: UIBlurEffectStyle
        
        if #available(iOS 10.0, *) {
            regularStyle = .regular
        }
        else {
            regularStyle = .light
        }
        
        leftViewWidth = UIScreen.main.bounds.size.width*0.8;
        leftViewBackgroundColor = UIColor(red: 0.5, green: 0.6, blue: 0.5, alpha: 0.9)
        
        rightViewWidth = 100.0;
        rightViewBackgroundColor = UIColor(red: 0.6, green: 0.5, blue: 0.6, alpha: 0.9)
        rootViewCoverColorForRightView = UIColor(red: 1.0, green: 0.0, blue: 1.0, alpha: 0.05)
        
        switch type {
        case .scaleFromBig:
            leftViewPresentationStyle = .scaleFromBig
            rightViewPresentationStyle = .scaleFromBig
            break
        case .slideAbove:
            leftViewPresentationStyle = .slideAbove
            rootViewCoverColorForLeftView = greenCoverColor
            
            rightViewPresentationStyle = .slideAbove
            rootViewCoverColorForRightView = purpleCoverColor
            
            break
        case .slideBelow:
            leftViewPresentationStyle = .slideBelow
            rightViewPresentationStyle = .slideBelow
            
            break
        case .scaleFromLitter:
            leftViewPresentationStyle = .scaleFromLittle
            rightViewPresentationStyle = .scaleFromLittle
            
            break
        case .blurredRootViewCover:
            leftViewPresentationStyle = .scaleFromBig
            rootViewCoverBlurEffectForLeftView = UIBlurEffect(style: regularStyle)
            rootViewCoverAlphaForLeftView = 0.8
            
            rightViewPresentationStyle = .scaleFromBig
            rootViewCoverBlurEffectForRightView = UIBlurEffect(style: regularStyle)
            rootViewCoverAlphaForRightView = 0.8
            
            break
        case .blurrSideViewCover:
            leftViewPresentationStyle = .scaleFromBig
            leftViewCoverBlurEffect = UIBlurEffect(style: .dark)
            leftViewCoverColor = nil
            
            rightViewPresentationStyle = .scaleFromBig
            rightViewCoverBlurEffect = UIBlurEffect(style: .dark)
            rightViewCoverColor = nil
            
            break
        case .blurrSideViewBackground:
            leftViewPresentationStyle = .slideAbove
            leftViewBackgroundBlurEffect = UIBlurEffect(style: regularStyle)
            leftViewBackgroundColor = UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 0.05)
            rootViewCoverColorForLeftView = greenCoverColor
            
            rightViewPresentationStyle = .slideAbove
            rightViewBackgroundBlurEffect = UIBlurEffect(style: regularStyle)
            rightViewBackgroundColor = UIColor(red: 1.0, green: 0.0, blue: 1.0, alpha: 0.05)
            rootViewCoverColorForRightView = purpleCoverColor
            
            break
        case .lanscapeAlwayVisible:
            leftViewPresentationStyle = .slideAbove
            leftViewAlwaysVisibleOptions = [.onPhoneLandscape, .onPadLandscape]
            
            rightViewPresentationStyle = .slideBelow
            rightViewAlwaysVisibleOptions = [.onPhoneLandscape, .onPadLandscape]
            
            break
        case .statusBarAlwayVisible:
            leftViewPresentationStyle = .scaleFromBig
            leftViewStatusBarStyle = .lightContent
            
            rightViewPresentationStyle = .scaleFromBig
            rightViewStatusBarStyle = .lightContent
            
            break
        case .gestureAreaFullScreen:
            swipeGestureArea = .full
            
            leftViewPresentationStyle = .scaleFromBig
            rightViewPresentationStyle = .scaleFromBig
            
            break
        case .custom:
            leftViewSwipeGestureRange = LGSideMenuSwipeGestureRangeMake(0.0, 88.0)
            leftViewPresentationStyle = .scaleFromBig
            leftViewAnimationSpeed = 0.3
            leftViewInitialOffsetX = 100
            rootViewScaleForLeftView = 1
            break
        default:
            leftViewPresentationStyle = .slideBelow
            rightViewPresentationStyle = .slideBelow
            break
        }
    }
    
    override open func leftViewWillLayoutSubviews(with size: CGSize) {
        super.leftViewWillLayoutSubviews(with: size)
        
        if !isLeftViewStatusBarHidden {
            leftView?.frame = CGRect(x: 0.0, y: 20.0, width: size.width, height: size.height - 20.0)
        }
    }
    
    override open func rightViewWillLayoutSubviews(with size: CGSize) {
        super.rightViewWillLayoutSubviews(with: size)
        
        if (!isRightViewStatusBarHidden ||
            (rightViewAlwaysVisibleOptions.contains(.onPadLandscape) &&
                UI_USER_INTERFACE_IDIOM() == .pad &&
                UIInterfaceOrientationIsLandscape(UIApplication.shared.statusBarOrientation))) {
            rightView?.frame = CGRect(x: 0.0, y: 20.0, width: size.width, height: size.height - 20.0)
        }
    }
    
    override open var isLeftViewStatusBarHidden: Bool {
        get {
            if (self.type == SPSideMenuStyle.statusBarAlwayVisible) {
                return UIInterfaceOrientationIsLandscape(UIApplication.shared.statusBarOrientation) && UI_USER_INTERFACE_IDIOM() == .phone
            }
            
            return super.isLeftViewStatusBarHidden
        }
        
        set {
            super.isLeftViewStatusBarHidden = newValue
        }
    }
    
    override open var isRightViewStatusBarHidden: Bool {
        get {
            if (self.type == SPSideMenuStyle.statusBarAlwayVisible) {
                return UIInterfaceOrientationIsLandscape(UIApplication.shared.statusBarOrientation) && UI_USER_INTERFACE_IDIOM() == .phone
            }
            
            return super.isRightViewStatusBarHidden
        }
        
        set {
            super.isRightViewStatusBarHidden = newValue
        }
    }
}
