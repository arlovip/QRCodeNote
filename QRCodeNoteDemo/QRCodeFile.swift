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
        filter?.setValue(data, forKey: "InputMessage")
        if let outputImage = filter?.outputImage {
            let value = max(frame.width, frame.height)
            self.image = QRCode.createImage(inputCIImage: outputImage, floatValue: value)
        }
    }
}

private struct QRCode {
    
    static func createImage(inputCIImage: CIImage, floatValue: CGFloat) -> UIImage {
        
        let extent = inputCIImage.extent.integral
        let scale = min(floatValue / extent.width, floatValue / extent.height)
        
        // First. Create bit map
        let width = extent.width * scale
        let height = extent.height * scale
        let cs = CGColorSpaceCreateDeviceGray()
        
        let cgContext = CGContext(data: nil,
                                  width: Int(width),
                                  height: Int(height),
                                  bitsPerComponent: 8,
                                  bytesPerRow: 0,
                                  space: cs,
                                  bitmapInfo: CGImageAlphaInfo.none.rawValue)
        
        let ciContext = CIContext(options: nil)
        
        let ciImage = ciContext.createCGImage(inputCIImage, from: extent)
        guard let ciimage = ciImage else {
            return UIImage()
        }
        
        cgContext?.interpolationQuality = .none
        cgContext?.scaleBy(x: scale, y: scale)
        cgContext?.draw(ciimage, in: extent)
        
        // Second. Save CIImage to CGImage
        let cgImage = cgContext?.makeImage()
        guard let cgimage = cgImage else {
            return UIImage()
        }
        
        return UIImage(cgImage: cgimage)
    }
}


