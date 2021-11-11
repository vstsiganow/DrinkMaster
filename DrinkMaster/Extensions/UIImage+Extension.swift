//
//  UIImage+Extension.swift
//  DrinkMaster
//
//  Created by vtsyganov on 10.10.2021.
//

import UIKit

extension UIImage {
    func resizeImage(targetSize: CGSize) -> UIImage {
        let size = self.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        let newSize = widthRatio > heightRatio ?  CGSize(width: size.width * heightRatio, height: size.height * heightRatio) : CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage ?? self
    }
}

extension UIImageView {
    func imageShadow(
        containerView : UIView,
        cornerRadious : CGFloat,
        shadowColor: CGColor,
        shadowOpacity: Float,
        shadowOffset: CGSize,
        shadowRadius: CGFloat
    ){
        containerView.clipsToBounds = false
        containerView.layer.shadowColor = shadowColor
        containerView.layer.shadowOpacity = shadowOpacity
        containerView.layer.shadowOffset = shadowOffset
        containerView.layer.shadowRadius = shadowRadius
        containerView.layer.cornerRadius = cornerRadious
        containerView.layer.shadowPath = UIBezierPath(roundedRect: containerView.bounds, cornerRadius: cornerRadious).cgPath
        
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadious
        self.layer.rasterizationScale = UIScreen.main.scale
        self.layer.shouldRasterize = true
    }
}

extension UIImage {
    func scalePreservingAspectRatio(targetSize: CGSize) -> UIImage {
        // Determine the scale factor that preserves aspect ratio
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        
        let scaleFactor = min(widthRatio, heightRatio)
        
        // Compute the new image size that preserves aspect ratio
        let scaledImageSize = CGSize(
            width: size.width * scaleFactor,
            height: size.height * scaleFactor
        )

        // Draw and return the resized UIImage
        let renderer = UIGraphicsImageRenderer(
            size: scaledImageSize
        )

        let scaledImage = renderer.image { _ in
            self.draw(in: CGRect(
                origin: .zero,
                size: scaledImageSize
            ))
        }
        
        return scaledImage
    }
    
    func scaleForSize(size: CGSize) -> UIImage {
        self.resizeImage(targetSize: size)
    }
}

extension UIImage {
  func thumbnailOfSize(_ size: CGFloat) -> UIImage {
    UIGraphicsBeginImageContext(CGSize(width: size, height: size))
    let rect = CGRect(x: 0.0, y: 0.0, width: size, height: size)
    UIGraphicsBeginImageContext(rect.size)
    draw(in: rect)
    let thumbnail = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext()
    return thumbnail!
  }
}
