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
            if !navBar.hasSearchViews {
                //only add subviews again, if they have been removed, so when we go to the creation page and come back, we don't want to place more views on the nav bar or else we'll have duplicates that overlap each other
                navBar.navDelegate = self
                navBar.addGradient()
                navBar.addSearchView()
                tagCollectionViewSetup(navBar: navBar)
            }
        }
    }
    
    func searchTapped() {
        let searchVC = MainSearchingViewController()
        pushVC(searchVC)
    }
}
