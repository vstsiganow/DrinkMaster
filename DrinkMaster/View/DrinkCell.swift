//
//  DrinkCell.swift
//  DrinkMaster
//
//  Created by vtsyganov on 16.10.2021.
//

import UIKit

class DrinkCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    static let drinkCellIdentifier = "DrinkCell"
    
    func configuration(drink item: ShortDrink) {
        //let imageSize = CGSize(width: 140, height: 140)
        
        titleLabel.text = item.name
        
        fetchImage(from: item.imageURL)
        print(imageView.layer.bounds.size, item.name)

        self.imageView.layer.cornerRadius = 15
        self.imageView.clipsToBounds = true
        
    }
    
    private func fetchImage(from url: String) {
        //let imageSize = CGSize(width: 140, height: 140)
        let imageWidth = self.contentView.layer.bounds.size.width - 20
        let imageSize = CGSize(width: imageWidth, height: imageWidth)
        
        guard let imageUrl = URL(string: url) else {
            imageView.image = UIImage(named: "empty")?.scaleForSize(size: imageSize)
            return
        }

        // Используем из кеша
        if let cachedImage = CachManager.shared.getCachedImage(for: imageUrl) {
            imageView.image = cachedImage.scaleForSize(size: imageSize)
            return
        }

        // Если нет в кеше – попросить из сети
        ImageManager.shared.getImage(from: imageUrl) { (data, response) in
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: data)?.scaleForSize(size: imageSize)
            }

            // поместить в кеш
            CachManager.shared.saveDataToCache(with: data, response: response)
        }
    }
}
