//
//  SPLoader.swift
//  SPCorelib
//
//  Created by Nguyen Minh on 5/22/17.
//  Copyright © 2017 SP. All rights reserved.
//

import UIKit

@objc public protocol ListLoadable {
    func ld_visibleContentViews() -> [UIView]
    func ld_visibleContentViews(_ indexPaths: [IndexPath]) -> [UIView]
    func ld_fakeVisibleContentViews(_ completed: @escaping ([UIView]) -> Void)
    
    func ld_numberOfItemsInSection(_ section: Int, realItem: Int) -> Int
    func ld_numberOfSections(realNumber: Int) -> Int
    func ld_heightForHeaderInSection(realNumber: CGFloat) -> CGFloat
    func ld_heightForFooterInSection(realNumber: CGFloat) -> CGFloat
}

extension UITableView : ListLoadable {
    
    public func ld_heightForFooterInSection(realNumber: CGFloat) -> CGFloat {
        return isAnimationLoader ? 0 : realNumber
    }

    public func ld_heightForHeaderInSection(realNumber: CGFloat) -> CGFloat {
        return isAnimationLoader ? 0 : realNumber
    }
    
    public func ld_numberOfItemsInSection(_ section: Int, realItem: Int) -> Int {
        return realItem + (isAnimationLoader ? SPLoader.numfakeCells : 0)
    }
    
    public func ld_numberOfSections(realNumber: Int) -> Int {
        if realNumber > 0 {
            return realNumber
        }
        return 1
    }
    
    public func ld_visibleContentViews() -> [UIView] {
        if let views = (self.visibleCells as NSArray).value(forKey: "contentView") as? [UIView] {
            return views
        } else {
            fatalError("Error while get contentView")
        }
    }
    
    public func ld_visibleContentViews(_ indexPaths: [IndexPath]) -> [UIView] {
        var views: [UIView] = []
        for indexPath in indexPaths {
            if let cell = self.cellForRow(at: indexPath) {
                views.append(cell.contentView)
            }
        }
        return views
    }
    
    public func ld_fakeVisibleContentViews(_ completed: @escaping ([UIView]) -> Void) {
        let section = lastSection
        let skip = !(ld_visibleContentViews().isEmpty) ? numberOfRows(inSection: section) : 0
        let indexPaths = (skip..<skip + SPLoader.numfakeCells).map { IndexPath(row: $0, section: section) }
        beginUpdates()
        isAnimationLoader = true
        insertRows(at: indexPaths, with: .automatic)
        endUpdates()
        
        if let index = indexPaths.first {
            scrollToRow(at: index, at: .top, animated: true)
        }
        let views = ld_visibleContentViews(indexPaths)
        completed(views)
    }
}

extension UICollectionView : ListLoadable {
    
    public func ld_heightForFooterInSection(realNumber: CGFloat) -> CGFloat {
        return isAnimationLoader ? 0 : realNumber
    }
    
    public func ld_heightForHeaderInSection(realNumber: CGFloat) -> CGFloat {
        return isAnimationLoader ? 0 : realNumber
    }
    
    public func ld_numberOfItemsInSection(_ section: Int, realItem: Int) -> Int {
        return realItem + (isAnimationLoader ? SPLoader.numfakeCells : 0)
    }
    
    public func ld_numberOfSections(realNumber: Int) -> Int {
        if realNumber > 0 {
            return realNumber
        }
        return isAnimationLoader ? 1 : 0
    }
    
    public func ld_visibleContentViews() -> [UIView] {
        if let views = (self.visibleCells as NSArray).value(forKey: "contentView") as? [UIView] {
            return views
        } else {
            fatalError("Error while get contentView")
        }
    }
    
    public func ld_visibleContentViews(_ indexPaths: [IndexPath]) -> [UIView] {
        var views: [UIView] = []
        for indexPath in indexPaths {
            if let cell = self.cellForItem(at: indexPath) {
                views.append(cell.contentView)
            }
        }
        return views
    }
    
    public func ld_fakeVisibleContentViews(_ completed: @escaping ([UIView]) -> Void) {
        let section = lastSection
        let skip = !(ld_visibleContentViews().isEmpty) ? numberOfItems(inSection: section) : 0
        let indexPaths = (skip..<skip + SPLoader.numfakeCells).map { IndexPath(row: $0, section: section) }
        performBatchUpdates({ [unowned self] in
            self.isAnimationLoader = true
            self.insertItems(at: indexPaths)
        }) { [unowned self] (_) in
            if let index = indexPaths.first {
                self.scrollToItem(at: index, at: .top, animated: true)
            }
            let views = self.ld_visibleContentViews(indexPaths)
            completed(views)
        }
    }
}

// swiftlint:disable object_literal
extension UIColor {
    static func backgroundFadedGrey() -> UIColor {
        return UIColor(red: (246.0 / 255.0), green: (247.0 / 255.0), blue: (248.0 / 255.0), alpha: 1)
    }
    
    static func gradientFirstStop() -> UIColor {
        return  UIColor(red: (238.0 / 255.0), green: (238.0 / 255.0), blue: (238.0 / 255.0), alpha: 1.0)
    }
    
    static func gradientSecondStop() -> UIColor {
        return UIColor(red: (221.0 / 255.0), green: (221.0 / 255.0), blue:(221.0 / 255.0), alpha: 1.0)
    }
}

extension UIView {
    func boundInside(_ superView: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        superView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[subview]-0-|",
                                                                options: NSLayoutFormatOptions(),
                                                                metrics:nil,
                                                                views:["subview":self]))
        superView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[subview]-0-|",
                                                                options: NSLayoutFormatOptions(),
                                                                metrics:nil,
                                                                views:["subview":self]))
    }
}

open class SPLoader {
    public static let numfakeCells = 2 // why?, because I like it.
    
    static func addLoaderToViews(_ views : [UIView]) {
        CATransaction.begin()
        views.forEach { $0.ld_addLoader() }
        CATransaction.commit()
    }
    
    static func removeLoaderFromViews(_ views: [UIView]) {
        CATransaction.begin()
        views.forEach { $0.ld_removeLoader() }
        CATransaction.commit()
    }
    
    open static func addLoaderTo(_ list: ListLoadable, reload: Bool = true, completed: @escaping () -> Void) {
        let views = list.ld_visibleContentViews()
        if !views.isEmpty, reload {
            completed()
            return
        }
        
        if let list = list as? UIScrollView {
            list.isUserInteractionEnabled = !reload
        }
        
        if views.isEmpty || !reload {
            list.ld_fakeVisibleContentViews({ (viewsx) in
                if let list = list as? UIScrollView {
                    list.rawContentViews = viewsx
                }
                self.addLoaderToViews(viewsx)
                completed()
            })
        } else {
            if let list = list as? UIScrollView {
                list.isUserInteractionEnabled = !reload
                list.isAnimationLoader = true
                list.rawContentViews = views
            }
            
            self.addLoaderToViews(views)
            completed()
        }
    }
    
    open static func removeLoaderFrom(_ list : ListLoadable) {
        if let list = list as? UIScrollView {
            list.isAnimationLoader = false
            list.isUserInteractionEnabled = true
        }
        
        self.removeLoaderFromViews(list.ld_visibleContentViews())
        
        // Fixbug:
        if let list = list as? UIScrollView, let rawContentViews = list.rawContentViews {
            rawContentViews.forEach({ (view) in
                view.ld_removeLoader()
            })
            list.rawContentViews?.removeAll()
            list.rawContentViews = nil
        }
    }
}

class CutoutView: UIView {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(UIColor.white.cgColor)
        context?.fill(self.bounds)
        
        if let subviews = self.superview?.subviews {
            for view in subviews where view != self {
                context?.setBlendMode(.clear)
                context?.setFillColor(UIColor.clear.cgColor)
                context?.fill(view.frame)
            }
        }
    }
    
    override func layoutSubviews() {
        self.setNeedsDisplay()
        if let bounds = self.superview?.bounds {
            self.superview?.ldGradient?.frame = bounds
        }
    }
}

// TODO :- Allow caller to tweak these
var loaderDuration = 0.85
var gradientWidth = 0.17
var gradientFirstStop = 0.1

extension CGFloat {
    fileprivate func doubleValue() -> Double {
        return Double(self)
    }
}

extension UIView {
    
    private struct AssociatedKeys {
        static var cutoutHandle = "AssociatedKeys.cutoutHandle"
        static var gradientHandle = "AssociatedKeys.gradientHandle"
    }
    
    fileprivate var ldCutoutView: UIView? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.cutoutHandle) as? UIView
        }
        set(newValue) {
            let policy = objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN
            objc_setAssociatedObject(self, &AssociatedKeys.cutoutHandle, newValue, policy)
        }
    }
    
    fileprivate var ldGradient: CAGradientLayer? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.gradientHandle) as? CAGradientLayer
        }
        set(newValue) {
            let policy = objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN
            objc_setAssociatedObject(self, &AssociatedKeys.gradientHandle, newValue, policy)
        }
    }
    
    public func ld_addLoader() {
        ldGradient?.removeAllAnimations()
        ldGradient?.removeFromSuperlayer()
        
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
        self.layer.insertSublayer(gradient, at:0)
        
        self.configureAndAddAnimationToGradient(gradient)
        self.addCutoutView()
    }
    
    public func ld_removeLoader() {
        self.ldCutoutView?.removeFromSuperview()
        self.ldGradient?.removeAllAnimations()
        self.ldGradient?.removeFromSuperlayer()
        
        for view in self.subviews {
            view.alpha = 1
        }
    }
    
    fileprivate func configureAndAddAnimationToGradient(_ gradient : CAGradientLayer) {
        gradient.startPoint = CGPoint(x: -1.0 + CGFloat(gradientWidth), y: 0)
        gradient.endPoint = CGPoint(x: 1.0 + CGFloat(gradientWidth), y: 0)
        gradient.colors = [
            UIColor.backgroundFadedGrey().cgColor,
            UIColor.gradientFirstStop().cgColor,
            UIColor.gradientSecondStop().cgColor,
            UIColor.gradientFirstStop().cgColor,
            UIColor.backgroundFadedGrey().cgColor
        ]
        
        let startLocations = [
            NSNumber(value: gradient.startPoint.x.doubleValue() as Double),
            NSNumber(value: gradient.startPoint.x.doubleValue() as Double),
            NSNumber(value: 0 as Double),
            NSNumber(value: gradientWidth as Double),
            NSNumber(value: 1 + gradientWidth as Double)
        ]
        
        gradient.locations = startLocations
        let gradientAnimation = CABasicAnimation(keyPath: "locations")
        gradientAnimation.fromValue = startLocations
        gradientAnimation.toValue = [
            NSNumber(value: 0 as Double),
            NSNumber(value: 1 as Double),
            NSNumber(value: 1 as Double),
            NSNumber(value: 1 + (gradientWidth - gradientFirstStop) as Double),
            NSNumber(value: 1 + gradientWidth as Double)
        ]
        
        gradientAnimation.repeatCount = Float.infinity
        gradientAnimation.fillMode = kCAFillModeForwards
        gradientAnimation.isRemovedOnCompletion = false
        gradientAnimation.duration = loaderDuration
        gradient.add(gradientAnimation, forKey:"locations")
        
        self.ldGradient = gradient
    }
    
    fileprivate func addCutoutView() {
        ldCutoutView?.removeFromSuperview()
        
        let cutout = CutoutView()
        cutout.frame = self.bounds
        cutout.backgroundColor = UIColor.clear
        
        self.addSubview(cutout)
        cutout.setNeedsDisplay()
        cutout.boundInside(self)
        
        for view in self.subviews where view != cutout {
            view.alpha = 0
        }
        
        self.ldCutoutView = cutout
    }
}

extension UIScrollView {
    private struct AssociatedKeys {
        static var usingSPLoaderHandle = "AssociatedKeys.usingSPLoaderHandle"
        static var contentViewHandle = "AssociatedKeys.contentViewHandle"
    }
    
    fileprivate var rawContentViews: [UIView]? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.contentViewHandle) as? [UIView]
        }
        set(newValue) {
            let policy = objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN
            objc_setAssociatedObject(self, &AssociatedKeys.contentViewHandle, newValue, policy)
        }
    }
    
    public var isAnimationLoader: Bool {
        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys.usingSPLoaderHandle) as? Bool) ?? false
        }
        set(newValue) {
            let policy = objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN
            objc_setAssociatedObject(self, &AssociatedKeys.usingSPLoaderHandle, newValue, policy)
        }
    }
}
