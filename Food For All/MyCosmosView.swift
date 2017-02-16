//
//  MyCosmosView.swift
//  Food For All
//
//  Created by Daniel Jones on 2/14/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import Cosmos

class MyCosmosView: CosmosView {
    init(rating: Double) {
        super.init(frame: CGRect.zero)
        settings.fillMode = .full
        self.rating = rating
        settings.updateOnTouch = false
        
        settings.starMargin = 1
        
        settings.filledColor = CustomColors.JellyTeal
        settings.filledBorderColor = CustomColors.JellyTeal
        settings.emptyBorderColor = CustomColors.JellyTeal
        settings.emptyBorderWidth = 0.7
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
