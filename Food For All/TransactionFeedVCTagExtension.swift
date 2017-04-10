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
    var categories {
        let categories = Helpers.categories
        categories.insert("Milk Mooovers", at: categories.count - 1)
        return 
    }
    
    
    func tagCollectionViewSetup(navBar: SearchNavigationBar) {
        navBar.collectionViewSetup(delegate: self, dataSource: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
        cell.setCategory(title: "testing")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = "testing"
        let fontSize = text.size(attributes: [NSFontAttributeName: CategoryCollectionViewCell.TagProperties.tagFont])
        let tagWidth = fontSize.width + CategoryCollectionViewCell.TagProperties.paddingX * 2
        return CGSize(width: tagWidth, height: collectionView.frame.height)
    }
}
