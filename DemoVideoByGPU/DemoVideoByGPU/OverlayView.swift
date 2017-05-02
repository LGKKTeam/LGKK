//
//  OverlayView.swift
//  DemoVideoByGPU
//
//  Created by Nguyen Minh on 5/2/17.
//  Copyright © 2017 AHDEnglish. All rights reserved.
//

import UIKit
import Reusable
import SwifterSwift
import SwiftLocation
import AVFoundation
import CoreMedia
import CoreLocation
import CoreMotion

class OverlayView: UIView, NibOwnerLoadable {
    @IBOutlet weak var ivIcon: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblSpeed: UILabel!
    @IBOutlet weak var lblVelocity: UILabel!
    
    var location: CLLocation?
    var locationRequest: LocationRequest?
    var motionManager: CMMotionManager?
    var accelerometerData: CMAccelerometerData?
    
    init() {
        let rect = CGRect(x: 0, y: 0, width: SwifterSwift.screenWidth * 0.8, height: 66)
        super.init(frame: rect)
        self.loadNibContent()
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadNibContent()
        setUI()
    }
    
    func updateUIElementView(withTimestamp: CMTime) {
        let totalSeconds = Int(CMTimeGetSeconds(withTimestamp))
        let h = totalSeconds / 3600
        let m = (totalSeconds % 3600) / 60
        let s = totalSeconds % 60
        let str = String.init(format: "CMTime: %i:%02i:%02i", h,m,s)
        lblTime.text = str
        
        if let location = location {
            self.lblLocation.text = String.init(format: "Location: %.2f,%.2f", location.coordinate.latitude, location.coordinate.longitude)
            self.lblSpeed.text = String.init(format: "Speed: %.2f m/s", location.speed)
        }
        
        if let accelerometerData = accelerometerData {
            let x = accelerometerData.acceleration.x
            let y = accelerometerData.acceleration.y
            let z = accelerometerData.acceleration.z
            let str = String.init(format: "Acceleration: %.2f, %.2f, %.2f", x,y,z)
            self.lblVelocity.text = str
        }
    }
    
    func setUI() {
        self.backgroundColor = UIColor.clear
        
        locationRequest = Location.getLocation(accuracy: .city, frequency: .continuous, success: {
            [unowned self] (_, location) -> (Void) in
            self.location = location
        }) { [unowned self] (request, location, error) -> (Void) in
            request.cancel()
            print("Location monitoring failed due to an error \(error)")
            self.location = location
        }
        
        motionManager = CMMotionManager()
        if let motionManager = motionManager, motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.1
            motionManager.startAccelerometerUpdates(to: OperationQueue.main, withHandler: { [unowned self] (data, error) in
                if error != nil {
                    //NOP
                } else {
                    self.accelerometerData = data
                }
            })
        }
    }
}
