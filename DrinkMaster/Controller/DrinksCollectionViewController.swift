//
//  DrinksCollectionViewController.swift
//  DrinkMaster
//
//  Created by vtsyganov on 16.10.2021.
//

import UIKit

class DrinksCollectionViewController: UICollectionViewController {
    private let segueIdentifier = "showDrinkDetails"
    
    //private let category: Category? = nil
    private var drinks = [ShortDrink]()
    
    private let sectionInsets = UIEdgeInsets(
        top: 15.0,
        left: 15.0,
        bottom: 15.0,
        right: 15.0
    )
    private let itemsPerRow: CGFloat = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == segueIdentifier,
              let drinkDetailsVC = segue.destination as? DrinkDetailsViewController,
              let drink = sender as? ShortDrink
        else {
            return
        }
        
        drinkDetailsVC.shortDrink = drink
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return drinks.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DrinkCell.drinkCellIdentifier, for: indexPath) as! DrinkCell
        let drink = drinks[indexPath.row]
        
        cell.configuration(drink: drink)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let drink = drinks[indexPath.row]
        self.performSegue(withIdentifier: segueIdentifier, sender: drink)
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    // MARK: - Methods
    
    func setup(category: Category) {
        reloadData(categoryCode: category.URLCode)
        self.title = category.title
    }
    
    // MARK: - Private Methods
    
    private func reloadData(categoryCode: String) {
        NetworkManager.shared.getShortDrinks(categoryCode: categoryCode, completion: { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let shortDrinks):
                    self.drinks = shortDrinks.reversed()
                case .failure:
                    self.drinks = []
                }
                self.collectionView.reloadData()
            }
        })
    }
}

extension DrinksCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = collectionView.bounds.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        let heightPerItem = widthPerItem * 1.15
        
        return CGSize(width: widthPerItem, height: heightPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

//extension DrinksCollectionViewController: UICollectionViewDataSourcePrefetching {
//    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
//        for indexPath in indexPaths {
//            let drink = drinks[indexPath.row]
//
//        }
//    }
//
//}
