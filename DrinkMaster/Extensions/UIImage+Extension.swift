//
//  UIImage+Extension.swift
//  DrinkMaster
//
//  Created by vtsyganov on 10.10.2021.
//

import UIKit

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
}

extension UIImage {
  func thumbnailOfSize(_ size: CGSize) -> UIImage {
    UIGraphicsBeginImageContext(CGSize(width: size.width, height: size.height))
    let rect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
    UIGraphicsBeginImageContext(rect.size)
    draw(in: rect)
    let thumbnail = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext()
    return thumbnail!
  }
}

extension UIImageView {
    func setImageCornerRadiusAndShadows(conteiner: UIView, cornerRadius: CGFloat, offset: CGSize, color: CGColor, opacity: Float, shadowRadius: CGFloat) {
        self.layer.masksToBounds = true
        self.clipsToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = cornerRadius
        
        conteiner.layer.cornerRadius = cornerRadius
        conteiner.layer.shadowOffset = offset
        conteiner.layer.shadowColor = color
        conteiner.layer.shadowRadius = shadowRadius
        conteiner.layer.shadowOpacity = opacity
        conteiner.layer.shouldRasterize = true
        conteiner.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius).cgPath
    }
}
