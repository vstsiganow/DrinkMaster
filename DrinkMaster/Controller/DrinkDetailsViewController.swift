//
//  DrinkDetailsViewController.swift
//  DrinkMaster
//
//  Created by vtsyganov on 11.10.2021.
//

import UIKit

class DrinkDetailsViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var drinkImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var alcoholeTypeLabel: UILabel!
    
    
    var drink: Drink?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    // MARK: - Methods
    func loadData(drinkId: String) {
        NetworkManager.shared.getDrink(drinkId: drinkId, completion: { result in
            DispatchQueue.main.async { [self] in
                switch result {
                case .success(let drink):
                    self.drink = drink
                case .failure:
                    self.drink = nil
                }
                guard let drink = self.drink else { return }
                
                self.configuration(from: drink)
            }
        })
    }
    
    
    // MARK: - Private Methods
    private func configuration(from drink: Drink) {
        fetchImage(from: drink.imageURL)
    
        descriptionLabel.text = drink.instructions
        alcoholeTypeLabel.text = "Type: \(String(describing: drink.alcoholic))"
        title = drink.name
        
        let textColor = UIColor.black
        
        self.descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        self.descriptionLabel.textColor = textColor
        
        self.alcoholeTypeLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        self.alcoholeTypeLabel.textColor = textColor
        
        self.drinkImageView.imageShadow(
            containerView: containerView,
            cornerRadious: 15,
            shadowColor: UIColor.black.cgColor,
            shadowOpacity: 0.5,
            shadowOffset: CGSize(width: 0, height: 0),
            shadowRadius: 2
        )
    }
    
    private func fetchImage(from url: String) {
        let imageSize: CGSize = containerView.layer.frame.size
        
        guard let imageUrl = URL(string: url) else {
            drinkImageView.image = UIImage(named: "empty")?.resizeImage(targetSize: imageSize)
            return
        }

        // Используем из кеша
        if let cachedImage = CachManager.shared.getCachedImage(for: imageUrl) {
            drinkImageView.image = cachedImage.resizeImage(targetSize: imageSize)
            return
        }

        // Если нет в кеше – попросить из сети
        ImageManager.shared.getImage(from: imageUrl) { (data, response) in
            DispatchQueue.main.async {
                self.drinkImageView.image = UIImage(data: data)?.resizeImage(targetSize: imageSize)
            }

            // поместить в кеш
            CachManager.shared.saveDataToCache(with: data, response: response)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
