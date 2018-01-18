//
//  QRCodeFile.swift
//  QRCodeNoteDemo
//
//  Created by langke on 2018/1/17.
//  Copyright © 2018年 langke. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func generateQRCodeWith(url: String) {
        let data = url.data(using: .utf8)
        // name is like the following which cannot be changed
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setDefaults()
        // key is like the following which cannot be changed
        filter?.setValue(data, forKey: "inputMessage")
        if let outputImage = filter?.outputImage {
            let scaleValue = max(frame.width, frame.height)
            self.image = QRCode.transformWith(inputCIImage: outputImage, scale: scaleValue)
        }
    }
}

private struct QRCode {
    
    static func transformWith(inputCIImage: CIImage, scale byValue: CGFloat) -> UIImage {
        
        let extent = inputCIImage.extent.integral
        let scale = min(byValue / extent.width, byValue / extent.height)
        
        let ciContext = CIContext(options: nil)
        let cgImage = ciContext.createCGImage(inputCIImage, from: extent)

        guard let cgImg = cgImage else {
            return UIImage()
        }
    
        let width = Int(extent.width * scale)
        let height = Int(extent.height * scale)
        let colorSpace = CGColorSpaceCreateDeviceGray()
        let bitmapInfo = CGImageAlphaInfo.none.rawValue
        
        let cgContext = CGContext(data: nil,
                                  width: width,
                                  height: height,
                                  bitsPerComponent: 8,
                                  bytesPerRow: 0,
                                  space: colorSpace,
                                  bitmapInfo: bitmapInfo)
        
        cgContext?.interpolationQuality = .none
        cgContext?.scaleBy(x: scale, y: scale)
        cgContext?.draw(cgImg, in: extent)

        guard let finalCGImage = cgContext?.makeImage() else {
            return UIImage()
        }
        
        return UIImage(cgImage: finalCGImage)
    }
}


