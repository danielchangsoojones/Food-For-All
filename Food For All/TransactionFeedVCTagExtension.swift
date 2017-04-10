//
//  TransactionFeedVCTagExtension.swift
//  Food For All
//
//  Created by Daniel Jones on 4/10/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import UIKit

extension TransactionFeedViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var categories: [String] {
        var categories = Helpers.categories
        if let milkIndex = Helpers.categories.index(of: Helpers.milkMooovers) {
            let milkMooovers = categories.remove(at: milkIndex)
            categories.insert(milkMooovers, at: 0)
        }
        return categories
    }
    
    
    func tagCollectionViewSetup(navBar: SearchNavigationBar) {
        navBar.collectionViewSetup(delegate: self, dataSource: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
        cell.setCategory(title: categories[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = categories[indexPath.row]
        let fontSize = text.size(attributes: [NSFontAttributeName: CategoryCollectionViewCell.TagProperties.tagFont])
        let tagWidth = fontSize.width + CategoryCollectionViewCell.TagProperties.paddingX * 2
        return CGSize(width: tagWidth, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        theSpinnerView = Helpers.showActivityIndicatory(uiView: self.view)
        let dataStore = TransactionFeedDataStore(delegate: self)
        dataStore.findGigsWith(tag: categories[indexPath.row])
    }
}
