//
//  DrinkDetailsViewController.swift
//  DrinkMaster
//
//  Created by vtsyganov on 11.10.2021.
//

import UIKit

class DrinkDetailsViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var drinkImageContainerView: UIView!
    @IBOutlet weak var informationView: UIView!
    @IBOutlet weak var informationContainerView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var drinkImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var alcoholeTypeLabel: UILabel!
    
    // MARK: - Properties
    var shortDrink: ShortDrink!
    var drink: Drink?
    
    // MARK: - View Cicles Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData(shortDrink: shortDrink)
    }
    
    // MARK: - Open Methods
    func loadData(shortDrink: ShortDrink) {
        NetworkManager.shared.getDrink(drinkId: shortDrink.id, completion: { result in
            DispatchQueue.main.async { [self] in
                switch result {
                case .success(let drink):
                    self.drink = drink[0]
                case .failure:
                    self.drink = nil
                }
                
                configuration(from: drink)
            }
        })
    }
    
    // MARK: - Private Methods
    private func setViewControllerAppearance() {
        let textColor = UIColor.black
        
        backgroundView.backgroundColor = .clear
        informationView.backgroundColor = .white
        scrollView.backgroundColor = .white.withAlphaComponent(0.8)
        
        drinkImageView.setImageCornerRadiusAndShadows(
            conteiner: drinkImageContainerView,
            cornerRadius: 25,
            offset: CGSize(width: 4, height: 4),
            color: UIColor.gray.cgColor,
            opacity: 0.8,
            shadowRadius: 10
        )
        
        informationView.setViewCornerRadiusAndShadows(
            conteiner: informationContainerView,
            cornerRadius: 15,
            offset: CGSize(width: 0, height: 2),
            color: UIColor.gray.cgColor,
            opacity: 0.8,
            shadowRadius: 3
        )
        
        //descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .black)
        descriptionLabel.textColor = textColor
        
        //alcoholeTypeLabel.font = UIFont.systemFont(ofSize: 14, weight: .black)
        alcoholeTypeLabel.textColor = textColor
    }

    private func configuration(from drink: Drink?) {
        let defaultText = "No data."
        
        if let drink = drink {
            fetchImage(from: drink.imageURL)
            
            descriptionLabel.text = "\(drink.instructions ?? defaultText)"
            alcoholeTypeLabel.text = "\(drink.alcoholic ?? defaultText)"
            title = drink.name
        } else {
            fetchImage(from: shortDrink.imageURL)
            
            descriptionLabel.text = defaultText
            title = shortDrink.name
            
            alcoholeTypeLabel.isHidden = true
        }

        setViewControllerAppearance()
    }
    
    private func fetchImage(from url: String) {
        guard let imageUrl = URL(string: url) else {
            drinkImageView.image = UIImage(named: "Empty")
            return
        }
        
        // Используем из кеша
        if let cachedImage = CachManager.shared.getCachedImage(for: imageUrl) {
            drinkImageView.image = cachedImage
            return
        }
        
        // Если нет в кеше – попросить из сети
        ImageManager.shared.getImage(from: imageUrl) { (data, response) in
            DispatchQueue.main.async {
                self.drinkImageView.image = UIImage(data: data)
            }
            
            // поместить в кеш
            CachManager.shared.saveDataToCache(with: data, response: response)
        }
    }
}
