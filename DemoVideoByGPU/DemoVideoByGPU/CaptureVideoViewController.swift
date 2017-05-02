//
//  CaptureVideoViewController.swift
//  DemoVideoByGPU
//
//  Created by Nguyen Minh on 5/2/17.
//  Copyright © 2017 AHDEnglish. All rights reserved.
//

import UIKit
import GPUImage
import AVFoundation
import Photos
import SnapKit

class CaptureVideoViewController: UIViewController {

    @IBOutlet weak var gpuView: GPUImageView!
    var videoCamera: GPUImageVideoCamera?
    var movieWriter: GPUImageMovieWriter?
    var uiElementInput: GPUImageUIElement?
    var noneFilter: GPUImageFilter?
    var blendFilter: GPUImageNormalBlendFilter?
    var overlayView: OverlayView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        videoCamera = GPUImageVideoCamera(sessionPreset: AVCaptureSessionPresetHigh, cameraPosition: .back)
        videoCamera!.outputImageOrientation = .portrait
        
        var movieUrl: URL?
        do {
            let documentsDir = try FileManager.default.url(for:.documentDirectory, in:.userDomainMask, appropriateFor:nil, create:true)
            movieUrl = URL(string:"test.mp4", relativeTo:documentsDir)!
            try FileManager.default.removeItem(at: movieUrl!)
        } catch {
            //NOP
        }
        
        noneFilter = GPUImageFilter()
        videoCamera?.addTarget(noneFilter)
        
        blendFilter = GPUImageNormalBlendFilter()
        movieWriter = GPUImageMovieWriter(movieURL: movieUrl, size: gpuView.frame.size)
        movieWriter?.encodingLiveVideo = true
        
        noneFilter?.addTarget(blendFilter)
        blendFilter?.addTarget(gpuView)
        videoCamera?.startCapture()
        
        addUIElementView()
    }
    
    @IBAction func startRecording(_ sender: UIButton?) {
        videoCamera?.audioEncodingTarget = movieWriter
        blendFilter?.addTarget(movieWriter)
        movieWriter?.startRecording()
    }
    
    @IBAction func pauseRecording(_ sender: AnyObject?) {
        movieWriter?.isPaused = true
    }
    
    @IBAction func resumeRecording(_ sender: AnyObject?) {
        movieWriter?.isPaused = false
    }
    
    @IBAction func stopRecording(_ sender: AnyObject?) {
        blendFilter?.removeTarget(movieWriter)
        videoCamera?.audioEncodingTarget = nil
        movieWriter?.finishRecording(completionHandler: {[unowned self] in
            self.saveToCameraRoll()
        })
        
        let metadata = movieWriter?.assetWriter.metadata //
        print("Metadata: \(String(describing: metadata))")
    }
    
    func saveToCameraRoll() {
        do {
            let documentsDir = try FileManager.default.url(for:.documentDirectory, in:.userDomainMask, appropriateFor:nil, create:true)
            let fileURL = URL(string:"test.mp4", relativeTo:documentsDir)!
            
            PHPhotoLibrary.shared().performChanges({
                PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: fileURL)
            }) { saved, error in
                if saved {
                    let alertController = UIAlertController(title: "Your video was successfully saved", message: nil, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        } catch {
            //NOP
        }
    }
}

//MARK: - More features
extension CaptureVideoViewController {
    func addUIElementView() {
        overlayView = OverlayView()
        overlayView.frame = gpuView.frame
        uiElementInput = GPUImageUIElement(view: overlayView)
        uiElementInput?.addTarget(blendFilter)
        
        noneFilter?.frameProcessingCompletionBlock = {[unowned self] filter, time in
            self.updateUIElementView(withTimestamp: time)
            self.uiElementInput?.update(withTimestamp: time)
        }
    }
    
    func updateUIElementView(withTimestamp: CMTime) {
        overlayView.updateUIElementView(withTimestamp: withTimestamp)
    }
}

extension CaptureVideoViewController {
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        var orient: UIInterfaceOrientation = .portrait
        switch UIDevice.current.orientation {
        case .landscapeLeft:
            orient = .landscapeLeft
            break
        case .landscapeRight:
            orient = .landscapeRight
            break
        case .portrait:
            orient = .portrait
            break
        case .portraitUpsideDown:
            orient = .portraitUpsideDown
            break
        case .faceUp, .faceDown, .unknown:
            orient = fromInterfaceOrientation
            break
        }
        videoCamera?.outputImageOrientation = orient
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .allButUpsideDown
    }
}
