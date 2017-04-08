//
//  ViewController.swift
//  MobileTrading
//
//  Created by Nguyen Minh on 4/6/17.
//  Copyright © 2017 AHDEnglish. All rights reserved.
//

import UIKit
import Compression
import SwifterSwift

class ViewController: UIViewController {
    var objects: [NSObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        testCompressData()
        testFlagImage()
        testObjectExtension()
    }
    
    func testObjectExtension() {
        let obj1 = NSObject()
        _ = obj1.scheduleUpdate(delay: 5) { (obj, timer) in
            print("scheduleUpdate run after 5s: \(obj); \(timer)")
        }
        objects.append(obj1)
        let obj2 = NSObject()
        _ = obj2.scheduleUpdate(repeatInterval: 1, handler: { (obj, timer) in
            print("scheduleUpdate repeatInterval after 5s: \(obj); \(timer)")
        })
        objects.append(obj2)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5, execute: {
            obj2.stopScheduleUpdate()
        })
    }
    
    func testCompressData() {
        let bundle = Bundle.main
        let assetsBundlePath = bundle.path(forResource: "flag-assets", ofType: "bundle")
        let assetsBundle = Bundle(path: assetsBundlePath!)
        let sheetFileName = "flags.jpg"
        let resourceUrl = assetsBundle?.resourceURL
        if let sheetFileUrl = resourceUrl?.appendingPathComponent(sheetFileName) {
            if let image = UIImage(contentsOfFile: sheetFileUrl.path) {
                let originData = UIImagePNGRepresentation(image)
                print("origin: \(String(describing: originData?.count))")
                let lzma = originData?.compressed(using: .lzma)
                print("lzma: \(String(describing: lzma?.count))")
                
                let lzma1 = lzma?.compressed(using: .lzma)
                print("lzma1: \(String(describing: lzma1?.count))")
                saveData(lzma1!)
                
//                let decompressData = lzma?.uncompressed(using: .lzma)
//                let decompressImage = UIImage(data: decompressData!)
//                saveImage(decompressImage!)
            }
        }
    }
    
    func testFlagImage() {
        let spriteSheet = FlagKit.shared.spriteSheet
        _ = spriteSheet?.getImageFor(code: "vn")
//        saveImage(spriteSheet?.getImageFor(code: "vn"))
    }
    
    func saveImage(_ image: UIImage?) {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        // Get the Document directory path
        let documentDirectorPath:String = paths[0]
        // Create a new path for the new images folder
        let imagesDirectoryPath = documentDirectorPath.appending("/ImagePicker")
        var objcBool:ObjCBool = true
        let isExist = FileManager.default.fileExists(atPath: imagesDirectoryPath, isDirectory: &objcBool)
        // If the folder with the given path doesn't exist already, create it
        if isExist == false{
            do{
                try FileManager.default.createDirectory(atPath: imagesDirectoryPath, withIntermediateDirectories: true, attributes: nil)
            }catch{
                print("Something went wrong while creating a new folder")
            }
        }
        // Save image to Document directory
        var imagePath = "\(Date().unixTimestamp)"
        imagePath = imagePath.replacingOccurrences(of: " ", with: "")
        imagePath = imagesDirectoryPath.appending("/\(imagePath).png")
        let data = UIImagePNGRepresentation(image!)
        print("Image path: \(imagePath)")
        _ = FileManager.default.createFile(atPath: imagePath, contents: data, attributes: nil)
    }
    
    func saveData(_ data: Data) {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        // Get the Document directory path
        let documentDirectorPath:String = paths[0]
        // Create a new path for the new images folder
        let dataDirectoryPath = documentDirectorPath.appending("/ImagePicker")
        var objcBool:ObjCBool = true
        let isExist = FileManager.default.fileExists(atPath: dataDirectoryPath, isDirectory: &objcBool)
        // If the folder with the given path doesn't exist already, create it
        if isExist == false{
            do{
                try FileManager.default.createDirectory(atPath: dataDirectoryPath, withIntermediateDirectories: true, attributes: nil)
            }catch{
                print("Something went wrong while creating a new folder")
            }
        }
        // Save image to Document directory
        var dataPath = "\(Date().unixTimestamp)"
        dataPath = dataPath.replacingOccurrences(of: " ", with: "")
        dataPath = dataDirectoryPath.appending("/\(dataPath).dat")
        print("dataPath: \(dataPath)")
        _ = FileManager.default.createFile(atPath: dataPath, contents: data, attributes: nil)
    }
}

