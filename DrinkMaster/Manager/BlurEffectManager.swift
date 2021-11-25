//
//  BlurEffectManager.swift
//  DrinkMaster
//
//  Created by vtsyganov on 11.11.2021.
//

import UIKit

class BlurEffectManager {
    
    private init() {}
    
    static let shared = BlurEffectManager()
    
    func blurImage(imageView: UIImageView, style: UIBlurEffect.Style, label: UILabel, vibrancy: Bool) {
        let blurEffect = UIBlurEffect(style: style)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        imageView.addSubview(blurredEffectView)
        
        scaleToFillView(blurredEffectView, in: imageView)
        
        if vibrancy {
            setVibrancyEffect(blurEffect: blurEffect, blurredEffectView: blurredEffectView, imageView: imageView, label: label)
        }
    }
    
    private func scaleToFillView(_ view: UIView, in parent: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                view.leadingAnchor.constraint(equalTo: parent.leadingAnchor),
                view.trailingAnchor.constraint(equalTo: parent.trailingAnchor),
                view.widthAnchor.constraint(equalTo: parent.widthAnchor),
                view.heightAnchor.constraint(equalTo: parent.heightAnchor)
            ]
        )
    }
    
    private func setVibrancyEffect(
        blurEffect: UIBlurEffect,
        blurredEffectView: UIVisualEffectView,
        imageView: UIImageView,
        label: UILabel
    ) {
        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
        let vibrancyEffectView = UIVisualEffectView(effect: vibrancyEffect)
        vibrancyEffectView.translatesAutoresizingMaskIntoConstraints = false
        
        vibrancyEffectView.frame = imageView.bounds
                
        vibrancyEffectView.contentView.addSubview(label)
        blurredEffectView.contentView.addSubview(vibrancyEffectView)
        
        NSLayoutConstraint.activate(
            [
                label.centerXAnchor.constraint(equalTo: vibrancyEffectView.centerXAnchor),
                label.centerYAnchor.constraint(equalTo: vibrancyEffectView.centerYAnchor)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                vibrancyEffectView.heightAnchor.constraint(equalTo: blurredEffectView.contentView.heightAnchor),
                vibrancyEffectView.widthAnchor.constraint(equalTo: blurredEffectView.contentView.widthAnchor),
                vibrancyEffectView.centerXAnchor.constraint(equalTo: blurredEffectView.contentView.centerXAnchor),
                vibrancyEffectView.centerYAnchor.constraint(equalTo: blurredEffectView.contentView.centerYAnchor)
            ]
        )
    }
    
}
