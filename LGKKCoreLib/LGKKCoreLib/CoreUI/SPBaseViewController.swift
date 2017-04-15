//
//  SPBaseViewController.swift
//  spDirect
//
//  Created by HoangHo on 2/14/17.
//  Copyright © 2017 SiliconPrime. All rights reserved.
//

import UIKit
import Spring
import CocoaLumberjack
import TYAlertController
import LGSideMenuController
import CNPPopupController
import ReSwift
import DZNEmptyDataSet
import SCLAlertView
import CoreGraphics
import MBProgressHUD
import ObjectMapper
import SwiftMessages
import SnapKit
import Moya
import Realm
import RealmSwift
import SwifterSwift


@objc public protocol CustomAlertPrc {
    @objc optional func formatCustomAlertTitle(_ lbl: UILabel)
    @objc optional func formatCustomAlertSubTitle(_ lbl: UILabel)
    @objc optional func formatCustomAlertPrimaryButton(_ btn: UIButton)
    @objc optional func formatCustomAlertNormalButton(_ btn: UIButton)
}

extension Moya.Cancellable {
    public func subscribe(viewController: SPBaseViewController) {
        viewController.startMonitor(cancellable: self)
    }
}

open class SPBaseViewController: UIViewController, StoreSubscriber {
    private var cancellables: [Cancellable] = [] //Solve problem when viewController deinit before request success!
    func cancelAllMoyaRequest() {
        for cancellable in cancellables {
            if cancellable.isCancelled == false {
                cancellable.cancel()
            }
        }
        cancellables.removeAll()
    }
    
    fileprivate func startMonitor(cancellable: Moya.Cancellable) {
        cancellables.append(cancellable)
    }
    
    open var cnpPopupController: CNPPopupController?
    
    public func newState(state: StateType) {
        //NOP
    }
    
    func forceRotate(mode: UIInterfaceOrientation) {
//        UIApplication.shared.setStatusBarOrientation(mode, animated: false)        
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        mainStore.unsubscribe(self)
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        mainStore.subscribe(self)
        
        //Default < button
        let backItem = UIBarButtonItem.init(image: UIImage.init(named: "back"), style: .done, target: self, action: #selector(back_Tapped(_:)))
        self.navigationItem.leftBarButtonItem = backItem
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
    }
    
    deinit {
        DDLogDebug("Deinit \(self)")
        self.removeNotificationObserver(name: .UIKeyboardWillChangeFrame)
        self.removeNotificationObserver(name: .UIKeyboardWillHide)
        self.removeNotificationObserver(name: .UIKeyboardWillShow)
        self.removeNotificationObserver(name: .UIKeyboardDidHide)
        self.removeNotificationObserver(name: .UIKeyboardDidShow)
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        self.cancelAllMoyaRequest()
    }

    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        DDLogWarn("MemoryWarning!")
    }
    
    open func processFailure(message: String) {
        let error = MessageView.viewFromNib(layout: .MessageView)
        error.configureTheme(.error)
        error.configureContent(title: "", body: message)
        error.button?.isHidden = true
        error.configureDropShadow()
        var config = SwiftMessages.defaultConfig
        config.presentationContext = SwiftMessages.PresentationContext.viewController(self)
        error.backgroundColor = UIColor.white
        error.titleLabel?.textColor = UIColor.init(hex: "#FD5F61")
        error.bodyLabel?.textColor = UIColor.init(hex: "#FD5F61")
        error.iconImageView?.image = UIImage(named: "delete")?.filled(withColor: UIColor.red)
        SwiftMessages.show(config: config, view: error)
    }
    
    open func setIdleTimerActive(_ active: Bool) {
        UIApplication.shared.isIdleTimerDisabled = !active
    }
}

// MARK: - Alert View
extension SPBaseViewController: CustomAlertPrc {
    
    public func formatCustomAlertTitle(_ lbl: UILabel) {
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
//        lbl.stylize(SPLabelStyle.normal)
    }
    
    public func formatCustomAlertSubTitle(_ lbl: UILabel) {
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
//        lbl.stylize(SPLabelStyle.normal)
    }
    
    public func formatCustomAlertNormalButton(_ btn: UIButton) {
        
    }
    
    public func formatCustomAlertPrimaryButton(_ btn: UIButton) {
        
    }
    
    public func showAlertView(title: String?, message: String?, actions: [UIAlertAction]?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        if let actions = actions {
            for action in actions {
                alert.addAction(action)
            }
        }
        
        alert.show(animated: true, vibrate: true, completion: nil)
    }
    
    public func showAlertViewCustom(title: String?, message: String?, actions: [TYAlertAction]?) {
        let alert = TYAlertView(title: title ?? "", message: message ?? "")
        if let actions = actions {
            for action in actions {
                alert?.add(action)
            }
        }
        alert?.showInWindow()
    }
    
    public func showAlertViewCustom2(title: String?, message: String?, actions: [SPAlertAction]?) {
        
        let appearance = SCLAlertView.SCLAppearance.init(
            kDefaultShadowOpacity: 0.7,
            kCircleTopPosition: 0.0,
            kCircleBackgroundTopPosition: 6.0,
            kCircleHeight: 56.0,
            kCircleIconHeight: 20.0,
            kTitleTop: 30.0,
            kTitleHeight: 25.0,
            kWindowWidth: 350.0,
            kWindowHeight: 178.0,
            kTextHeight: 90.0,
            kTextFieldHeight: 45.0,
            kTextViewdHeight: 80.0,
            kButtonHeight: 40.0,
            kTitleFont: UIFont.systemFont(ofSize: 20),
            kTextFont: UIFont.systemFont(ofSize: 14),
            kButtonFont: UIFont.boldSystemFont(ofSize: 14),
            showCloseButton: false,
            showCircularIcon: false,
            shouldAutoDismiss: true,
            contentViewCornerRadius: 5.0,
            fieldCornerRadius: 3.0,
            buttonCornerRadius: 17.5,
            hideWhenBackgroundViewIsTapped: false,
            contentViewColor: UIColor.white,
            contentViewBorderColor: UIColor.gray,
            titleColor: UIColor.black)
        
        let alert = SCLAlertView.init(appearance: appearance)
        if let actions = actions {
            for actionObj in actions {
                _ = alert.addButton(actionObj.title!, backgroundColor: actionObj.backgroundColor, textColor: actionObj.textColor, showDurationStatus: actionObj.showDurationStatus, action: actionObj.action!)
            }
        }
        
        _ = alert.showSuccess(title ?? "", subTitle: message ?? "")
    }
    
    public func showAlertViewCustom3(title: String? = nil,
                              message: String? = nil,
                              customviews: [UIView]? = nil,
                              actions: [SPAlertAction]? = nil) -> CNPPopupController {
        let oldOpUp = self.cnpPopupController
        if oldOpUp != nil {
            oldOpUp?.dismiss(animated: true)
        }
        
        var contents:[UIView] = []
        let minScreenSize = min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)
        let maxWidth = minScreenSize*0.8
        let maxPopWidth = minScreenSize*0.9
        
        if let title = title {
            let topV = UIView(frame: CGRect(x: 0, y: 0, width: maxWidth/2, height: 0))
            topV.backgroundColor = .white
            contents.append(topV)
            
            let vTitle = UIView(frame: CGRect(x: 0, y: 0, width: maxWidth, height: 30))
            contents.append(vTitle)
            
            let lblTit = UILabel(frame: CGRect(x: 0, y: 0, width: maxWidth - 30, height: 30))
            formatCustomAlertTitle(lblTit)
            lblTit.text = title
            vTitle.addSubview(lblTit)
            
            let btnClose = UIButton(type: .custom)
            btnClose.frame = CGRect(x: maxWidth - 30, y: 0, width: 28, height: 28)
            btnClose.setImage(UIImage(named: "delete"), for: .normal)
            btnClose.addTarget(self, action: #selector(closePopupView), for: .touchUpInside)
            vTitle.addSubview(btnClose)
            
            //Add divider line:
            let divider = UIView(frame: CGRect(x: 0, y: 0, width: maxWidth, height: 0.5))
            divider.backgroundColor = UIColor.lightGray
            contents.append(divider)
        }
        if let message = message {
            let lblSubTitle = UILabel()
            formatCustomAlertSubTitle(lblSubTitle)
            lblSubTitle.text = message
            contents.append(lblSubTitle)
        }
        
        if let customviews = customviews {
            for customview in customviews {
                contents.append(customview)
            }
        }
        
        if let actions = actions {
            var buttons = [CNPPopupButton]()
            for (index,actionObj) in actions.enumerated() {
                let button = CNPPopupButton()
                button.setTitle(actionObj.title, for: .normal)
                let selectionHandler: (CNPPopupButton) -> Void = { [unowned self] button in
                    DDLogDebug("Tap button: \(String(describing: button.titleLabel?.text))")
                    self.cnpPopupController?.dismiss(animated: true)
                    actionObj.action?()
                }
                button.selectionHandler = selectionHandler
                if actions.count == 2 {
                    if index == 0 {
                        formatCustomAlertPrimaryButton(button)
                    } else {
                        formatCustomAlertNormalButton(button)
                    }
                } else {
                    formatCustomAlertPrimaryButton(button)
                }
                buttons.append(button)
            }
            
            if #available(iOS 9.0, *) {
                let h = buttons.count < 3 ? maxHeightPopupButton : (maxHeightPopupButton + 4.0) * CGFloat(buttons.count)
                
                let stack = UIStackView(frame: CGRect(x: 0, y: 0, width: maxWidth, height: h))
                stack.axis = actions.count < 3 ? .horizontal : .vertical
                stack.alignment = .fill
                stack.distribution = .fillEqually
                stack.spacing = 8
                for button in buttons.reversed() {
                    stack.addArrangedSubview(button)
                }
                contents.append(stack)
                
                let bottomV = UIView(frame: CGRect(x: 0, y: 0, width: maxWidth/2, height: 0))
                bottomV.backgroundColor = .white
                contents.append(bottomV)
                
            } else {
                // Fallback on earlier versions
                // MINHND: Dont fallback earlier iOS version, because only <1.9%
                // Or just use custom Alert 1 or 2.
            }
            
        }
        
        let popUp = CNPPopupController.init(contents: contents)
        popUp.theme.presentationStyle = .slideInFromTop
        popUp.theme.dismissesOppositeDirection = true
        popUp.theme.maxPopupWidth = maxPopWidth
        popUp.theme.popupContentInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        popUp.theme.popupStyle = .centered
        popUp.delegate = self
        self.cnpPopupController = popUp
        
        if actions == nil || actions?.count == 0 {
            popUp.theme.shouldDismissOnBackgroundTouch = true
        }
        
        popUp.present(animated: true)
        return popUp
    }
    
    public func closePopupView() {
        let oldOpUp = self.cnpPopupController
        if oldOpUp != nil {
            DDLogDebug("Close popupview")
            oldOpUp?.dismiss(animated: true)
        }
    }
}

// MARK: - Side menu viewcontroller
extension SPBaseViewController {
    
    func showLeftView(sender: AnyObject?) {
        sideMenuController?.showLeftView(animated: true, completionHandler: nil)
    }
    
    func showRightView(sender: AnyObject?) {
        sideMenuController?.showRightView(animated: true, completionHandler: nil)
    }
    
    func menu_Tapped(_ sender: AnyObject) {
        showLeftView(sender: sender)
    }
    
    func icon_Tapped(_ sender: AnyObject) {
        //Work as menu tapped for now.
        showLeftView(sender: sender)
    }
    
    func back_Tapped(_ sender: AnyObject) {
        if self.navigationController != nil {
            _ = navigationController!.popViewController(animated: true)
        } else {
            self.dismiss(animated: true)
        }
    }
}

extension SPBaseViewController: CNPPopupControllerDelegate {
    
    public func popupControllerDidDismiss(_ controller: CNPPopupController) {
        
    }
    
    public func popupControllerWillDismiss(_ controller: CNPPopupController) {
        
    }
    
    public func popupControllerDidPresent(_ controller: CNPPopupController) {
        
    }
    
    public func popupControllerWillPresent(_ controller: CNPPopupController) {
        
    }
}

// MARK: - Empty datasource
extension SPBaseViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    public func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let msg = "EmptyDataSet"
        let attributes = [NSFontAttributeName: UIFont.italicSystemFont(ofSize: 17),
                          NSForegroundColorAttributeName: UIColor.gray]
        return NSAttributedString(string: msg, attributes: attributes)
    }
    
    public func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    public func emptyDataSetShouldAllowTouch(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    public func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    ///Need overwrite it in sub-class
    public func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return 0
    }
}


private let maxHeightPopupButton: CGFloat = 40
//For fix cornerRadius issue when using button on UIStackView
extension CNPPopupButton {
    open override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 1
    }
}

// MARK: - Alert struct
public struct SPAlertAction {
    public var title: String?
    public var backgroundColor: UIColor?
    public var textColor: UIColor?
    public var showDurationStatus: Bool = false
    public var action: (() -> Void)?
    
    public init() {}
    
    public init(title: String?, backgroundColor: UIColor?, textColor: UIColor?, showDurationStatus: Bool = false, action: (() -> Void)?) {
        self.title = title
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.showDurationStatus = showDurationStatus
        self.action = action
    }
}
