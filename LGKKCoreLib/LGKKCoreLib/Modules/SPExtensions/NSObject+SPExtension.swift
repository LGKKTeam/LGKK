//
//  NSObject+Extension.swift
//  spDriveThrough
//
//  Created by Nguyen Minh on 3/14/17.
//  Copyright © 2017 Nguyen Minh. All rights reserved.
//

import UIKit
import ObjectiveC

///Speacial work with Timer for interval update content subview.
public extension NSObject {
    private struct AssociatedKeys {
        static var weakTimer = "AssociatedKeys.Timer"
    }
    
    fileprivate var weaktimer: Timer? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.weakTimer) as? Timer
        }
        set(newValue) {
            objc_setAssociatedObject(self, &AssociatedKeys.weakTimer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    public func scheduleUpdate(repeatInterval interval: TimeInterval, handler:@escaping (AnyObject, Timer) -> Void) -> Timer? {
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
    
    public func scheduleUpdate(delay: TimeInterval, handler:@escaping (AnyObject, Timer) -> Void) -> Timer? {
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
    
    public func stopScheduleUpdate() {
        if let weaktimer = weaktimer {
            weaktimer.invalidate()
        }
    }
}

public extension Timer {
    public class func schedule(delay: TimeInterval, handler: ((Timer?) -> Void)!) -> Timer! {
        let fireDate = delay + CFAbsoluteTimeGetCurrent()
        let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, 0, 0, 0, handler)
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, .commonModes)
        return timer
    }
    public class func schedule(repeatInterval interval: TimeInterval, handler: ((Timer?) -> Void)!) -> Timer! {
        let fireDate = interval + CFAbsoluteTimeGetCurrent()
        let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, interval, 0, 0, handler)
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, .commonModes)
        return timer
    }
}
