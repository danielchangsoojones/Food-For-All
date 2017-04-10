//
//  CategoryCollectionViewCell.swift
//  Food For All
//
//  Created by Daniel Jones on 4/10/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    override var reuseIdentifier: String? {
        return CategoryCollectionViewCell.identifier
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.green
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CategoryCollectionViewCell {
    static let identifier = "categoryCollectionCell"
}
