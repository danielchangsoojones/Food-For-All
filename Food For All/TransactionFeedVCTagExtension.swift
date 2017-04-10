//
//  TransactionFeedVCTagExtension.swift
//  Food For All
//
//  Created by Daniel Jones on 4/10/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import UIKit

extension TransactionFeedViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func tagCollectionViewSetup(navBar: SearchNavigationBar) {
        navBar.collectionViewSetup(delegate: self, dataSource: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath)
        return cell
    }
}
