//
//  Badge.swift
//  Extensions for Rounded UILabel and UIButton, Badged UIBarButtonItem.
//
//  Usage:
//      let label = UILabel(badgeText: "Rounded Label");
//      let button = UIButton(type: .System); button.rounded = true
//      let barButton = UIBarButtonItem(badge: "42", title: "How Many Roads", target: self, action: "answer")
//
//  Created by Yonat Sharon on 06.04.2015.
//  Copyright (c) 2015 Yonat Sharon. All rights reserved.
//

import UIKit

public extension UILabel {
    public convenience init(badgeText: String, color: UIColor = UIColor(hex: "FE0555"), fontSize: CGFloat = UIFont.smallSystemFontSize) {
        self.init()
        text = " \(badgeText) "
        textColor = UIColor.white
        backgroundColor = color
        
        font = UIFont.systemFont(ofSize: fontSize)
        layer.cornerRadius = fontSize * CGFloat(0.6)
        clipsToBounds = true
        
        translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: self, attribute: .width, relatedBy: .greaterThanOrEqual, toItem: self, attribute: .height, multiplier: 1, constant: 0))
    }
}

public extension UIBarButtonItem {
    public convenience init(badge: String?, button: UIButton, target: AnyObject?, action: Selector) {
        button.addTarget(target, action: action, for: .touchUpInside)
        button.sizeToFit()
        
        let badgeLabel = UILabel(badgeText: badge ?? "")
        button.addSubview(badgeLabel)
        button.addConstraint(NSLayoutConstraint(item: badgeLabel, attribute: .top, relatedBy: .equal, toItem: button, attribute: .top, multiplier: 1, constant: -8))
        button.addConstraint(NSLayoutConstraint(item: badgeLabel, attribute: .right, relatedBy: .equal, toItem: button, attribute: .right, multiplier: 1, constant: 8))
        if nil == badge {
            badgeLabel.isHidden = true
        }
        badgeLabel.tag = UIBarButtonItem.badgeTag
        
        self.init(customView: button)
    }
    
    public convenience init(badge: String?, image: UIImage, target: AnyObject?, action: Selector) {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y:0, width:image.size.width, height:image.size.height)
        button.setBackgroundImage(image, for: .normal)
        
        self.init(badge: badge, button: button, target: target, action: action)
    }
    
    public convenience init(badge: String?, title: String, target: AnyObject?, action: Selector) {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: UIFont.buttonFontSize)
        
        self.init(badge: badge, button: button, target: target, action: action)
    }
    
    public var badgeLabel: UILabel? {
        return customView?.viewWithTag(UIBarButtonItem.badgeTag) as? UILabel
    }
    
    public var badgedButton: UIButton? {
        return customView as? UIButton
    }
    
    public var badgeString: String? {
        get { return badgeLabel?.text?.trimmingCharacters(in: NSCharacterSet.whitespaces) }
        set {
            if let badgeLabel = badgeLabel {
                badgeLabel.text = nil == newValue ? nil : " \(newValue!) "
                badgeLabel.sizeToFit()
                badgeLabel.isHidden = nil == newValue
            }
        }
    }
    
    public var badgedTitle: String? {
        get { return badgedButton?.title(for: .normal) }
        set { badgedButton?.setTitle(newValue, for: .normal); badgedButton?.sizeToFit() }
    }
    
    private static let badgeTag = 7373
}

extension UIButton {
    /// show background as rounded rect, like mail addressees
    public var rounded: Bool {
        get { return layer.cornerRadius > 0 }
        set { roundWithTitleSize(size: newValue ? titleSize : 0) }
    }
    
    /// removes other title attributes
    public var titleSize: CGFloat {
        get {
            let titleFont = attributedTitle(for: .normal)?.attribute(NSFontAttributeName, at: 0, effectiveRange: nil) as? UIFont
            return titleFont?.pointSize ?? UIFont.buttonFontSize
        }
        set {
            // TODO: use current attributedTitleForState(.Normal) if defined
            if UIFont.buttonFontSize == newValue || 0 == newValue {
                setTitle(currentTitle, for: .normal)
            }
            else {
                let attrTitle = NSAttributedString(string: currentTitle ?? "", attributes:
                    [NSFontAttributeName: UIFont.systemFont(ofSize: newValue), NSForegroundColorAttributeName: currentTitleColor]
                )
                setAttributedTitle(attrTitle, for: .normal)
            }
            
            if rounded {
                roundWithTitleSize(size: newValue)
            }
        }
    }
    
    public func roundWithTitleSize(size: CGFloat) {
        let padding = size / 4
        layer.cornerRadius = padding + size * 1.2 / 2
        let sidePadding = padding * 1.5
        contentEdgeInsets = UIEdgeInsets(top: padding, left: sidePadding, bottom: padding, right: sidePadding)
        
        if size.isZero {
            backgroundColor = UIColor.clear
            setTitleColor(tintColor, for: .normal)
        }
        else {
            backgroundColor = tintColor
            let currentTitleColor = titleColor(for: .normal)
            if currentTitleColor == nil || currentTitleColor == tintColor {
                setTitleColor(UIColor.white, for: .normal)
            }
        }
    }
    
    override open func tintColorDidChange() {
        super.tintColorDidChange()
        if rounded {
            backgroundColor = tintColor
        }
    }
}
