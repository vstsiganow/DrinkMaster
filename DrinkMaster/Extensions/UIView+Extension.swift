//
//  UIView+Extension.swift
//  DrinkMaster
//
//  Created by vtsyganov on 20.11.2021.
//

import UIKit

extension UIView {
    func setViewCornerRadiusAndShadows(conteiner: UIView, cornerRadius: CGFloat, offset: CGSize, color: CGColor, opacity: Float, shadowRadius: CGFloat) {
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
