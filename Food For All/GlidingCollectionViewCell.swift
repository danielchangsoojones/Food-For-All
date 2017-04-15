//
//  GlidingCollectionViewCell.swift
//  Food For All
//
//  Created by Daniel Jones on 4/15/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import GlidingCollection

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
        
        let config = GlidingConfig.shared
        layer.shadowOffset = config.cardShadowOffset
        layer.shadowColor = config.cardShadowColor.cgColor
        layer.shadowOpacity = config.cardShadowOpacity
        layer.shadowRadius = config.cardShadowRadius
        
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
}
