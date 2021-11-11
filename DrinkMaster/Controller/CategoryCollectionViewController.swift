//
//  CategoryCollectionViewController.swift
//  DrinkMaster
//
//  Created by vtsyganov on 16.10.2021.
//

import UIKit

class CategoryCollectionViewController: UICollectionViewController {
    
    // MARK: - Properties
    private var categories = [Category]()
    private let sectionInsets = UIEdgeInsets(
        top: 15.0,
        left: 15.0,
        bottom: 15.0,
        right: 15.0
    )
    private let itemsPerRow: CGFloat = 2
    
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var reloadButton: UIButton!
    
    
    // MARK: - View loads methods
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadData()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showDrinksVC",
              let drinksVC = segue.destination as? DrinksCollectionViewController,
              let category = sender as? Category
        else {
            return
        }
        
        drinksVC.setup(category: category)
    }
    
    // MARK: - UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.categoryCellIdentifier, for: indexPath) as! CategoryCell
        
        let category = categories[indexPath.row]
        cell.configuration(category: category)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = categories[indexPath.row]
        self.performSegue(withIdentifier: "showDrinksVC", sender: category)
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    // MARK: - Private Methods
    private func reloadData() {
        showLoading()
        NetworkManager.shared.getCategories(completion: { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let categories):
                    self.categories = categories.reversed()
                    self.showData()
                case .failure:
                    self.categories = []
                    self.showError()
                }
                self.collectionView.reloadData()
            }
        })
    }
    
    func showLoading() {
        loadingView.isHidden = false
        activityIndicatorView.startAnimating()
        errorLabel.isHidden = true
        reloadButton.isHidden = true
    }

    func showData() {
        loadingView.isHidden = true
        activityIndicatorView.stopAnimating()
        errorLabel.isHidden = true
        reloadButton.isHidden = true
    }

    func showError() {
        loadingView.isHidden = false
        activityIndicatorView.stopAnimating()
        errorLabel.isHidden = false
        reloadButton.isHidden = false
    }
    
    // MARK: - IB Actions
    @IBAction func onReloadButtonTapped(_ sender: Any) {
        reloadData()
    }
   
}

extension CategoryCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    // MARK: - Flow Layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = collectionView.bounds.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        let heightPerItem = widthPerItem + 20
        print(paddingSpace, availableWidth, widthPerItem, heightPerItem)
        //return CGSize(width: widthPerItem, height: heightPerItem)
        return CGSize(width: 170, height: 200)
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
