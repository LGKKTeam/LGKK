//
//  FlagIcons.swift
//  drivethrough
//
//  Created by Nguyen Minh on 3/28/17.
//  Copyright © 2017 SP. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics

open class SpriteSheet {
    
    typealias GridSize = (cols: Int, rows: Int)
    
    typealias ImageSize = (width: Int, height: Int)
    
    struct SheetInfo {
        fileprivate(set) var gridSize: GridSize
        fileprivate(set) var spriteSize: ImageSize
        fileprivate(set) var codes: [String]
    }
    
    fileprivate(set) var info: SheetInfo
    
    fileprivate(set) var image: UIImage
    
    fileprivate(set) var colorSpace: CGColorSpace
    
    fileprivate var imageData: UnsafeMutableRawPointer?
    
    fileprivate var imageCache = [String:UIImage]()
    
    fileprivate var cgImage: CGImage {
        if let cgImage = image.cgImage {
            return cgImage
        } else {
            fatalError("cgImage is nil")
        }
    }
    
    fileprivate var bitsPerComponent: Int {
        return cgImage.bitsPerComponent
    }
    
    fileprivate var bitsPerPixel: Int {
        return bitsPerComponent * 4
    }
    
    var imageSize: CGSize {
        return image.size
    }
    
    var spriteBytesPerRow: Int {
        return 4 * info.spriteSize.width
    }
    
    var spriteBytesCount: Int {
        return spriteBytesPerRow * info.spriteSize.height
    }
    
    var sheetBytesPerRow: Int {
        return spriteBytesPerRow * info.gridSize.rows
    }
    
    var sheetBytesPerCol: Int {
        return spriteBytesCount * info.gridSize.cols
    }
    
    var sheetBytesCount: Int {
        return sheetBytesPerRow * Int(imageSize.height)
    }
    
    var bitmapInfo: CGBitmapInfo {
        let imageBitmapInfo = cgImage.bitmapInfo
        let imageAlphaInfo = CGImageAlphaInfo.premultipliedLast
        return CGBitmapInfo(rawValue:
            (imageBitmapInfo.rawValue & (CGBitmapInfo.byteOrderMask.rawValue)) |
                (imageAlphaInfo.rawValue & (CGBitmapInfo.alphaInfoMask.rawValue)))
    }
    
    var bytes: UnsafeMutablePointer<UInt8> {
        if let imageData = imageData {
            return imageData.assumingMemoryBound(to: UInt8.self)
        } else {
            fatalError("imageData is nil")
        }
    }
    
    init?(sheetImage: UIImage, info sInfo: SheetInfo) {
        image = sheetImage
        info = sInfo
        guard let cgImage = sheetImage.cgImage else {
            return nil
        }
        
        guard let cgColorSpace = cgImage.colorSpace else {
            return nil
        }
        colorSpace = cgColorSpace
        
        let memory = (sheetBytesCount * MemoryLayout<UInt8>.stride, MemoryLayout<UInt8>.alignment)
        let bytes = UnsafeMutableRawPointer.allocate(bytes: memory.0, alignedTo: memory.1)
        
        guard let bmpCtx = CGContext(data: bytes,
                                     width: Int(imageSize.width),
                                     height: Int(imageSize.height),
                                     bitsPerComponent: bitsPerComponent,
                                     bytesPerRow: 4 * Int(imageSize.width),
                                     space: colorSpace,
                                     bitmapInfo: bitmapInfo.rawValue) else {
            bytes.deallocate(bytes: memory.0, alignedTo: memory.1)
            return
        }
        imageData = bytes
        bmpCtx.draw(cgImage, in: CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
    }
    
    open func getImageFor(_ code: String, deepCopy: Bool = true, scale: CGFloat = 2) -> UIImage? {
        var cimg = imageCache[code]
        if nil == cimg || deepCopy {
            let data = getBytesFor(code)
            
            if deepCopy {
                guard let bmpCtx = CGContext(
                    data: nil,
                    width: info.spriteSize.width,
                    height: info.spriteSize.height,
                    bitsPerComponent: bitsPerComponent,
                    bytesPerRow: 4 * info.spriteSize.width,
                    space: colorSpace,
                    bitmapInfo: bitmapInfo.rawValue
                    ) else {
                    return nil
                }
                
                if let bmpData = bmpCtx.data {
                    var srcData = UnsafeMutablePointer<UInt8>(mutating: data)
                    var curData = bmpData.assumingMemoryBound(to: UInt8.self)
                    for _ in 0..<info.spriteSize.height {
                        curData.assign(from: srcData, count: spriteBytesPerRow)
                        curData = curData.advanced(by: spriteBytesPerRow)
                        srcData = srcData.advanced(by: sheetBytesPerRow)
                    }
                    
                    if let bmpImage = bmpCtx.makeImage() {
                        return UIImage(
                            cgImage: bmpImage,
                            scale: scale,
                            orientation: UIImageOrientation.up
                            ).withRenderingMode(.alwaysOriginal)
                    }
                }
                
                return nil
            }
            
            let provider = CGDataProvider(dataInfo: nil,
                                          data: data,
                                          size: sheetBytesPerRow * info.spriteSize.height,
                                          releaseData: { _ in })
            
            guard let providerNotNil = provider, let cgImage = CGImage(
                width: info.spriteSize.width,
                height: info.spriteSize.height,
                bitsPerComponent: bitsPerComponent,
                bitsPerPixel: bitsPerPixel,
                bytesPerRow: sheetBytesPerRow,
                space: colorSpace,
                bitmapInfo: bitmapInfo,
                provider: providerNotNil,
                decode: nil,
                shouldInterpolate: true,
                intent: CGColorRenderingIntent.defaultIntent
                ) else {
                return nil
            }
            cimg = UIImage(cgImage: cgImage)
            imageCache[code] = cimg
        }
        
        return cimg
    }
    
    func getBytesFor(_ code: String) -> UnsafePointer<UInt8> {
        let idx = info.codes.index(of: code.lowercased()) ?? 0
        let dx = idx % info.gridSize.cols
        let dy = Int(Double(idx) / Double(info.gridSize.rows))
        let data = bytes.advanced(by: sheetBytesPerCol * dy + spriteBytesPerRow * dx)
        return UnsafePointer<UInt8>(data)
    }
    
    deinit {
        imageCache.removeAll()
        if let data = imageData {
            let memory = (sheetBytesCount * MemoryLayout<UInt8>.stride, MemoryLayout<UInt8>.alignment)
            data.deallocate(bytes: memory.0, alignedTo: memory.1)
        }
        imageData = nil
    }
}

open class FlagIcons: NSObject {
    static let sharedInstance = FlagIcons()
    var spriteSheet: SpriteSheet?
    
    override init() {
        super.init()
        
        spriteSheet = FlagIcons.loadDefault()
    }
    
    open class func loadDefault() -> SpriteSheet? {
        guard let assetsBundle = assetsBundle() else {
            return nil
        }
        
        if let infoFile = assetsBundle.path(forResource: "flags", ofType: "json") {
            return self.loadSheetFrom(infoFile)
        }
        
        return nil
    }
    
    open class func loadSheetFrom(_ file: String) -> SpriteSheet? {
        guard let assetsBundle = assetsBundle() else {
            return nil
        }
        
        if let infoData = try? Data(contentsOf: URL(fileURLWithPath: file)) {
            do {
                let rawObj = try JSONSerialization.jsonObject(with: infoData,
                                                              options: JSONSerialization.ReadingOptions(rawValue: 0))
                if let infoObj = rawObj as? [String:Any] {
                    if let gridSizeObj = infoObj["gridSize"] as? [String:Int],
                        let spriteSizeObj = infoObj["spriteSize"] as? [String:Int] {
                        let gridSize = (gridSizeObj["cols"]!, gridSizeObj["rows"]!)
                        let spriteSize = (spriteSizeObj["width"]!, spriteSizeObj["height"]!)
                        
                        if let codes = (infoObj["codes"] as? String)?.components(separatedBy: "|") {
                            if let sheetFileName = infoObj["sheetFile"] as? String,
                                let resourceUrl = assetsBundle.resourceURL {
                                let sheetFileUrl = resourceUrl.appendingPathComponent(sheetFileName)
                                if let image = UIImage(contentsOfFile: sheetFileUrl.path) {
                                    let info = SpriteSheet.SheetInfo(gridSize: gridSize,
                                                                     spriteSize: spriteSize,
                                                                     codes: codes)
                                    return SpriteSheet(sheetImage: image, info:  info)
                                }
                            }
                        }
                    }
                }
            } catch {
            }
        }
        return nil
    }
    
    fileprivate class func assetsBundle() -> Bundle? {
        let bundle = Bundle(for: self)
        guard let assetsBundlePath = bundle.path(forResource: "flag-assets", ofType: "bundle") else {
            return nil
        }
        return Bundle(path: assetsBundlePath)
    }
}
