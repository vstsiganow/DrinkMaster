//
//  CategoryCell.swift
//  DrinkMaster
//
//  Created by vtsyganov on 16.10.2021.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    static let categoryCellIdentifier = "CategoryCell"
    
    func configuration(category item: Category) {
        titleLabel.text = item.title
        
        if let image = UIImage(named: item.imageCode) {
            imageView.image = image
        } else {
            imageView.image = UIImage(named: "Empty")
        }
        
        imageView.setImageCornerRadiusAndShadows(
            conteiner: containerView,
            cornerRadius: 20,
            offset: CGSize(width: 1, height: 1),
            color: UIColor.gray.cgColor,
            opacity: 0.8,
            shadowRadius: 4
        )
    }
}
