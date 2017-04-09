//
//  FlagKit.swift
//  MobileTrading
//
//  Created by Nguyen Minh on 4/6/17.
//  Copyright © 2017 AHDEnglish. All rights reserved.
//

import UIKit
import Foundation
import CoreGraphics

open class SpriteSheet {
    
    typealias GridSize = (cols: Int, rows: Int)
    typealias ImageSize = (width: CGFloat, height: CGFloat)
    typealias Margin = (top: CGFloat, left: CGFloat, right: CGFloat, bottom: CGFloat)
    
    struct SheetInfo {
        fileprivate(set) var gridSize: GridSize
        fileprivate(set) var spriteSize: ImageSize
        fileprivate(set) var spriteMargin: Margin
        fileprivate(set) var codes: [String]
    }
    fileprivate(set) var info: SheetInfo
    fileprivate(set) var image: UIImage
    fileprivate var imageCache = [String:UIImage]()
    
    init?(sheetImage: UIImage, info sInfo: SheetInfo) {
        image = sheetImage
        info = sInfo
    }
    
    func getImageFor(code: String) -> UIImage? {
        var cimg: UIImage?
        cimg = imageCache[code]
        if cimg == nil {
            let rect = getRectFor(code)
            cimg = image.cropped(to: rect)
            cimg = image.cropped(to: rect)
            imageCache[code] = cimg
        }
        
        return cimg
    }
    
    open func getRectFor(_ code: String) -> CGRect {
        let spriteW = info.spriteSize.width
        let spriteH = info.spriteSize.height
        let realSpriteW = spriteW - info.spriteMargin.left - info.spriteMargin.right
        let realSpriteH = spriteH - info.spriteMargin.top - info.spriteMargin.bottom
        let idx = info.codes.index(of: code.lowercased()) ?? 0
        let dx = idx % info.gridSize.cols
        let dy = idx/info.gridSize.cols
        let x = CGFloat(dx) * spriteW + info.spriteMargin.top
        let y = CGFloat(dy) * spriteH + info.spriteMargin.left
        return CGRect(x: x, y: y, width: realSpriteW, height: realSpriteH)
    }
    
    deinit {
        imageCache.removeAll()
    }
}

open class FlagKit: NSObject {
    static let shared = FlagKit()
    var spriteSheet: SpriteSheet?
    
    override init() {
        super.init()
        spriteSheet = FlagKit.loadDefault()
    }
    
    open class func loadDefault() -> SpriteSheet? {
        guard let assetsBundle = assetsBundle() else {
            return nil
        }
        
        if let infoFile = assetsBundle.path(forResource: "flags_v1", ofType: "json") {
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
                if let infoObj = try JSONSerialization.jsonObject(with: infoData, options: JSONSerialization.ReadingOptions(rawValue: 0)) as? [String:Any] {
                    if let gridSizeObj = infoObj["gridSize"] as? [String:Int],
                        let spriteSizeObj = infoObj["spriteSize"] as? [String:CGFloat],
                        let spriteMarginObj = infoObj["margin"] as? [String:CGFloat] {
                        let gridSize = (gridSizeObj["cols"]!, gridSizeObj["rows"]!)
                        let spriteSize = (spriteSizeObj["width"]!, spriteSizeObj["height"]!)
                        let spriteMargin = (spriteMarginObj["top"]!, spriteMarginObj["left"]!, spriteMarginObj["right"]!, spriteMarginObj["bottom"]!)
                        
                        if let codes = (infoObj["codes"] as? String)?.components(separatedBy: ",") {
                            if let sheetFileName = infoObj["sheetFile"] as? String,
                                let resourceUrl = assetsBundle.resourceURL {
                                let sheetFileUrl = resourceUrl.appendingPathComponent(sheetFileName)
                                if let image = UIImage(contentsOfFile: sheetFileUrl.path) {
                                    let info = SpriteSheet.SheetInfo(gridSize: gridSize, spriteSize: spriteSize, spriteMargin: spriteMargin, codes: codes)
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
        return Bundle(path: assetsBundlePath);
    }
    
}

extension UIImage {
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    
    /// Returns the data for the specified image in PNG format
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the PNG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    var png: Data? { return UIImagePNGRepresentation(self) }
    
    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    func jpeg(_ quality: JPEGQuality) -> Data? { return UIImageJPEGRepresentation(self, quality.rawValue) }
    
    /// UIImage Cropped to CGRect.
    ///
    /// - Parameter rect: CGRect to crop UIImage to.
    /// - Returns: cropped UIImage
    public func cropped(to rect: CGRect) -> UIImage {
        guard rect.size.height < size.height && rect.size.width < size.width else {
            return self
        }
        guard let image: CGImage = cgImage?.cropping(to: rect) else {
            return self
        }
        return UIImage(cgImage: image)
    }
}
