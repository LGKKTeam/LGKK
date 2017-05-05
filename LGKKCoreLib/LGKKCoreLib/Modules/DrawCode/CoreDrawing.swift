//
//  CoreDrawing.swift
//  CoreLib
//
//  Created by Minhnd on 4/16/17.
//  Copyright © 2017 AHDEnglish. All rights reserved.
//
//

import UIKit

// swiftlint:disable type_body_length line_length object_literal function_body_length file_length

public class CoreDrawing : NSObject {

    //// Cache
    private struct Cache {
        static let colorBlack: UIColor = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)
        static var imageOfNext: UIImage?
        static var nextTargets: [AnyObject]?
        static var imageOfVolume: UIImage?
        static var volumeTargets: [AnyObject]?
        static var imageOfPlayRevert: UIImage?
        static var playRevertTargets: [AnyObject]?
        static var imageOfPlayBack: UIImage?
        static var playBackTargets: [AnyObject]?
        static var imageOfVolumeMax: UIImage?
        static var volumeMaxTargets: [AnyObject]?
        static var imageOfPause: UIImage?
        static var pauseTargets: [AnyObject]?
        static var imageOfFastBackward: UIImage?
        static var fastBackwardTargets: [AnyObject]?
        static var imageOfFoward: UIImage?
        static var fowardTargets: [AnyObject]?
        static var imageOfVolumeMin: UIImage?
        static var volumeMinTargets: [AnyObject]?
        static var imageOfBackward: UIImage?
        static var backwardTargets: [AnyObject]?
        static var imageOfPlayNext: UIImage?
        static var playNextTargets: [AnyObject]?
        static var imageOfFastFoward: UIImage?
        static var fastFowardTargets: [AnyObject]?
        static var imageOfBack: UIImage?
        static var backTargets: [AnyObject]?
        static var imageOfPlay: UIImage?
        static var playTargets: [AnyObject]?
        static var imageOfFullScreen: UIImage?
        static var fullScreenTargets: [AnyObject]?
        static var imageOfExitFullScreen: UIImage?
        static var exitFullScreenTargets: [AnyObject]?
        static var imageOfDefaultView: UIImage?
        static var defaultViewTargets: [AnyObject]?
        static var imageOfCheckmark: UIImage?
        static var checkmarkTargets: [AnyObject]?
        static var imageOfSettingsFilled: UIImage?
        static var settingsFilledTargets: [AnyObject]?
        static var imageOfSettings: UIImage?
        static var settingsTargets: [AnyObject]?
        static var imageOfTheaterMode: UIImage?
        static var theaterModeTargets: [AnyObject]?
        static var imageOfSoundMuted: UIImage?
        static var soundMutedTargets: [AnyObject]?
    }

    //// Colors

    public dynamic class var colorBlack: UIColor { return Cache.colorBlack }

    //// Drawing Methods

    public dynamic class func drawNext(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 100, height: 180),
                                       resizing: ResizingBehavior = .aspectFit) {
        //// General Declarations
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame = resizing.apply(rect: CGRect(x: 0, y: 0, width: 100, height: 180), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 100, y: resizedFrame.height / 180)

        //// raw Drawing
        let rawPath = UIBezierPath()
        rawPath.move(to: CGPoint(x: 100, y: 90))
        rawPath.addLine(to: CGPoint(x: 10.89, y: 0))
        rawPath.addLine(to: CGPoint(x: 0, y: 10.9))
        rawPath.addLine(to: CGPoint(x: 78.99, y: 90))
        rawPath.addLine(to: CGPoint(x: 0, y: 169.1))
        rawPath.addLine(to: CGPoint(x: 10.89, y: 180))
        rawPath.addLine(to: CGPoint(x: 100, y: 90))
        rawPath.close()
        CoreDrawing.colorBlack.setFill()
        rawPath.fill()
        
        context.restoreGState()
    }

    public dynamic class func drawVolume(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 71, height: 128), resizing: ResizingBehavior = .aspectFit) {
        //// General Declarations
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 71, height: 128), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 71, y: resizedFrame.height / 128)

        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 0, y: 42.21))
        bezierPath.addCurve(to: CGPoint(x: 29.08, y: 42.21), controlPoint1: CGPoint(x: 27.39, y: 42.21), controlPoint2: CGPoint(x: 29.08, y: 42.21))
        bezierPath.addLine(to: CGPoint(x: 71, y: 0))
        bezierPath.addLine(to: CGPoint(x: 71, y: 128))
        bezierPath.addLine(to: CGPoint(x: 29.08, y: 85.79))
        bezierPath.addLine(to: CGPoint(x: 0, y: 85.79))
        bezierPath.addLine(to: CGPoint(x: 0, y: 42.21))
        CoreDrawing.colorBlack.setFill()
        bezierPath.fill()
        
        context.restoreGState()
    }

    public dynamic class func drawPlayRevert(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 90, height: 180), resizing: ResizingBehavior = .aspectFit) {
        //// General Declarations
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 90, height: 180), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 90, y: resizedFrame.height / 180)

        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.move(to: CGPoint(x: 90, y: 0))
        bezier2Path.addCurve(to: CGPoint(x: 90, y: 180), controlPoint1: CGPoint(x: 90, y: 180.02), controlPoint2: CGPoint(x: 90, y: 180))
        bezier2Path.addLine(to: CGPoint(x: 0, y: 87))
        bezier2Path.addLine(to: CGPoint(x: 90, y: 0))
        CoreDrawing.colorBlack.setFill()
        bezier2Path.fill()
        
        context.restoreGState()
    }
    
    public dynamic class func drawPlayBack(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 115, height: 180), resizing: ResizingBehavior = .aspectFit) {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }

        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 115, height: 180), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 115, y: resizedFrame.height / 180)

        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 0, y: 180))
        bezierPath.addLine(to: CGPoint(x: 15, y: 180))
        bezierPath.addLine(to: CGPoint(x: 15, y: 0))
        bezierPath.addLine(to: CGPoint(x: 0, y: 0))
        bezierPath.addLine(to: CGPoint(x: 0, y: 180))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: 115, y: 0))
        bezierPath.addCurve(to: CGPoint(x: 115, y: 180), controlPoint1: CGPoint(x: 115, y: 180.02), controlPoint2: CGPoint(x: 115, y: 180))
        bezierPath.addLine(to: CGPoint(x: 25, y: 87))
        bezierPath.addLine(to: CGPoint(x: 115, y: 0))
        bezierPath.close()
        CoreDrawing.colorBlack.setFill()
        bezierPath.fill()

        context.restoreGState()
    }
    
    public dynamic class func drawVolumeMax(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 128, height: 128), resizing: ResizingBehavior = .aspectFit) {
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 128, height: 128), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 128, y: resizedFrame.height / 128)
        
        //// Bezier 4 Drawing
        let bezier4Path = UIBezierPath()
        bezier4Path.move(to: CGPoint(x: 0, y: 42.21))
        bezier4Path.addCurve(to: CGPoint(x: 29.27, y: 42.21), controlPoint1: CGPoint(x: 27.57, y: 42.21), controlPoint2: CGPoint(x: 29.27, y: 42.21))
        bezier4Path.addLine(to: CGPoint(x: 71.47, y: 0))
        bezier4Path.addLine(to: CGPoint(x: 71.47, y: 128))
        bezier4Path.addLine(to: CGPoint(x: 29.27, y: 85.79))
        bezier4Path.addLine(to: CGPoint(x: 0, y: 85.79))
        bezier4Path.addLine(to: CGPoint(x: 0, y: 42.21))
        bezier4Path.close()
        bezier4Path.move(to: CGPoint(x: 85.12, y: 13.47))
        bezier4Path.addCurve(to: CGPoint(x: 128, y: 63.15), controlPoint1: CGPoint(x: 109.38, y: 17.01), controlPoint2: CGPoint(x: 128, y: 37.9))
        bezier4Path.addCurve(to: CGPoint(x: 85.12, y: 112.83), controlPoint1: CGPoint(x: 128, y: 88.39), controlPoint2: CGPoint(x: 109.38, y: 109.29))
        bezier4Path.addCurve(to: CGPoint(x: 85.12, y: 99.74), controlPoint1: CGPoint(x: 85.12, y: 108.82), controlPoint2: CGPoint(x: 85.12, y: 104.41))
        bezier4Path.addCurve(to: CGPoint(x: 115.07, y: 63.32), controlPoint1: CGPoint(x: 102.19, y: 96.41), controlPoint2: CGPoint(x: 115.07, y: 81.37))
        bezier4Path.addCurve(to: CGPoint(x: 85.12, y: 26.9), controlPoint1: CGPoint(x: 115.07, y: 45.27), controlPoint2: CGPoint(x: 102.19, y: 30.23))
        bezier4Path.addCurve(to: CGPoint(x: 85.12, y: 13.47), controlPoint1: CGPoint(x: 85.12, y: 22.1), controlPoint2: CGPoint(x: 85.12, y: 17.58))
        bezier4Path.close()
        bezier4Path.move(to: CGPoint(x: 85.12, y: 42.15))
        bezier4Path.addCurve(to: CGPoint(x: 99.75, y: 62.98), controlPoint1: CGPoint(x: 93.65, y: 45.22), controlPoint2: CGPoint(x: 99.75, y: 53.39))
        bezier4Path.addCurve(to: CGPoint(x: 85.12, y: 83.81), controlPoint1: CGPoint(x: 99.75, y: 72.57), controlPoint2: CGPoint(x: 93.65, y: 80.74))
        bezier4Path.addCurve(to: CGPoint(x: 85.12, y: 42.15), controlPoint1: CGPoint(x: 85.12, y: 72.23), controlPoint2: CGPoint(x: 85.12, y: 53.72))
        bezier4Path.close()
        CoreDrawing.colorBlack.setFill()
        bezier4Path.fill()
        
        context.restoreGState()
    }

    public dynamic class func drawSoundMuted(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 128, height: 128), resizing: ResizingBehavior = .aspectFit) {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 128, height: 128), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 128, y: resizedFrame.height / 128)
        
        //// Bezier 4 Drawing
        let bezier4Path = UIBezierPath()
        bezier4Path.move(to: CGPoint(x: 120.51, y: 113))
        bezier4Path.addLine(to: CGPoint(x: 127.58, y: 105.93))
        bezier4Path.addLine(to: CGPoint(x: 37.07, y: 15.42))
        bezier4Path.addLine(to: CGPoint(x: 30, y: 22.49))
        bezier4Path.addLine(to: CGPoint(x: 120.51, y: 113))
        bezier4Path.close()
        bezier4Path.move(to: CGPoint(x: 99.75, y: 62.98))
        bezier4Path.addCurve(to: CGPoint(x: 97.12, y: 73.47), controlPoint1: CGPoint(x: 99.75, y: 66.77), controlPoint2: CGPoint(x: 98.8, y: 70.34))
        bezier4Path.addCurve(to: CGPoint(x: 85.12, y: 61.47), controlPoint1: CGPoint(x: 93.24, y: 69.59), controlPoint2: CGPoint(x: 89.19, y: 65.54))
        bezier4Path.addCurve(to: CGPoint(x: 85.12, y: 54.35), controlPoint1: CGPoint(x: 85.12, y: 59.07), controlPoint2: CGPoint(x: 85.12, y: 56.67))
        bezier4Path.addCurve(to: CGPoint(x: 85.12, y: 42.15), controlPoint1: CGPoint(x: 85.12, y: 49.9), controlPoint2: CGPoint(x: 85.12, y: 45.7))
        bezier4Path.addCurve(to: CGPoint(x: 99.75, y: 62.98), controlPoint1: CGPoint(x: 93.65, y: 45.22), controlPoint2: CGPoint(x: 99.75, y: 53.39))
        bezier4Path.close()
        bezier4Path.move(to: CGPoint(x: 85.12, y: 79.61))
        bezier4Path.addCurve(to: CGPoint(x: 88.03, y: 82.52), controlPoint1: CGPoint(x: 86.1, y: 80.59), controlPoint2: CGPoint(x: 87.07, y: 81.56))
        bezier4Path.addCurve(to: CGPoint(x: 85.12, y: 83.81), controlPoint1: CGPoint(x: 87.1, y: 83.01), controlPoint2: CGPoint(x: 86.12, y: 83.45))
        bezier4Path.addCurve(to: CGPoint(x: 85.12, y: 79.61), controlPoint1: CGPoint(x: 85.12, y: 82.49), controlPoint2: CGPoint(x: 85.12, y: 81.09))
        bezier4Path.close()
        bezier4Path.move(to: CGPoint(x: 71.47, y: 0))
        bezier4Path.addCurve(to: CGPoint(x: 71.47, y: 47.81), controlPoint1: CGPoint(x: 71.47, y: -0), controlPoint2: CGPoint(x: 71.47, y: 22.03))
        bezier4Path.addCurve(to: CGPoint(x: 47.56, y: 23.91), controlPoint1: CGPoint(x: 62.33, y: 38.68), controlPoint2: CGPoint(x: 53.83, y: 30.18))
        bezier4Path.addCurve(to: CGPoint(x: 71.46, y: 0.01), controlPoint1: CGPoint(x: 58.83, y: 12.64), controlPoint2: CGPoint(x: 71.18, y: 0.29))
        bezier4Path.addLine(to: CGPoint(x: 71.47, y: 0))
        bezier4Path.close()
        bezier4Path.move(to: CGPoint(x: 71.47, y: 65.96))
        bezier4Path.addCurve(to: CGPoint(x: 71.47, y: 128), controlPoint1: CGPoint(x: 71.47, y: 97.29), controlPoint2: CGPoint(x: 71.47, y: 128))
        bezier4Path.addLine(to: CGPoint(x: 29.27, y: 85.79))
        bezier4Path.addLine(to: CGPoint(x: 0, y: 85.79))
        bezier4Path.addLine(to: CGPoint(x: 0, y: 42.21))
        bezier4Path.addLine(to: CGPoint(x: 29.27, y: 42.21))
        bezier4Path.addCurve(to: CGPoint(x: 38.49, y: 32.98), controlPoint1: CGPoint(x: 29.27, y: 42.21), controlPoint2: CGPoint(x: 33.12, y: 38.36))
        bezier4Path.addCurve(to: CGPoint(x: 71.47, y: 65.96), controlPoint1: CGPoint(x: 46.35, y: 40.84), controlPoint2: CGPoint(x: 58.7, y: 53.19))
        bezier4Path.close()
        bezier4Path.move(to: CGPoint(x: 128, y: 63.15))
        bezier4Path.addCurve(to: CGPoint(x: 117.52, y: 93.86), controlPoint1: CGPoint(x: 128, y: 74.72), controlPoint2: CGPoint(x: 124.09, y: 85.37))
        bezier4Path.addCurve(to: CGPoint(x: 108.32, y: 84.67), controlPoint1: CGPoint(x: 114.84, y: 91.18), controlPoint2: CGPoint(x: 111.73, y: 88.07))
        bezier4Path.addCurve(to: CGPoint(x: 115.07, y: 63.32), controlPoint1: CGPoint(x: 112.57, y: 78.63), controlPoint2: CGPoint(x: 115.07, y: 71.27))
        bezier4Path.addCurve(to: CGPoint(x: 114.62, y: 57.52), controlPoint1: CGPoint(x: 115.07, y: 61.35), controlPoint2: CGPoint(x: 114.91, y: 59.41))
        bezier4Path.addCurve(to: CGPoint(x: 85.12, y: 26.9), controlPoint1: CGPoint(x: 112.2, y: 42.12), controlPoint2: CGPoint(x: 100.32, y: 29.87))
        bezier4Path.addCurve(to: CGPoint(x: 85.12, y: 13.47), controlPoint1: CGPoint(x: 85.12, y: 22.1), controlPoint2: CGPoint(x: 85.12, y: 17.58))
        bezier4Path.addCurve(to: CGPoint(x: 128, y: 63.15), controlPoint1: CGPoint(x: 109.38, y: 17.01), controlPoint2: CGPoint(x: 128, y: 37.9))
        bezier4Path.close()
        bezier4Path.move(to: CGPoint(x: 108.44, y: 102.93))
        bezier4Path.addCurve(to: CGPoint(x: 85.12, y: 112.83), controlPoint1: CGPoint(x: 101.79, y: 108.06), controlPoint2: CGPoint(x: 93.82, y: 111.56))
        bezier4Path.addCurve(to: CGPoint(x: 85.12, y: 99.74), controlPoint1: CGPoint(x: 85.12, y: 108.82), controlPoint2: CGPoint(x: 85.12, y: 104.41))
        bezier4Path.addCurve(to: CGPoint(x: 99.24, y: 93.73), controlPoint1: CGPoint(x: 90.29, y: 98.73), controlPoint2: CGPoint(x: 95.08, y: 96.64))
        bezier4Path.addCurve(to: CGPoint(x: 108.44, y: 102.93), controlPoint1: CGPoint(x: 102.59, y: 97.08), controlPoint2: CGPoint(x: 105.69, y: 100.18))
        bezier4Path.close()
        UIColor.black.setFill()
        bezier4Path.fill()

        context.restoreGState()
    }

    public dynamic class func drawPause(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 90, height: 180), resizing: ResizingBehavior = .aspectFit) {
        ////
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 90, height: 180), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 90, y: resizedFrame.height / 180)
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 0, y: 180))
        bezierPath.addLine(to: CGPoint(x: 30, y: 180))
        bezierPath.addLine(to: CGPoint(x: 30, y: 0))
        bezierPath.addLine(to: CGPoint(x: 0, y: 0))
        bezierPath.addLine(to: CGPoint(x: 0, y: 180))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: 60, y: 180))
        bezierPath.addLine(to: CGPoint(x: 90, y: 180))
        bezierPath.addLine(to: CGPoint(x: 90, y: 0))
        bezierPath.addLine(to: CGPoint(x: 60, y: 0))
        bezierPath.addLine(to: CGPoint(x: 60, y: 180))
        bezierPath.close()
        CoreDrawing.colorBlack.setFill()
        bezierPath.fill()
        
        ////
        context.restoreGState()
    }
    
    public dynamic class func drawFastBackward(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 200, height: 180), resizing: ResizingBehavior = .aspectFit) {
        ////
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 200, height: 180), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 200, y: resizedFrame.height / 180)
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 0, y: 90))
        bezierPath.addLine(to: CGPoint(x: 89.11, y: 0))
        bezierPath.addLine(to: CGPoint(x: 100, y: 10.9))
        bezierPath.addLine(to: CGPoint(x: 21.01, y: 90))
        bezierPath.addLine(to: CGPoint(x: 100, y: 169.1))
        bezierPath.addLine(to: CGPoint(x: 89.11, y: 180))
        bezierPath.addLine(to: CGPoint(x: 0, y: 90))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: 50, y: 90))
        bezierPath.addLine(to: CGPoint(x: 139.11, y: 0))
        bezierPath.addLine(to: CGPoint(x: 150, y: 10.9))
        bezierPath.addLine(to: CGPoint(x: 71.01, y: 90))
        bezierPath.addLine(to: CGPoint(x: 150, y: 169.1))
        bezierPath.addLine(to: CGPoint(x: 139.11, y: 180))
        bezierPath.addLine(to: CGPoint(x: 50, y: 90))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: 100, y: 90))
        bezierPath.addLine(to: CGPoint(x: 189.11, y: 0))
        bezierPath.addLine(to: CGPoint(x: 200, y: 10.9))
        bezierPath.addLine(to: CGPoint(x: 121.01, y: 90))
        bezierPath.addLine(to: CGPoint(x: 200, y: 169.1))
        bezierPath.addLine(to: CGPoint(x: 189.11, y: 180))
        bezierPath.addLine(to: CGPoint(x: 100, y: 90))
        bezierPath.close()
        CoreDrawing.colorBlack.setFill()
        bezierPath.fill()
        
        ////
        context.restoreGState()
    }

    public dynamic class func drawFoward(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 150, height: 180), resizing: ResizingBehavior = .aspectFit) {
        ////
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 150, height: 180), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 150, y: resizedFrame.height / 180)
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 100, y: 90))
        bezierPath.addLine(to: CGPoint(x: 10.89, y: 0))
        bezierPath.addLine(to: CGPoint(x: 0, y: 10.9))
        bezierPath.addLine(to: CGPoint(x: 78.99, y: 90))
        bezierPath.addLine(to: CGPoint(x: 0, y: 169.1))
        bezierPath.addLine(to: CGPoint(x: 10.89, y: 180))
        bezierPath.addLine(to: CGPoint(x: 100, y: 90))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: 150, y: 90))
        bezierPath.addLine(to: CGPoint(x: 60.89, y: 0))
        bezierPath.addLine(to: CGPoint(x: 50, y: 10.9))
        bezierPath.addLine(to: CGPoint(x: 128.99, y: 90))
        bezierPath.addLine(to: CGPoint(x: 50, y: 169.1))
        bezierPath.addLine(to: CGPoint(x: 60.89, y: 180))
        bezierPath.addLine(to: CGPoint(x: 150, y: 90))
        bezierPath.close()
        CoreDrawing.colorBlack.setFill()
        bezierPath.fill()
        
        ////
        context.restoreGState()
    }

    public dynamic class func drawVolumeMin(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 102, height: 128), resizing: ResizingBehavior = .aspectFit) {
        ////
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 102, height: 128), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 102, y: resizedFrame.height / 128)
        
        //// Bezier 3 Drawing
        let bezier3Path = UIBezierPath()
        bezier3Path.move(to: CGPoint(x: 0, y: 42.21))
        bezier3Path.addCurve(to: CGPoint(x: 29.34, y: 42.21), controlPoint1: CGPoint(x: 27.63, y: 42.21), controlPoint2: CGPoint(x: 29.34, y: 42.21))
        bezier3Path.addLine(to: CGPoint(x: 71.64, y: 0))
        bezier3Path.addLine(to: CGPoint(x: 71.64, y: 128))
        bezier3Path.addLine(to: CGPoint(x: 29.34, y: 85.79))
        bezier3Path.addLine(to: CGPoint(x: 0, y: 85.79))
        bezier3Path.addLine(to: CGPoint(x: 0, y: 42.21))
        bezier3Path.close()
        bezier3Path.move(to: CGPoint(x: 87.33, y: 42.15))
        bezier3Path.addCurve(to: CGPoint(x: 102, y: 62.98), controlPoint1: CGPoint(x: 95.88, y: 45.22), controlPoint2: CGPoint(x: 102, y: 53.39))
        bezier3Path.addCurve(to: CGPoint(x: 87.33, y: 83.81), controlPoint1: CGPoint(x: 102, y: 72.57), controlPoint2: CGPoint(x: 95.88, y: 80.74))
        bezier3Path.addCurve(to: CGPoint(x: 87.33, y: 42.15), controlPoint1: CGPoint(x: 87.33, y: 72.23), controlPoint2: CGPoint(x: 87.33, y: 53.72))
        bezier3Path.close()
        CoreDrawing.colorBlack.setFill()
        bezier3Path.fill()
        
        ////
        context.restoreGState()
    }

    public dynamic class func drawBackward(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 150, height: 180), resizing: ResizingBehavior = .aspectFit) {
        ////
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 150, height: 180), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 150, y: resizedFrame.height / 180)
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 50, y: 90))
        bezierPath.addLine(to: CGPoint(x: 139.11, y: 0))
        bezierPath.addLine(to: CGPoint(x: 150, y: 10.9))
        bezierPath.addLine(to: CGPoint(x: 71.01, y: 90))
        bezierPath.addLine(to: CGPoint(x: 150, y: 169.1))
        bezierPath.addLine(to: CGPoint(x: 139.11, y: 180))
        bezierPath.addLine(to: CGPoint(x: 50, y: 90))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: 0, y: 90))
        bezierPath.addLine(to: CGPoint(x: 89.11, y: 0))
        bezierPath.addLine(to: CGPoint(x: 100, y: 10.9))
        bezierPath.addLine(to: CGPoint(x: 21.01, y: 90))
        bezierPath.addLine(to: CGPoint(x: 100, y: 169.1))
        bezierPath.addLine(to: CGPoint(x: 89.11, y: 180))
        bezierPath.addLine(to: CGPoint(x: 0, y: 90))
        bezierPath.close()
        CoreDrawing.colorBlack.setFill()
        bezierPath.fill()

        ////
        context.restoreGState()
    }

    public dynamic class func drawPlayNext(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 115, height: 180), resizing: ResizingBehavior = .aspectFit) {
        ////
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 115, height: 180), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 115, y: resizedFrame.height / 180)
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 0, y: 0.99))
        bezierPath.addCurve(to: CGPoint(x: 0, y: 180), controlPoint1: CGPoint(x: 0, y: 180.02), controlPoint2: CGPoint(x: 0, y: 180))
        bezierPath.addLine(to: CGPoint(x: 90, y: 91.23))
        bezierPath.addLine(to: CGPoint(x: 0, y: 2.46))
        bezierPath.addLine(to: CGPoint(x: 0, y: 0.99))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: 100, y: 180))
        bezierPath.addLine(to: CGPoint(x: 115, y: 180))
        bezierPath.addLine(to: CGPoint(x: 115, y: 0))
        bezierPath.addLine(to: CGPoint(x: 100, y: 0))
        bezierPath.addLine(to: CGPoint(x: 100, y: 180))
        bezierPath.close()
        CoreDrawing.colorBlack.setFill()
        bezierPath.fill()

        ////
        context.restoreGState()
    }
    
    public dynamic class func drawFastFoward(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 200, height: 180), resizing: ResizingBehavior = .aspectFit) {
        ////
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 200, height: 180), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 200, y: resizedFrame.height / 180)
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 100, y: 90))
        bezierPath.addLine(to: CGPoint(x: 10.89, y: 0))
        bezierPath.addLine(to: CGPoint(x: 0, y: 10.9))
        bezierPath.addLine(to: CGPoint(x: 78.99, y: 90))
        bezierPath.addLine(to: CGPoint(x: 0, y: 169.1))
        bezierPath.addLine(to: CGPoint(x: 10.89, y: 180))
        bezierPath.addLine(to: CGPoint(x: 100, y: 90))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: 200, y: 90))
        bezierPath.addLine(to: CGPoint(x: 110.89, y: 0))
        bezierPath.addLine(to: CGPoint(x: 100, y: 10.9))
        bezierPath.addLine(to: CGPoint(x: 178.99, y: 90))
        bezierPath.addLine(to: CGPoint(x: 100, y: 169.1))
        bezierPath.addLine(to: CGPoint(x: 110.89, y: 180))
        bezierPath.addLine(to: CGPoint(x: 200, y: 90))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: 150, y: 90))
        bezierPath.addLine(to: CGPoint(x: 60.89, y: 0))
        bezierPath.addLine(to: CGPoint(x: 50, y: 10.9))
        bezierPath.addLine(to: CGPoint(x: 128.99, y: 90))
        bezierPath.addLine(to: CGPoint(x: 50, y: 169.1))
        bezierPath.addLine(to: CGPoint(x: 60.89, y: 180))
        bezierPath.addLine(to: CGPoint(x: 150, y: 90))
        bezierPath.close()
        CoreDrawing.colorBlack.setFill()
        bezierPath.fill()
        
        ////
        context.restoreGState()
    }

    public dynamic class func drawBack(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 100, height: 180), resizing: ResizingBehavior = .aspectFit) {
        ////
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 100, height: 180), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 100, y: resizedFrame.height / 180)
        
        //// raw Drawing
        let rawPath = UIBezierPath()
        rawPath.move(to: CGPoint(x: 0, y: 90))
        rawPath.addLine(to: CGPoint(x: 89.11, y: 0))
        rawPath.addLine(to: CGPoint(x: 100, y: 10.9))
        rawPath.addLine(to: CGPoint(x: 21.01, y: 90))
        rawPath.addLine(to: CGPoint(x: 100, y: 169.1))
        rawPath.addLine(to: CGPoint(x: 89.11, y: 180))
        rawPath.addLine(to: CGPoint(x: 0, y: 90))
        rawPath.close()
        CoreDrawing.colorBlack.setFill()
        rawPath.fill()
        
        ////
        context.restoreGState()
    }
    
    public dynamic class func drawPlay(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 90, height: 180), resizing: ResizingBehavior = .aspectFit) {
        ////
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 90, height: 180), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 90, y: resizedFrame.height / 180)
        
        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.move(to: CGPoint(x: 0, y: 1))
        bezier2Path.addCurve(to: CGPoint(x: 0, y: 181), controlPoint1: CGPoint(x: 0, y: 181.02), controlPoint2: CGPoint(x: 0, y: 181))
        bezier2Path.addLine(to: CGPoint(x: 90, y: 91.74))
        bezier2Path.addLine(to: CGPoint(x: 0, y: 2.48))
        CoreDrawing.colorBlack.setFill()
        bezier2Path.fill()
        
        ////
        context.restoreGState()
    }

    public dynamic class func drawFullScreen(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 128, height: 128), resizing: ResizingBehavior = .aspectFit) {
        ////
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 128, height: 128), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 128, y: resizedFrame.height / 128)
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 127.7, y: 0.3))
        bezierPath.addLine(to: CGPoint(x: 67.65, y: 0))
        bezierPath.addLine(to: CGPoint(x: 67.66, y: 7.31))
        bezierPath.addLine(to: CGPoint(x: 120.66, y: 7.34))
        bezierPath.addLine(to: CGPoint(x: 120.69, y: 60.34))
        bezierPath.addLine(to: CGPoint(x: 128, y: 60.35))
        bezierPath.addLine(to: CGPoint(x: 127.7, y: 0.3))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: 127.7, y: 127.7))
        bezierPath.addLine(to: CGPoint(x: 128, y: 67.65))
        bezierPath.addLine(to: CGPoint(x: 120.69, y: 67.66))
        bezierPath.addLine(to: CGPoint(x: 120.66, y: 120.66))
        bezierPath.addLine(to: CGPoint(x: 67.66, y: 120.69))
        bezierPath.addLine(to: CGPoint(x: 67.65, y: 128))
        bezierPath.addLine(to: CGPoint(x: 127.7, y: 127.7))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: 0.3, y: 0.3))
        bezierPath.addLine(to: CGPoint(x: 0, y: 60.35))
        bezierPath.addLine(to: CGPoint(x: 7.31, y: 60.34))
        bezierPath.addLine(to: CGPoint(x: 7.34, y: 7.34))
        bezierPath.addLine(to: CGPoint(x: 60.34, y: 7.31))
        bezierPath.addLine(to: CGPoint(x: 60.35, y: 0))
        bezierPath.addLine(to: CGPoint(x: 0.3, y: 0.3))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: 0.3, y: 127.7))
        bezierPath.addLine(to: CGPoint(x: 60.35, y: 128))
        bezierPath.addLine(to: CGPoint(x: 60.34, y: 120.69))
        bezierPath.addLine(to: CGPoint(x: 7.34, y: 120.66))
        bezierPath.addLine(to: CGPoint(x: 7.31, y: 67.66))
        bezierPath.addLine(to: CGPoint(x: 0, y: 67.65))
        bezierPath.addLine(to: CGPoint(x: 0.3, y: 127.7))
        bezierPath.close()
        CoreDrawing.colorBlack.setFill()
        bezierPath.fill()
        
        ////
        context.restoreGState()
    }

    public dynamic class func drawExitFullScreen(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 128, height: 128), resizing: ResizingBehavior = .aspectFit) {
        ////
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 128, height: 128), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 128, y: resizedFrame.height / 128)
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 71.43, y: 55.6))
        bezierPath.addLine(to: CGPoint(x: 71.15, y: 0))
        bezierPath.addLine(to: CGPoint(x: 78.04, y: 0))
        bezierPath.addLine(to: CGPoint(x: 78.07, y: 49.07))
        bezierPath.addLine(to: CGPoint(x: 128, y: 49.11))
        bezierPath.addLine(to: CGPoint(x: 128, y: 55.87))
        bezierPath.addLine(to: CGPoint(x: 71.43, y: 55.6))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: 56.57, y: 55.6))
        bezierPath.addLine(to: CGPoint(x: 0, y: 55.87))
        bezierPath.addLine(to: CGPoint(x: 0, y: 49.11))
        bezierPath.addLine(to: CGPoint(x: 49.93, y: 49.07))
        bezierPath.addLine(to: CGPoint(x: 49.96, y: 0))
        bezierPath.addLine(to: CGPoint(x: 56.85, y: 0))
        bezierPath.addLine(to: CGPoint(x: 56.57, y: 55.6))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: 71.43, y: 72.4))
        bezierPath.addLine(to: CGPoint(x: 128, y: 72.13))
        bezierPath.addLine(to: CGPoint(x: 128, y: 78.89))
        bezierPath.addLine(to: CGPoint(x: 78.07, y: 78.93))
        bezierPath.addLine(to: CGPoint(x: 78.04, y: 128))
        bezierPath.addLine(to: CGPoint(x: 71.15, y: 128))
        bezierPath.addLine(to: CGPoint(x: 71.43, y: 72.4))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: 56.57, y: 72.4))
        bezierPath.addLine(to: CGPoint(x: 56.85, y: 128))
        bezierPath.addLine(to: CGPoint(x: 49.96, y: 128))
        bezierPath.addLine(to: CGPoint(x: 49.93, y: 78.93))
        bezierPath.addLine(to: CGPoint(x: 0, y: 78.89))
        bezierPath.addLine(to: CGPoint(x: 0, y: 72.13))
        bezierPath.addLine(to: CGPoint(x: 56.57, y: 72.4))
        bezierPath.close()
        CoreDrawing.colorBlack.setFill()
        bezierPath.fill()

        ////
        context.restoreGState()
    }

    public dynamic class func drawDefaultView(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 128, height: 73), resizing: ResizingBehavior = .aspectFit) {
        ////
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 128, height: 73), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 128, y: resizedFrame.height / 73)
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 100.63, y: 4.22))
        bezierPath.addLine(to: CGPoint(x: 4.21, y: 4.22))
        bezierPath.addLine(to: CGPoint(x: 4.21, y: 53.59))
        bezierPath.addLine(to: CGPoint(x: 100.63, y: 53.59))
        bezierPath.addLine(to: CGPoint(x: 100.63, y: 4.22))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: 128, y: 0))
        bezierPath.addLine(to: CGPoint(x: 128, y: 73))
        bezierPath.addLine(to: CGPoint(x: 0, y: 73))
        bezierPath.addLine(to: CGPoint(x: 0, y: 0))
        bezierPath.addLine(to: CGPoint(x: 128, y: 0))
        bezierPath.addLine(to: CGPoint(x: 128, y: 0))
        bezierPath.close()
        UIColor.black.setFill()
        bezierPath.fill()

        ////
        context.restoreGState()
    }

    public dynamic class func drawTheaterMode(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 128, height: 73), resizing: ResizingBehavior = .aspectFit) {
        ////
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 128, height: 73), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 128, y: resizedFrame.height / 73)
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 123, y: 5))
        bezierPath.addLine(to: CGPoint(x: 5, y: 5))
        bezierPath.addLine(to: CGPoint(x: 5, y: 68))
        bezierPath.addLine(to: CGPoint(x: 123, y: 68))
        bezierPath.addLine(to: CGPoint(x: 123, y: 5))
        bezierPath.close()
        bezierPath.move(to: CGPoint(x: 128, y: 0))
        bezierPath.addCurve(to: CGPoint(x: 128, y: 73), controlPoint1: CGPoint(x: 128, y: 0), controlPoint2: CGPoint(x: 128, y: 73))
        bezierPath.addLine(to: CGPoint(x: 0, y: 73))
        bezierPath.addLine(to: CGPoint(x: 0, y: 0))
        bezierPath.addLine(to: CGPoint(x: 128, y: 0))
        bezierPath.addLine(to: CGPoint(x: 128, y: 0))
        bezierPath.close()
        UIColor.black.setFill()
        bezierPath.fill()

        ////
        context.restoreGState()
    }
    
    public dynamic class func drawCheckmark(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 64, height: 64), resizing: ResizingBehavior = .aspectFit) {
        ////
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 64, height: 64), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 64, y: resizedFrame.height / 64)
        
        //// raw Drawing
        let rawPath = UIBezierPath()
        rawPath.move(to: CGPoint(x: 1.16, y: 41.19))
        rawPath.addCurve(to: CGPoint(x: 0.14, y: 36.69), controlPoint1: CGPoint(x: 0.12, y: 39.82), controlPoint2: CGPoint(x: -0.22, y: 38.32))
        rawPath.addCurve(to: CGPoint(x: 2.93, y: 32.77), controlPoint1: CGPoint(x: 0.5, y: 35.06), controlPoint2: CGPoint(x: 1.43, y: 33.75))
        rawPath.addCurve(to: CGPoint(x: 7.96, y: 31.79), controlPoint1: CGPoint(x: 4.49, y: 31.79), controlPoint2: CGPoint(x: 6.17, y: 31.47))
        rawPath.addCurve(to: CGPoint(x: 12.22, y: 34.44), controlPoint1: CGPoint(x: 9.76, y: 32.12), controlPoint2: CGPoint(x: 11.18, y: 33))
        rawPath.addLine(to: CGPoint(x: 23.08, y: 48.14))
        rawPath.addLine(to: CGPoint(x: 52.13, y: 3.02))
        rawPath.addCurve(to: CGPoint(x: 55.95, y: 0.19), controlPoint1: CGPoint(x: 53.11, y: 1.52), controlPoint2: CGPoint(x: 54.38, y: 0.58))
        rawPath.addCurve(to: CGPoint(x: 60.74, y: 0.87), controlPoint1: CGPoint(x: 57.51, y: -0.21), controlPoint2: CGPoint(x: 59.11, y: 0.02))
        rawPath.addCurve(to: CGPoint(x: 63.77, y: 4.59), controlPoint1: CGPoint(x: 62.3, y: 1.72), controlPoint2: CGPoint(x: 63.32, y: 2.96))
        rawPath.addCurve(to: CGPoint(x: 63.09, y: 9.19), controlPoint1: CGPoint(x: 64.23, y: 6.22), controlPoint2: CGPoint(x: 64, y: 7.75))
        rawPath.addLine(to: CGPoint(x: 29.34, y: 60.95))
        rawPath.addCurve(to: CGPoint(x: 27.04, y: 63.11), controlPoint1: CGPoint(x: 28.82, y: 61.87), controlPoint2: CGPoint(x: 28.05, y: 62.59))
        rawPath.addCurve(to: CGPoint(x: 23.86, y: 63.99), controlPoint1: CGPoint(x: 26.03, y: 63.63), controlPoint2: CGPoint(x: 24.97, y: 63.92))
        rawPath.addCurve(to: CGPoint(x: 20.68, y: 63.35), controlPoint1: CGPoint(x: 22.69, y: 64.05), controlPoint2: CGPoint(x: 21.63, y: 63.84))
        rawPath.addCurve(to: CGPoint(x: 18.19, y: 61.35), controlPoint1: CGPoint(x: 19.73, y: 62.86), controlPoint2: CGPoint(x: 18.9, y: 62.19))
        rawPath.addLine(to: CGPoint(x: 1.16, y: 41.19))
        rawPath.close()
        UIColor.black.setFill()
        rawPath.fill()

        ////
        context.restoreGState()
    }

    public dynamic class func drawSettingsFilled(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 500, height: 500), resizing: ResizingBehavior = .aspectFit) {
        ////
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 500, height: 500), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 500, y: resizedFrame.height / 500)
        
        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.move(to: CGPoint(x: 288, y: 0))
        bezier2Path.addCurve(to: CGPoint(x: 300.65, y: 73.98), controlPoint1: CGPoint(x: 288, y: 0), controlPoint2: CGPoint(x: 298.59, y: 61.92))
        bezier2Path.addCurve(to: CGPoint(x: 339, y: 89.86), controlPoint1: CGPoint(x: 314.14, y: 77.82), controlPoint2: CGPoint(x: 326.98, y: 83.18))
        bezier2Path.addCurve(to: CGPoint(x: 355.79, y: 77.64), controlPoint1: CGPoint(x: 341.4, y: 88.11), controlPoint2: CGPoint(x: 347.89, y: 83.39))
        bezier2Path.addCurve(to: CGPoint(x: 400.21, y: 45.34), controlPoint1: CGPoint(x: 373.94, y: 64.44), controlPoint2: CGPoint(x: 399.56, y: 45.81))
        bezier2Path.addCurve(to: CGPoint(x: 453.97, y: 99.07), controlPoint1: CGPoint(x: 400.23, y: 45.33), controlPoint2: CGPoint(x: 453.97, y: 99.07))
        bezier2Path.addCurve(to: CGPoint(x: 410.14, y: 160.99), controlPoint1: CGPoint(x: 453.97, y: 99.07), controlPoint2: CGPoint(x: 415.86, y: 152.89))
        bezier2Path.addCurve(to: CGPoint(x: 426.02, y: 199.35), controlPoint1: CGPoint(x: 416.81, y: 173), controlPoint2: CGPoint(x: 422.17, y: 185.86))
        bezier2Path.addCurve(to: CGPoint(x: 500, y: 212), controlPoint1: CGPoint(x: 438.08, y: 201.41), controlPoint2: CGPoint(x: 500, y: 212))
        bezier2Path.addLine(to: CGPoint(x: 500, y: 288))
        bezier2Path.addCurve(to: CGPoint(x: 426.01, y: 299.68), controlPoint1: CGPoint(x: 500, y: 288), controlPoint2: CGPoint(x: 438.05, y: 297.78))
        bezier2Path.addCurve(to: CGPoint(x: 410.51, y: 337.34), controlPoint1: CGPoint(x: 422.24, y: 312.91), controlPoint2: CGPoint(x: 417.01, y: 325.52))
        bezier2Path.addCurve(to: CGPoint(x: 454.67, y: 398.07), controlPoint1: CGPoint(x: 417.4, y: 346.82), controlPoint2: CGPoint(x: 454.67, y: 398.07))
        bezier2Path.addLine(to: CGPoint(x: 400.93, y: 451.81))
        bezier2Path.addCurve(to: CGPoint(x: 339.93, y: 408.62), controlPoint1: CGPoint(x: 400.93, y: 451.81), controlPoint2: CGPoint(x: 350.5, y: 416.1))
        bezier2Path.addCurve(to: CGPoint(x: 300.83, y: 424.97), controlPoint1: CGPoint(x: 327.7, y: 415.51), controlPoint2: CGPoint(x: 314.6, y: 421.03))
        bezier2Path.addCurve(to: CGPoint(x: 288, y: 500), controlPoint1: CGPoint(x: 299.32, y: 433.8), controlPoint2: CGPoint(x: 288, y: 500))
        bezier2Path.addLine(to: CGPoint(x: 212, y: 500))
        bezier2Path.addCurve(to: CGPoint(x: 200.15, y: 424.97), controlPoint1: CGPoint(x: 212, y: 500), controlPoint2: CGPoint(x: 201.55, y: 433.79))
        bezier2Path.addCurve(to: CGPoint(x: 160.63, y: 408.37), controlPoint1: CGPoint(x: 186.22, y: 420.98), controlPoint2: CGPoint(x: 172.98, y: 415.37))
        bezier2Path.addCurve(to: CGPoint(x: 99.93, y: 452.51), controlPoint1: CGPoint(x: 151.06, y: 415.33), controlPoint2: CGPoint(x: 99.93, y: 452.51))
        bezier2Path.addLine(to: CGPoint(x: 46.19, y: 398.77))
        bezier2Path.addCurve(to: CGPoint(x: 90.14, y: 336.69), controlPoint1: CGPoint(x: 46.19, y: 398.77), controlPoint2: CGPoint(x: 84.83, y: 344.2))
        bezier2Path.addCurve(to: CGPoint(x: 75.03, y: 299.85), controlPoint1: CGPoint(x: 83.83, y: 325.11), controlPoint2: CGPoint(x: 78.74, y: 312.77))
        bezier2Path.addCurve(to: CGPoint(x: 0, y: 288), controlPoint1: CGPoint(x: 66.21, y: 298.45), controlPoint2: CGPoint(x: 0, y: 288))
        bezier2Path.addLine(to: CGPoint(x: 0, y: 212))
        bezier2Path.addCurve(to: CGPoint(x: 75.03, y: 199.17), controlPoint1: CGPoint(x: 0, y: 212), controlPoint2: CGPoint(x: 66.19, y: 200.68))
        bezier2Path.addCurve(to: CGPoint(x: 90.49, y: 161.66), controlPoint1: CGPoint(x: 78.8, y: 185.99), controlPoint2: CGPoint(x: 84.02, y: 173.43))
        bezier2Path.addCurve(to: CGPoint(x: 45.49, y: 99.77), controlPoint1: CGPoint(x: 86.9, y: 156.72), controlPoint2: CGPoint(x: 45.49, y: 99.77))
        bezier2Path.addCurve(to: CGPoint(x: 85.33, y: 59.93), controlPoint1: CGPoint(x: 45.49, y: 99.77), controlPoint2: CGPoint(x: 69.41, y: 75.85))
        bezier2Path.addCurve(to: CGPoint(x: 99.23, y: 46.03), controlPoint1: CGPoint(x: 93.27, y: 51.99), controlPoint2: CGPoint(x: 99.23, y: 46.03))
        bezier2Path.addCurve(to: CGPoint(x: 161.51, y: 90.13), controlPoint1: CGPoint(x: 99.23, y: 46.03), controlPoint2: CGPoint(x: 154.88, y: 85.43))
        bezier2Path.addCurve(to: CGPoint(x: 200.32, y: 73.99), controlPoint1: CGPoint(x: 173.66, y: 83.33), controlPoint2: CGPoint(x: 186.66, y: 77.88))
        bezier2Path.addCurve(to: CGPoint(x: 212, y: 0), controlPoint1: CGPoint(x: 202.22, y: 61.95), controlPoint2: CGPoint(x: 212, y: 0))
        bezier2Path.addLine(to: CGPoint(x: 288, y: 0))
        bezier2Path.addLine(to: CGPoint(x: 288, y: 0))
        bezier2Path.close()
        bezier2Path.move(to: CGPoint(x: 250.5, y: 175))
        bezier2Path.addCurve(to: CGPoint(x: 230.57, y: 177.7), controlPoint1: CGPoint(x: 243.6, y: 175), controlPoint2: CGPoint(x: 236.92, y: 175.94))
        bezier2Path.addCurve(to: CGPoint(x: 176, y: 249.5), controlPoint1: CGPoint(x: 199.1, y: 186.41), controlPoint2: CGPoint(x: 176, y: 215.26))
        bezier2Path.addCurve(to: CGPoint(x: 250.5, y: 324), controlPoint1: CGPoint(x: 176, y: 290.65), controlPoint2: CGPoint(x: 209.35, y: 324))
        bezier2Path.addCurve(to: CGPoint(x: 325, y: 249.5), controlPoint1: CGPoint(x: 291.65, y: 324), controlPoint2: CGPoint(x: 325, y: 290.65))
        bezier2Path.addCurve(to: CGPoint(x: 250.5, y: 175), controlPoint1: CGPoint(x: 325, y: 208.35), controlPoint2: CGPoint(x: 291.65, y: 175))
        bezier2Path.close()
        UIColor.black.setFill()
        bezier2Path.fill()

        ////
        context.restoreGState()
    }

    public dynamic class func drawSettings(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 500, height: 500), resizing: ResizingBehavior = .aspectFit) {
        ////
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 500, height: 500), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 500, y: resizedFrame.height / 500)
        
        //// Bezier 3 Drawing
        let bezier3Path = UIBezierPath()
        bezier3Path.move(to: CGPoint(x: 251.5, y: 175))
        bezier3Path.addCurve(to: CGPoint(x: 231.36, y: 177.75), controlPoint1: CGPoint(x: 244.52, y: 175), controlPoint2: CGPoint(x: 237.77, y: 175.96))
        bezier3Path.addCurve(to: CGPoint(x: 177, y: 249.5), controlPoint1: CGPoint(x: 200, y: 186.54), controlPoint2: CGPoint(x: 177, y: 215.33))
        bezier3Path.addCurve(to: CGPoint(x: 251.5, y: 324), controlPoint1: CGPoint(x: 177, y: 290.65), controlPoint2: CGPoint(x: 210.35, y: 324))
        bezier3Path.addCurve(to: CGPoint(x: 326, y: 249.5), controlPoint1: CGPoint(x: 292.65, y: 324), controlPoint2: CGPoint(x: 326, y: 290.65))
        bezier3Path.addCurve(to: CGPoint(x: 251.5, y: 175), controlPoint1: CGPoint(x: 326, y: 208.35), controlPoint2: CGPoint(x: 292.65, y: 175))
        bezier3Path.close()
        bezier3Path.move(to: CGPoint(x: 331, y: 250))
        bezier3Path.addCurve(to: CGPoint(x: 251, y: 330), controlPoint1: CGPoint(x: 331, y: 294.18), controlPoint2: CGPoint(x: 295.18, y: 330))
        bezier3Path.addCurve(to: CGPoint(x: 171, y: 250), controlPoint1: CGPoint(x: 206.82, y: 330), controlPoint2: CGPoint(x: 171, y: 294.18))
        bezier3Path.addCurve(to: CGPoint(x: 228.41, y: 173.23), controlPoint1: CGPoint(x: 171, y: 213.66), controlPoint2: CGPoint(x: 195.23, y: 182.98))
        bezier3Path.addCurve(to: CGPoint(x: 251, y: 170), controlPoint1: CGPoint(x: 235.58, y: 171.13), controlPoint2: CGPoint(x: 243.16, y: 170))
        bezier3Path.addCurve(to: CGPoint(x: 331, y: 250), controlPoint1: CGPoint(x: 295.18, y: 170), controlPoint2: CGPoint(x: 331, y: 205.82))
        bezier3Path.close()
        bezier3Path.move(to: CGPoint(x: 212.02, y: 0))
        bezier3Path.addCurve(to: CGPoint(x: 288, y: 0), controlPoint1: CGPoint(x: 212, y: 0), controlPoint2: CGPoint(x: 288, y: 0))
        bezier3Path.addCurve(to: CGPoint(x: 300.65, y: 73.98), controlPoint1: CGPoint(x: 288, y: 0), controlPoint2: CGPoint(x: 298.59, y: 61.92))
        bezier3Path.addCurve(to: CGPoint(x: 339, y: 89.86), controlPoint1: CGPoint(x: 314.14, y: 77.82), controlPoint2: CGPoint(x: 326.98, y: 83.18))
        bezier3Path.addCurve(to: CGPoint(x: 400.23, y: 45.33), controlPoint1: CGPoint(x: 346.99, y: 84.05), controlPoint2: CGPoint(x: 400.23, y: 45.33))
        bezier3Path.addLine(to: CGPoint(x: 453.97, y: 99.07))
        bezier3Path.addCurve(to: CGPoint(x: 410.14, y: 160.99), controlPoint1: CGPoint(x: 453.97, y: 99.07), controlPoint2: CGPoint(x: 415.86, y: 152.89))
        bezier3Path.addCurve(to: CGPoint(x: 426.01, y: 199.32), controlPoint1: CGPoint(x: 416.81, y: 173), controlPoint2: CGPoint(x: 422.17, y: 185.84))
        bezier3Path.addCurve(to: CGPoint(x: 500, y: 211), controlPoint1: CGPoint(x: 438.05, y: 201.22), controlPoint2: CGPoint(x: 500, y: 211))
        bezier3Path.addLine(to: CGPoint(x: 500, y: 287))
        bezier3Path.addCurve(to: CGPoint(x: 426.02, y: 299.65), controlPoint1: CGPoint(x: 500, y: 287), controlPoint2: CGPoint(x: 438.08, y: 297.59))
        bezier3Path.addCurve(to: CGPoint(x: 410.5, y: 337.36), controlPoint1: CGPoint(x: 422.24, y: 312.9), controlPoint2: CGPoint(x: 417.01, y: 325.53))
        bezier3Path.addCurve(to: CGPoint(x: 453.96, y: 398.77), controlPoint1: CGPoint(x: 417.29, y: 346.97), controlPoint2: CGPoint(x: 453.97, y: 398.77))
        bezier3Path.addCurve(to: CGPoint(x: 400.23, y: 452.51), controlPoint1: CGPoint(x: 453.97, y: 398.77), controlPoint2: CGPoint(x: 400.23, y: 452.51))
        bezier3Path.addCurve(to: CGPoint(x: 339.9, y: 408.64), controlPoint1: CGPoint(x: 400.23, y: 452.51), controlPoint2: CGPoint(x: 350.33, y: 416.23))
        bezier3Path.addCurve(to: CGPoint(x: 300.83, y: 424.97), controlPoint1: CGPoint(x: 327.68, y: 415.52), controlPoint2: CGPoint(x: 314.59, y: 421.03))
        bezier3Path.addCurve(to: CGPoint(x: 288, y: 500), controlPoint1: CGPoint(x: 299.32, y: 433.8), controlPoint2: CGPoint(x: 288, y: 500))
        bezier3Path.addLine(to: CGPoint(x: 212, y: 500))
        bezier3Path.addCurve(to: CGPoint(x: 200.15, y: 424.97), controlPoint1: CGPoint(x: 212, y: 500), controlPoint2: CGPoint(x: 201.55, y: 433.79))
        bezier3Path.addCurve(to: CGPoint(x: 160.63, y: 408.37), controlPoint1: CGPoint(x: 186.22, y: 420.98), controlPoint2: CGPoint(x: 172.98, y: 415.37))
        bezier3Path.addCurve(to: CGPoint(x: 99.93, y: 452.51), controlPoint1: CGPoint(x: 151.06, y: 415.33), controlPoint2: CGPoint(x: 99.93, y: 452.51))
        bezier3Path.addLine(to: CGPoint(x: 46.19, y: 398.77))
        bezier3Path.addCurve(to: CGPoint(x: 90.14, y: 336.69), controlPoint1: CGPoint(x: 46.19, y: 398.77), controlPoint2: CGPoint(x: 84.83, y: 344.2))
        bezier3Path.addCurve(to: CGPoint(x: 75.03, y: 299.83), controlPoint1: CGPoint(x: 83.83, y: 325.11), controlPoint2: CGPoint(x: 78.73, y: 312.77))
        bezier3Path.addCurve(to: CGPoint(x: 0, y: 287), controlPoint1: CGPoint(x: 66.2, y: 298.32), controlPoint2: CGPoint(x: 0, y: 287))
        bezier3Path.addCurve(to: CGPoint(x: 0, y: 211), controlPoint1: CGPoint(x: 0, y: 287), controlPoint2: CGPoint(x: 0, y: 211))
        bezier3Path.addCurve(to: CGPoint(x: 71.47, y: 199.72), controlPoint1: CGPoint(x: 0, y: 211), controlPoint2: CGPoint(x: 55.1, y: 202.3))
        bezier3Path.addCurve(to: CGPoint(x: 75.03, y: 199.15), controlPoint1: CGPoint(x: 73.04, y: 199.47), controlPoint2: CGPoint(x: 74.26, y: 199.27))
        bezier3Path.addCurve(to: CGPoint(x: 90.49, y: 161.65), controlPoint1: CGPoint(x: 78.81, y: 185.98), controlPoint2: CGPoint(x: 84.02, y: 173.42))
        bezier3Path.addCurve(to: CGPoint(x: 46.19, y: 99.07), controlPoint1: CGPoint(x: 86.95, y: 156.65), controlPoint2: CGPoint(x: 46.19, y: 99.07))
        bezier3Path.addCurve(to: CGPoint(x: 91.48, y: 53.78), controlPoint1: CGPoint(x: 46.19, y: 99.07), controlPoint2: CGPoint(x: 76.35, y: 68.91))
        bezier3Path.addCurve(to: CGPoint(x: 96.09, y: 49.17), controlPoint1: CGPoint(x: 93.25, y: 52.01), controlPoint2: CGPoint(x: 94.8, y: 50.46))
        bezier3Path.addCurve(to: CGPoint(x: 99.93, y: 45.33), controlPoint1: CGPoint(x: 98.49, y: 46.77), controlPoint2: CGPoint(x: 99.93, y: 45.33))
        bezier3Path.addCurve(to: CGPoint(x: 135.8, y: 71.41), controlPoint1: CGPoint(x: 99.93, y: 45.33), controlPoint2: CGPoint(x: 118.83, y: 59.07))
        bezier3Path.addCurve(to: CGPoint(x: 161.52, y: 90.12), controlPoint1: CGPoint(x: 147.79, y: 80.13), controlPoint2: CGPoint(x: 158.81, y: 88.15))
        bezier3Path.addCurve(to: CGPoint(x: 200.32, y: 73.99), controlPoint1: CGPoint(x: 173.67, y: 83.33), controlPoint2: CGPoint(x: 186.67, y: 77.88))
        bezier3Path.addCurve(to: CGPoint(x: 200.71, y: 71.47), controlPoint1: CGPoint(x: 200.43, y: 73.3), controlPoint2: CGPoint(x: 200.56, y: 72.46))
        bezier3Path.addCurve(to: CGPoint(x: 211.23, y: 4.9), controlPoint1: CGPoint(x: 202.83, y: 58.09), controlPoint2: CGPoint(x: 209.04, y: 18.75))
        bezier3Path.addCurve(to: CGPoint(x: 212, y: 0), controlPoint1: CGPoint(x: 211.7, y: 1.89), controlPoint2: CGPoint(x: 211.99, y: 0.08))
        bezier3Path.addLine(to: CGPoint(x: 212.02, y: 0))
        bezier3Path.close()
        bezier3Path.move(to: CGPoint(x: 284.29, y: 5))
        bezier3Path.addLine(to: CGPoint(x: 215.81, y: 5))
        bezier3Path.addCurve(to: CGPoint(x: 213.14, y: 21.77), controlPoint1: CGPoint(x: 215.81, y: 5), controlPoint2: CGPoint(x: 214.68, y: 12.13))
        bezier3Path.addCurve(to: CGPoint(x: 203.53, y: 78.28), controlPoint1: CGPoint(x: 210.45, y: 37.58), controlPoint2: CGPoint(x: 206.42, y: 61.3))
        bezier3Path.addCurve(to: CGPoint(x: 162.58, y: 95.27), controlPoint1: CGPoint(x: 189.06, y: 82.24), controlPoint2: CGPoint(x: 175.32, y: 87.99))
        bezier3Path.addCurve(to: CGPoint(x: 126.99, y: 70.58), controlPoint1: CGPoint(x: 152.3, y: 88.14), controlPoint2: CGPoint(x: 138.79, y: 78.77))
        bezier3Path.addCurve(to: CGPoint(x: 100.77, y: 51.56), controlPoint1: CGPoint(x: 113.63, y: 60.89), controlPoint2: CGPoint(x: 100.77, y: 51.56))
        bezier3Path.addLine(to: CGPoint(x: 52.35, y: 99.98))
        bezier3Path.addCurve(to: CGPoint(x: 52.44, y: 100.1), controlPoint1: CGPoint(x: 52.35, y: 99.98), controlPoint2: CGPoint(x: 52.38, y: 100.02))
        bezier3Path.addCurve(to: CGPoint(x: 52.31, y: 100.22), controlPoint1: CGPoint(x: 52.36, y: 100.18), controlPoint2: CGPoint(x: 52.31, y: 100.22))
        bezier3Path.addCurve(to: CGPoint(x: 96.07, y: 161.93), controlPoint1: CGPoint(x: 52.31, y: 100.22), controlPoint2: CGPoint(x: 79.92, y: 139.15))
        bezier3Path.addCurve(to: CGPoint(x: 79.27, y: 202.57), controlPoint1: CGPoint(x: 88.88, y: 174.59), controlPoint2: CGPoint(x: 83.2, y: 188.21))
        bezier3Path.addCurve(to: CGPoint(x: 59.37, y: 206.17), controlPoint1: CGPoint(x: 73.31, y: 203.65), controlPoint2: CGPoint(x: 66.45, y: 204.89))
        bezier3Path.addCurve(to: CGPoint(x: 5, y: 214.81), controlPoint1: CGPoint(x: 39.52, y: 209.32), controlPoint2: CGPoint(x: 5, y: 214.81))
        bezier3Path.addCurve(to: CGPoint(x: 5, y: 216), controlPoint1: CGPoint(x: 5, y: 214.81), controlPoint2: CGPoint(x: 5, y: 215.23))
        bezier3Path.addCurve(to: CGPoint(x: 5, y: 283.29), controlPoint1: CGPoint(x: 5, y: 225.09), controlPoint2: CGPoint(x: 5, y: 283.29))
        bezier3Path.addCurve(to: CGPoint(x: 5, y: 284), controlPoint1: CGPoint(x: 5, y: 283.75), controlPoint2: CGPoint(x: 5, y: 284))
        bezier3Path.addCurve(to: CGPoint(x: 79.33, y: 296.65), controlPoint1: CGPoint(x: 5, y: 284), controlPoint2: CGPoint(x: 51.77, y: 291.96))
        bezier3Path.addCurve(to: CGPoint(x: 95.46, y: 335.99), controlPoint1: CGPoint(x: 83.14, y: 310.52), controlPoint2: CGPoint(x: 88.59, y: 323.7))
        bezier3Path.addCurve(to: CGPoint(x: 62.57, y: 383.4), controlPoint1: CGPoint(x: 85.86, y: 349.82), controlPoint2: CGPoint(x: 72.03, y: 369.76))
        bezier3Path.addCurve(to: CGPoint(x: 52.35, y: 397.86), controlPoint1: CGPoint(x: 56.72, y: 391.67), controlPoint2: CGPoint(x: 52.35, y: 397.86))
        bezier3Path.addCurve(to: CGPoint(x: 52.46, y: 397.97), controlPoint1: CGPoint(x: 52.35, y: 397.86), controlPoint2: CGPoint(x: 52.39, y: 397.9))
        bezier3Path.addCurve(to: CGPoint(x: 52.02, y: 398.6), controlPoint1: CGPoint(x: 52.17, y: 398.38), controlPoint2: CGPoint(x: 52.02, y: 398.6))
        bezier3Path.addLine(to: CGPoint(x: 100.1, y: 446.69))
        bezier3Path.addCurve(to: CGPoint(x: 100.73, y: 446.24), controlPoint1: CGPoint(x: 100.1, y: 446.69), controlPoint2: CGPoint(x: 100.32, y: 446.53))
        bezier3Path.addCurve(to: CGPoint(x: 105.1, y: 443.14), controlPoint1: CGPoint(x: 100.77, y: 446.28), controlPoint2: CGPoint(x: 102.4, y: 445.1))
        bezier3Path.addCurve(to: CGPoint(x: 161.53, y: 403.13), controlPoint1: CGPoint(x: 116.28, y: 435.22), controlPoint2: CGPoint(x: 143.72, y: 415.76))
        bezier3Path.addCurve(to: CGPoint(x: 203.35, y: 420.67), controlPoint1: CGPoint(x: 174.52, y: 410.66), controlPoint2: CGPoint(x: 188.55, y: 416.6))
        bezier3Path.addCurve(to: CGPoint(x: 213.14, y: 478.23), controlPoint1: CGPoint(x: 206.25, y: 437.71), controlPoint2: CGPoint(x: 210.4, y: 462.09))
        bezier3Path.addCurve(to: CGPoint(x: 215.81, y: 495), controlPoint1: CGPoint(x: 214.68, y: 487.87), controlPoint2: CGPoint(x: 215.81, y: 495))
        bezier3Path.addLine(to: CGPoint(x: 284.29, y: 495))
        bezier3Path.addCurve(to: CGPoint(x: 290.04, y: 461.62), controlPoint1: CGPoint(x: 284.29, y: 495), controlPoint2: CGPoint(x: 287.14, y: 478.41))
        bezier3Path.addCurve(to: CGPoint(x: 297.43, y: 420.73), controlPoint1: CGPoint(x: 292.51, y: 447.94), controlPoint2: CGPoint(x: 295.29, y: 432.57))
        bezier3Path.addCurve(to: CGPoint(x: 338.51, y: 403.68), controlPoint1: CGPoint(x: 311.95, y: 416.76), controlPoint2: CGPoint(x: 325.73, y: 410.99))
        bezier3Path.addCurve(to: CGPoint(x: 388.68, y: 438.48), controlPoint1: CGPoint(x: 353.88, y: 414.34), controlPoint2: CGPoint(x: 375.74, y: 429.5))
        bezier3Path.addCurve(to: CGPoint(x: 399.39, y: 446.28), controlPoint1: CGPoint(x: 395.03, y: 443.11), controlPoint2: CGPoint(x: 399.39, y: 446.28))
        bezier3Path.addLine(to: CGPoint(x: 447.8, y: 397.86))
        bezier3Path.addLine(to: CGPoint(x: 405, y: 337))
        bezier3Path.addCurve(to: CGPoint(x: 404.91, y: 337.11), controlPoint1: CGPoint(x: 405, y: 337), controlPoint2: CGPoint(x: 404.97, y: 337.04))
        bezier3Path.addLine(to: CGPoint(x: 404.98, y: 336.99))
        bezier3Path.addCurve(to: CGPoint(x: 421.78, y: 296.24), controlPoint1: CGPoint(x: 412.18, y: 324.3), controlPoint2: CGPoint(x: 417.86, y: 310.63))
        bezier3Path.addCurve(to: CGPoint(x: 461.62, y: 289.04), controlPoint1: CGPoint(x: 433.47, y: 294.13), controlPoint2: CGPoint(x: 448.34, y: 291.44))
        bezier3Path.addCurve(to: CGPoint(x: 495, y: 283.29), controlPoint1: CGPoint(x: 478.41, y: 286.14), controlPoint2: CGPoint(x: 495, y: 283.29))
        bezier3Path.addCurve(to: CGPoint(x: 495, y: 283), controlPoint1: CGPoint(x: 495, y: 283.29), controlPoint2: CGPoint(x: 495, y: 283.19))
        bezier3Path.addCurve(to: CGPoint(x: 495, y: 215), controlPoint1: CGPoint(x: 495, y: 278.35), controlPoint2: CGPoint(x: 495, y: 218.78))
        bezier3Path.addCurve(to: CGPoint(x: 495, y: 214.81), controlPoint1: CGPoint(x: 495, y: 214.88), controlPoint2: CGPoint(x: 495, y: 214.81))
        bezier3Path.addCurve(to: CGPoint(x: 478.23, y: 212.14), controlPoint1: CGPoint(x: 495, y: 214.81), controlPoint2: CGPoint(x: 487.87, y: 213.68))
        bezier3Path.addCurve(to: CGPoint(x: 421.72, y: 202.53), controlPoint1: CGPoint(x: 462.42, y: 209.45), controlPoint2: CGPoint(x: 438.7, y: 205.42))
        bezier3Path.addCurve(to: CGPoint(x: 404.77, y: 161.64), controlPoint1: CGPoint(x: 417.76, y: 188.08), controlPoint2: CGPoint(x: 412.03, y: 174.37))
        bezier3Path.addCurve(to: CGPoint(x: 432.85, y: 121.15), controlPoint1: CGPoint(x: 412.91, y: 149.9), controlPoint2: CGPoint(x: 423.98, y: 133.95))
        bezier3Path.addCurve(to: CGPoint(x: 447.8, y: 99.98), controlPoint1: CGPoint(x: 440.91, y: 109.75), controlPoint2: CGPoint(x: 447.8, y: 99.98))
        bezier3Path.addCurve(to: CGPoint(x: 447.65, y: 99.82), controlPoint1: CGPoint(x: 447.8, y: 99.98), controlPoint2: CGPoint(x: 447.75, y: 99.92))
        bezier3Path.addCurve(to: CGPoint(x: 447.87, y: 99.51), controlPoint1: CGPoint(x: 447.79, y: 99.62), controlPoint2: CGPoint(x: 447.87, y: 99.51))
        bezier3Path.addLine(to: CGPoint(x: 399.78, y: 51.43))
        bezier3Path.addCurve(to: CGPoint(x: 399.47, y: 51.65), controlPoint1: CGPoint(x: 399.78, y: 51.43), controlPoint2: CGPoint(x: 399.68, y: 51.5))
        bezier3Path.addCurve(to: CGPoint(x: 399.39, y: 51.56), controlPoint1: CGPoint(x: 399.42, y: 51.59), controlPoint2: CGPoint(x: 399.39, y: 51.56))
        bezier3Path.addCurve(to: CGPoint(x: 390.27, y: 58.17), controlPoint1: CGPoint(x: 399.39, y: 51.56), controlPoint2: CGPoint(x: 395.72, y: 54.22))
        bezier3Path.addCurve(to: CGPoint(x: 359.62, y: 79.9), controlPoint1: CGPoint(x: 382.51, y: 63.68), controlPoint2: CGPoint(x: 370.99, y: 71.84))
        bezier3Path.addCurve(to: CGPoint(x: 345.06, y: 90.23), controlPoint1: CGPoint(x: 354.63, y: 83.44), controlPoint2: CGPoint(x: 349.67, y: 86.96))
        bezier3Path.addCurve(to: CGPoint(x: 338.16, y: 95.12), controlPoint1: CGPoint(x: 342.65, y: 91.94), controlPoint2: CGPoint(x: 340.33, y: 93.58))
        bezier3Path.addCurve(to: CGPoint(x: 297.24, y: 78.22), controlPoint1: CGPoint(x: 325.42, y: 87.87), controlPoint2: CGPoint(x: 311.7, y: 82.16))
        bezier3Path.addCurve(to: CGPoint(x: 290.04, y: 38.38), controlPoint1: CGPoint(x: 295.13, y: 66.53), controlPoint2: CGPoint(x: 292.44, y: 51.66))
        bezier3Path.addCurve(to: CGPoint(x: 284.29, y: 5), controlPoint1: CGPoint(x: 287.14, y: 21.59), controlPoint2: CGPoint(x: 284.29, y: 5))
        bezier3Path.close()
        bezier3Path.move(to: CGPoint(x: 404.89, y: 337.12))
        bezier3Path.addCurve(to: CGPoint(x: 404.8, y: 337.58), controlPoint1: CGPoint(x: 404.9, y: 337.12), controlPoint2: CGPoint(x: 404.86, y: 337.28))
        bezier3Path.addLine(to: CGPoint(x: 404.67, y: 337.39))
        bezier3Path.addCurve(to: CGPoint(x: 404.89, y: 337.12), controlPoint1: CGPoint(x: 404.76, y: 337.28), controlPoint2: CGPoint(x: 404.84, y: 337.19))
        bezier3Path.close()
        UIColor.black.setFill()
        bezier3Path.fill()

        ////
        context.restoreGState()
    }

    // MARK: - Generated Images

    public dynamic class var imageOfNext: UIImage {
        if Cache.imageOfNext == nil {
            UIGraphicsBeginImageContextWithOptions(CGSize(width: 100, height: 180), false, 0)
            CoreDrawing.drawNext()
            
            Cache.imageOfNext = UIGraphicsGetImageFromCurrentImageContext()?.withRenderingMode(.alwaysTemplate)
            UIGraphicsEndImageContext()
        }
        
        if let imageOfNext = Cache.imageOfNext {
            return imageOfNext
        } else {
            fatalError("imageOfNext is nil")
        }
    }

    public dynamic class var imageOfVolume: UIImage {
        if Cache.imageOfVolume == nil {
            UIGraphicsBeginImageContextWithOptions(CGSize(width: 71, height: 128), false, 0)
            CoreDrawing.drawVolume()
            
            Cache.imageOfVolume = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
        if let imageOfVolume = Cache.imageOfVolume {
            return imageOfVolume
        } else {
            fatalError("imageOfVolume is nil")
        }
    }

    public dynamic class var imageOfPlayRevert: UIImage {
        if Cache.imageOfPlayRevert == nil {
            UIGraphicsBeginImageContextWithOptions(CGSize(width: 90, height: 180), false, 0)
            CoreDrawing.drawPlayRevert()
            
            Cache.imageOfPlayRevert = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
        if let imageOfPlayRevert = Cache.imageOfPlayRevert {
            return imageOfPlayRevert
        } else {
            fatalError("imageOfPlayRevert is nil")
        }
    }
    
    public dynamic class var imageOfPlayBack: UIImage {
        if Cache.imageOfPlayBack == nil {
            UIGraphicsBeginImageContextWithOptions(CGSize(width: 115, height: 180), false, 0)
            CoreDrawing.drawPlayBack()
            
            Cache.imageOfPlayBack = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
        if let imageOfPlayBack = Cache.imageOfPlayBack {
            return imageOfPlayBack
        } else {
            fatalError("imageOfPlayBack is nil")
        }
    }
    
    public dynamic class var imageOfVolumeMax: UIImage {
        if Cache.imageOfVolumeMax == nil {
            UIGraphicsBeginImageContextWithOptions(CGSize(width: 128, height: 128), false, 0)
            CoreDrawing.drawVolumeMax()
            
            Cache.imageOfVolumeMax = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
        
        if let imageOfVolumeMax = Cache.imageOfVolumeMax {
            return imageOfVolumeMax
        } else {
            fatalError("imageOfVolumeMax is nil")
        }
    }
    
    public dynamic class var imageOfPause: UIImage {
        if Cache.imageOfPause != nil {
            return Cache.imageOfPause!
        }
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 90, height: 180), false, 0)
        CoreDrawing.drawPause()
        
        Cache.imageOfPause = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return Cache.imageOfPause!
    }
    
    public dynamic class var imageOfFastBackward: UIImage {
        if Cache.imageOfFastBackward != nil {
            return Cache.imageOfFastBackward!
        }
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 200, height: 180), false, 0)
        CoreDrawing.drawFastBackward()
        
        Cache.imageOfFastBackward = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return Cache.imageOfFastBackward!
    }
    
    public dynamic class var imageOfFoward: UIImage {
        if Cache.imageOfFoward != nil {
            return Cache.imageOfFoward!
        }
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 150, height: 180), false, 0)
        CoreDrawing.drawFoward()
        
        Cache.imageOfFoward = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return Cache.imageOfFoward!
    }
    
    public dynamic class var imageOfVolumeMin: UIImage {
        if Cache.imageOfVolumeMin != nil {
            return Cache.imageOfVolumeMin!
        }
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 102, height: 128), false, 0)
        CoreDrawing.drawVolumeMin()
        
        Cache.imageOfVolumeMin = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return Cache.imageOfVolumeMin!
    }
    
    public dynamic class var imageOfBackward: UIImage {
        if Cache.imageOfBackward != nil {
            return Cache.imageOfBackward!
        }
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 150, height: 180), false, 0)
        CoreDrawing.drawBackward()
        
        Cache.imageOfBackward = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return Cache.imageOfBackward!
    }
    
    public dynamic class var imageOfPlayNext: UIImage {
        if Cache.imageOfPlayNext != nil {
            return Cache.imageOfPlayNext!
        }
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 115, height: 180), false, 0)
        CoreDrawing.drawPlayNext()
        
        Cache.imageOfPlayNext = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return Cache.imageOfPlayNext!
    }
    
    public dynamic class var imageOfFastFoward: UIImage {
        if Cache.imageOfFastFoward != nil {
            return Cache.imageOfFastFoward!
        }
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 200, height: 180), false, 0)
        CoreDrawing.drawFastFoward()
        
        Cache.imageOfFastFoward = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return Cache.imageOfFastFoward!
    }
    
    public dynamic class var imageOfBack: UIImage {
        if Cache.imageOfBack != nil {
            return Cache.imageOfBack!
        }
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 100, height: 180), false, 0)
        CoreDrawing.drawBack()
        
        Cache.imageOfBack = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return Cache.imageOfBack!
    }
    
    public dynamic class var imageOfPlay: UIImage {
        if Cache.imageOfPlay != nil {
            return Cache.imageOfPlay!
        }
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 90, height: 180), false, 0)
        CoreDrawing.drawPlay()
        
        Cache.imageOfPlay = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return Cache.imageOfPlay!
    }
    
    public dynamic class var imageOfFullScreen: UIImage {
        if Cache.imageOfFullScreen != nil {
            return Cache.imageOfFullScreen!
        }
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 128, height: 128), false, 0)
        CoreDrawing.drawFullScreen()
        
        Cache.imageOfFullScreen = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return Cache.imageOfFullScreen!
    }
    
    public dynamic class var imageOfExitFullScreen: UIImage {
        if Cache.imageOfExitFullScreen != nil {
            return Cache.imageOfExitFullScreen!
        }
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 128, height: 128), false, 0)
        CoreDrawing.drawExitFullScreen()
        
        Cache.imageOfExitFullScreen = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return Cache.imageOfExitFullScreen!
    }
    
    public dynamic class var imageOfDefaultView: UIImage {
        if Cache.imageOfDefaultView != nil {
            return Cache.imageOfDefaultView!
        }
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 128, height: 73), false, 0)
        CoreDrawing.drawDefaultView()
        
        Cache.imageOfDefaultView = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return Cache.imageOfDefaultView!
    }
    
    public dynamic class var imageOfCheckmark: UIImage {
        if Cache.imageOfCheckmark != nil {
            return Cache.imageOfCheckmark!
        }
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 64, height: 64), false, 0)
        CoreDrawing.drawCheckmark()
        
        Cache.imageOfCheckmark = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return Cache.imageOfCheckmark!
    }
    
    public dynamic class var imageOfSettingsFilled: UIImage {
        if Cache.imageOfSettingsFilled != nil {
            return Cache.imageOfSettingsFilled!
        }
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 500, height: 500), false, 0)
        CoreDrawing.drawSettingsFilled()
        
        Cache.imageOfSettingsFilled = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return Cache.imageOfSettingsFilled!
    }
    
    public dynamic class var imageOfSettings: UIImage {
        if Cache.imageOfSettings != nil {
            return Cache.imageOfSettings!
        }
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 500, height: 500), false, 0)
        CoreDrawing.drawSettings()
        
        Cache.imageOfSettings = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return Cache.imageOfSettings!
    }
    
    public dynamic class var imageOfTheaterMode: UIImage {
        if Cache.imageOfTheaterMode != nil {
            return Cache.imageOfTheaterMode!
        }
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 128, height: 73), false, 0)
        CoreDrawing.drawTheaterMode()
        
        Cache.imageOfTheaterMode = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return Cache.imageOfTheaterMode!
    }
    
    public dynamic class var imageOfSoundMuted: UIImage {
        if Cache.imageOfSoundMuted != nil {
            return Cache.imageOfSoundMuted!
        }
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 128, height: 128), false, 0)
        CoreDrawing.drawSoundMuted()
        
        Cache.imageOfSoundMuted = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return Cache.imageOfSoundMuted!
    }

    // MARK: - Customization Infrastructure

    @IBOutlet fileprivate dynamic var nextTargets: [AnyObject]! {
        get { return Cache.nextTargets }
        set {
            Cache.nextTargets = newValue
            for target: AnyObject in newValue {
                _ = target.perform(NSSelectorFromString("setImage:"), with: CoreDrawing.imageOfNext)
            }
        }
    }

    @IBOutlet fileprivate dynamic var volumeTargets: [AnyObject]! {
        get { return Cache.volumeTargets }
        set {
            Cache.volumeTargets = newValue
            for target: AnyObject in newValue {
                _ = target.perform(NSSelectorFromString("setImage:"), with: CoreDrawing.imageOfVolume)
            }
        }
    }

    @IBOutlet fileprivate dynamic var playRevertTargets: [AnyObject]! {
        get { return Cache.playRevertTargets }
        set {
            Cache.playRevertTargets = newValue
            for target: AnyObject in newValue {
                _ = target.perform(NSSelectorFromString("setImage:"), with: CoreDrawing.imageOfPlayRevert)
            }
        }
    }

    @objc(CoreDrawingResizingBehavior)
    public enum ResizingBehavior: Int {
        case aspectFit /// The content is proportionally resized to fit into the target rectangle.
        case aspectFill /// The content is proportionally resized to completely fill the target rectangle.
        case stretch /// The content is stretched to match the entire target rectangle.
        case center /// The content is centered in the target rectangle, but it is NOT resized.

        public func apply(rect: CGRect, target: CGRect) -> CGRect {
            if rect == target || target == CGRect.zero {
                return rect
            }

            var scales = CGSize.zero
            scales.width = abs(target.width / rect.width)
            scales.height = abs(target.height / rect.height)

            switch self {
                case .aspectFit:
                    scales.width = min(scales.width, scales.height)
                    scales.height = scales.width
                case .aspectFill:
                    scales.width = max(scales.width, scales.height)
                    scales.height = scales.width
                case .stretch:
                    break
                case .center:
                    scales.width = 1
                    scales.height = 1
            }

            var result = rect.standardized
            result.size.width *= scales.width
            result.size.height *= scales.height
            result.origin.x = target.minX + (target.width - result.width) / 2
            result.origin.y = target.minY + (target.height - result.height) / 2
            return result
        }
    }
}
