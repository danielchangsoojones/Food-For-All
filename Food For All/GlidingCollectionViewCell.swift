//
//  GlidingCollectionViewCell.swift
//  Food For All
//
//  Created by Daniel Jones on 4/15/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class GlidingCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.white
        //Need to use contentView corner radius, or if we use self.corner radius, then the shadow will not show
        contentView.layer.cornerRadius = 10
        addShadow()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func addShadow() {
        contentView.clipsToBounds = true
        
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 7
        
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
}
