//
//  RatingItemView.swift
//  Food For All
//
//  Created by Daniel Jones on 2/11/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import Cosmos

class RatingItemView: GigItemView {
    struct Constants {
        static let starSize: Double = 20
    }
    
    var theStarsView = CosmosView(frame: CGRect.zero)
    
    init(numOfReviews: Int, avgStars: Double) {
        super.init(frame: CGRect.zero)
        titleSetup(numOfReviews: numOfReviews)
        ratingConfiguration(avgStars: avgStars)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func accessoryViewSetup() {
        theAccessoryView = theStarsView
        self.addSubview(theAccessoryView)
        theAccessoryView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    fileprivate func ratingConfiguration(avgStars: Double) {
        theStarsView.settings.fillMode = .full
        theStarsView.rating = avgStars
        theStarsView.settings.updateOnTouch = false
        
        theStarsView.settings.starSize = Constants.starSize
        theStarsView.settings.starMargin = 1
        
        theStarsView.settings.filledColor = CustomColors.JellyTeal
        theStarsView.settings.filledBorderColor = CustomColors.JellyTeal
        theStarsView.settings.emptyBorderColor = CustomColors.JellyTeal
        theStarsView.settings.emptyBorderWidth = 0.7
    }
    
    fileprivate func titleSetup(numOfReviews: Int) {
        let suffix = " Reviews"
        let title: String = numOfReviews.toString + suffix
        set(title: title)
        if let label = theElementView as? UILabel {
            label.textColor = CustomColors.JellyTeal
        }
    }
}
