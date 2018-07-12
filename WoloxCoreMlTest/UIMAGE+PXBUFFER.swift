import UIKit

extension UIImage {
    public func pixelBuffer(width: Int, height: Int) -> CVPixelBuffer? {
        var maybePixelBuffer: CVPixelBuffer?
        let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue,
                     kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue]
        let status = CVPixelBufferCreate(kCFAllocatorDefault,
                                         width,
                                         height,
                                         kCVPixelFormatType_32ARGB,
                                         attrs as CFDictionary,
                                         &maybePixelBuffer)
        
        guard status == kCVReturnSuccess, let pixelBuffer = maybePixelBuffer else {
            return nil
        }
        
        CVPixelBufferLockBaseAddress(pixelBuffer, CVPixelBufferLockFlags(rawValue: 0))
        let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer)
        
        guard let context = CGContext(data: pixelData,
                                      width: width,
                                      height: height,
                                      bitsPerComponent: 8,
                                      bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer),
                                      space: CGColorSpaceCreateDeviceRGB(),
                                      bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)
            else {
                return nil
        }
        
        context.translateBy(x: 0, y: CGFloat(height))
        context.scaleBy(x: 1, y: -1)
        
        UIGraphicsPushContext(context)
        self.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        UIGraphicsPopContext()
        CVPixelBufferUnlockBaseAddress(pixelBuffer, CVPixelBufferLockFlags(rawValue: 0))
        
        return pixelBuffer
    }
    
    public func resize(size: CGSize) -> UIImage? {
        let rect = CGRect(origin: CGPoint(x:0, y:0), size: size)
        UIGraphicsBeginImageContext(size)
        self.draw(in: rect)
        let pic1 = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        let data = UIImagePNGRepresentation(pic1)!
        return UIImage(data: data)
        
    }
}

extension CVPixelBuffer {
    
    public var width: Int {
        return CVPixelBufferGetWidth(self)
    }
    
    public var height: Int {
        return CVPixelBufferGetHeight(self)
    }
    
    public var frame: CGRect {
        return CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: width, height: height))
    }
    
    public func uiImage() -> UIImage? {
        let ciimage = CIImage(cvPixelBuffer: self)
        let temp = CIContext()
        let cgimageRef = temp.createCGImage(ciimage,from: frame)!
        return UIImage(cgImage: cgimageRef)
    }
}
