//
//  DrinkCell.swift
//  DrinkMaster
//
//  Created by vtsyganov on 16.10.2021.
//

import UIKit

class DrinkCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    static let drinkCellIdentifier = "DrinkCell"
    private var initialLoad = true
    
    override func prepareForReuse() {
        initialLoad = true
    }
    
    func configuration(drink item: ShortDrink) {
        
        titleLabel.text = item.name
        
        if initialLoad {
            imageView.image = fetchImage(from: item.imageURL).thumbnailOfSize(containerView.bounds.size)
        }
        
        initialLoad = false
        
        imageView.setImageCornerRadiusAndShadows(
            conteiner: containerView,
            cornerRadius: 20,
            offset: CGSize(width: 1, height: 1),
            color: UIColor.gray.cgColor,
            opacity: 0.8,
            shadowRadius: 4
        )
    }
    
    private func fetchImage(from url: String) -> UIImage {
        var image = UIImage(named: "Empty")!
        
        guard let imageUrl = URL(string: url) else {
            return image
        }

        // Используем из кеша
        if let cachedImage = CachManager.shared.getCachedImage(for: imageUrl) {
            image = cachedImage
            return image
        }

        // Если нет в кеше – попросить из сети
        ImageManager.shared.getImage(from: imageUrl) { (data, response) in
            DispatchQueue.main.async {
                image = UIImage(data: data) ?? UIImage(named: "Empty")!
            }
            
            // поместить в кеш
            CachManager.shared.saveDataToCache(with: data, response: response)
        }
        
        return image
    }
}
