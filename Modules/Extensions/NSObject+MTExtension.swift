//
//  NSObject+MTExtension.swift
//  MobileTrading
//
//  Created by Nguyen Minh on 4/8/17.
//  Copyright © 2017 AHDEnglish. All rights reserved.
//

import UIKit
import ObjectiveC

final class Lifted<T> {
    let value: T
    init(_ x: T) {
        value = x
    }
}

private func lift<T>(x: T) -> Lifted<T>  {
    return Lifted(x)
}

public func setAssociated<T>(object: AnyObject, value: T?, associativeKey: UnsafeRawPointer, policy: objc_AssociationPolicy) {
    if let value = value {
        objc_setAssociatedObject(object, associativeKey, value,  policy)
        guard let _ = objc_getAssociatedObject(object, associativeKey) as? T else {
            objc_setAssociatedObject(object, associativeKey, lift(x: value),  policy)
            return
        }
    } else {
        objc_setAssociatedObject(object, associativeKey, nil,  policy)
    }
}

public func getAssociated<T>(object: AnyObject, associativeKey: UnsafeRawPointer) -> T? {
    if let v = objc_getAssociatedObject(object, associativeKey) as? T {
        return v
    }
    else if let v = objc_getAssociatedObject(object, associativeKey) as? Lifted<T> {
        return v.value
    }
    else {
        return nil
    }
}

//MARK: - NSObject extension
extension NSObject {
    private struct AssociatedKeys {
        static var weakTimer = "AssociatedKeys.Timer"
    }
    
    fileprivate var weaktimer: Timer? {
        get {
            return getAssociated(object: self, associativeKey: &AssociatedKeys.weakTimer)
        }
        set {
            setAssociated(object: self, value: newValue, associativeKey: &AssociatedKeys.weakTimer, policy: objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func scheduleUpdate(repeatInterval interval: TimeInterval, handler:@escaping (AnyObject, Timer) -> Void) -> Timer? {
        stopScheduleUpdate()
        weaktimer = Timer.schedule(repeatInterval: interval) {[weak self] (timer) in
            if self != nil {
                handler(self!, timer!)
            } else {
                timer?.invalidate()
            }
        }
        return weaktimer
    }
    
    func scheduleUpdate(delay: TimeInterval, handler:@escaping (AnyObject, Timer) -> Void) -> Timer? {
        stopScheduleUpdate()
        weaktimer = Timer.schedule(delay: delay, handler: {[weak self] (timer) in
            if self != nil {
                handler(self!, timer!)
            } else {
                timer?.invalidate()
            }
        })
        return weaktimer
    }
    
    func stopScheduleUpdate() {
        if let weaktimer = weaktimer {
            weaktimer.invalidate()
        }
    }
}

//MARK: - Timer extension
extension Timer {
    class func schedule(delay: TimeInterval, handler: ((Timer?) -> Void)!) -> Timer! {
        let fireDate = delay + CFAbsoluteTimeGetCurrent()
        let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, 0, 0, 0, handler)
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, .commonModes)
        return timer
    }
    
    class func schedule(repeatInterval interval: TimeInterval, handler: ((Timer?) -> Void)!) -> Timer! {
        let fireDate = interval + CFAbsoluteTimeGetCurrent()
        let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, interval, 0, 0, handler)
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, .commonModes)
        return timer
    }
}
