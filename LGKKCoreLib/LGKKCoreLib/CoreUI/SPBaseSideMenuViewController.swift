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
    private func decoSomeType(_ type: SPSideMenuStyle) {
        switch type {
        case .scaleFromBig:
            leftViewPresentationStyle = .scaleFromBig
            rightViewPresentationStyle = .scaleFromBig
            break
        case .slideBelow:
            leftViewPresentationStyle = .slideBelow
            rightViewPresentationStyle = .slideBelow
            break
        case .scaleFromLitter:
            leftViewPresentationStyle = .scaleFromLittle
            rightViewPresentationStyle = .scaleFromLittle
            break
        case .blurrSideViewCover:
            leftViewPresentationStyle = .scaleFromBig
            leftViewCoverBlurEffect = UIBlurEffect(style: .dark)
            leftViewCoverColor = nil
            rightViewPresentationStyle = .scaleFromBig
            rightViewCoverBlurEffect = UIBlurEffect(style: .dark)
            rightViewCoverColor = nil
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
        default: break
        }
    }
    
    private func decoView(type: SPSideMenuStyle, regularStyle: UIBlurEffectStyle) {
        let greenCoverColor = UIColor.green.withAlphaComponent(0.3)
        let purpleCoverColor = UIColor.purple.withAlphaComponent(0.3)
        decoSomeType(type)
        
        switch type {
        case .slideAbove:
            leftViewPresentationStyle = .slideAbove
            rootViewCoverColorForLeftView = greenCoverColor
            rightViewPresentationStyle = .slideAbove
            rootViewCoverColorForRightView = purpleCoverColor
            break
        case .blurredRootViewCover:
            leftViewPresentationStyle = .scaleFromBig
            rootViewCoverBlurEffectForLeftView = UIBlurEffect(style: regularStyle)
            rootViewCoverAlphaForLeftView = 0.8
            rightViewPresentationStyle = .scaleFromBig
            rootViewCoverBlurEffectForRightView = UIBlurEffect(style: regularStyle)
            rootViewCoverAlphaForRightView = 0.8
            break
        case .blurrSideViewBackground:
            leftViewPresentationStyle = .slideAbove
            leftViewBackgroundBlurEffect = UIBlurEffect(style: regularStyle)
            leftViewBackgroundColor = UIColor.green.withAlphaComponent(0.05)
            rootViewCoverColorForLeftView = greenCoverColor
            rightViewPresentationStyle = .slideAbove
            rightViewBackgroundBlurEffect = UIBlurEffect(style: regularStyle)
            rightViewBackgroundColor = UIColor.purple.withAlphaComponent(0.05)
            rootViewCoverColorForRightView = purpleCoverColor
            break
        case .lanscapeAlwayVisible:
            leftViewPresentationStyle = .slideAbove
            leftViewAlwaysVisibleOptions = [.onPhoneLandscape, .onPadLandscape]
            rightViewPresentationStyle = .slideBelow
            rightViewAlwaysVisibleOptions = [.onPhoneLandscape, .onPadLandscape]
            break
        default:
            leftViewPresentationStyle = .slideBelow
            rightViewPresentationStyle = .slideBelow
        }
    }
    
    fileprivate func setupSideMenu(type: SPSideMenuStyle) {
        let regularStyle: UIBlurEffectStyle
        if #available(iOS 10.0, *) {
            regularStyle = .regular
        } else {
            regularStyle = .light
        }
        self.type = type
        leftViewWidth = UIScreen.main.bounds.size.width * 0.8
        leftViewBackgroundColor = UIColor.gray.withAlphaComponent(0.9)
        rightViewWidth = 100.0
        rightViewBackgroundColor = UIColor.gray.withAlphaComponent(0.9)
        rootViewCoverColorForRightView = UIColor.purple.withAlphaComponent(0.05)
        decoView(type: type, regularStyle: regularStyle)
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
    
    private func isLandscape(orientaion: UIInterfaceOrientation) -> Bool {
        return UIInterfaceOrientationIsLandscape(orientaion)
    }
    
    override open var isLeftViewStatusBarHidden: Bool {
        get {
            if (self.type == SPSideMenuStyle.statusBarAlwayVisible) {
                let statusBarOrientation = UIApplication.shared.statusBarOrientation
                return isLandscape(orientaion: statusBarOrientation) && UI_USER_INTERFACE_IDIOM() == .phone
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
                let statusBarOrientation = UIApplication.shared.statusBarOrientation
                return isLandscape(orientaion: statusBarOrientation) && UI_USER_INTERFACE_IDIOM() == .phone
            }
            
            return super.isRightViewStatusBarHidden
        }
        
        set {
            super.isRightViewStatusBarHidden = newValue
        }
    }
}
