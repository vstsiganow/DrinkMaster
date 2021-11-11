//
//  CategoryCell.swift
//  DrinkMaster
//
//  Created by vtsyganov on 16.10.2021.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    static let categoryCellIdentifier = "CategoryCell"
    
    func configuration(category item: Category) {
        let imageWidth = self.contentView.layer.bounds.size.width - 20
        let imageSize = CGSize(width: imageWidth, height: imageWidth)
        
        titleLabel.text = item.title
        
        if let image = UIImage(named: item.code) {
            imageView.image = image.thumbnailOfSize(imageWidth)
        } else {
            imageView.image = UIImage(named: "empty")?.thumbnailOfSize(imageWidth)
        }
        
        //imageView.image = imageView.image?.thumbnailOfSize(imageWidth)

        self.imageView.layer.cornerRadius = 15
        self.imageView.layer.masksToBounds = true
    }
}
