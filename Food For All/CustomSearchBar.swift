//
//  CustomSearchBar.swift
//  Food For All
//
//  Created by Daniel Jones on 1/28/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class CustomSearchBar: UISearchBar {
    init() {
        super.init(frame: CGRect.zero)
        makeTransparent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func makeTransparent() {
        searchBarStyle = .minimal
    }
}
