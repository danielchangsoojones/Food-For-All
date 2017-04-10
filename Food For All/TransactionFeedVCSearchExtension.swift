//
//  TransactionFeedVCSearchExtension.swift
//  Food For All
//
//  Created by Daniel Jones on 4/8/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import UIKit

extension TransactionFeedViewController: SearchNavBarDelegate {
    func navBarSetup() {
        if let navBar = navBar as? SearchNavigationBar {
            navBar.navDelegate = self
            navBar.addGradient()
            navBar.addSearchView()
            tagCollectionViewSetup(navBar: navBar)
        }
    }
    
    func searchTapped() {
        let searchVC = MainSearchingViewController()
        if let category = SearchCategory(rawValue: title ?? "") {
            searchVC.searchCategory = category
        }
        pushVC(searchVC)
    }
}
