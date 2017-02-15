//
//  NewRatingView.swift
//  Food For All
//
//  Created by Daniel Jones on 2/14/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class NewRatingView: CustomScrollerView {
    struct Constants {
        static let sideInset: CGFloat = 10
    }
    
    var theTitleLabel: UILabel!
    var theCosmosView: MyCosmosView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        titleSetup()
        starSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func titleSetup() {
        theTitleLabel = UILabel()
        theTitleLabel.text = "New Rating"
        theTitleLabel.font = UIFont.systemFont(ofSize: 30, weight: UIFontWeightMedium)
        theContentView.addSubview(theTitleLabel)
        theTitleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.leading.trailing.equalToSuperview().inset(Constants.sideInset)
        }
    }
    
    fileprivate func starSetup() {
        theCosmosView = MyCosmosView(rating: 0)
        let starTuple = calculateStarsDimensions()
        theCosmosView.settings.starMargin = Double(starTuple.margin)
        theCosmosView.settings.starSize = Double(starTuple.width)
        theContentView.addSubview(theCosmosView)
        theCosmosView.snp.makeConstraints { (make) in
            make.leading.equalTo(theTitleLabel)
            make.top.equalTo(theTitleLabel.snp.bottom).offset(20)
        }
    }
    
    fileprivate func calculateStarsDimensions() -> (width: CGFloat, margin: CGFloat) {
        let targetWidth: CGFloat = self.frame.width * 0.6
        let numOfStars: CGFloat = 5
        let targetStarWidth: CGFloat = targetWidth * (1 / (numOfStars + 3)) //so 1/5 would become 1/7, so the star size doesn't fill the entire width and leaves space for margins
        let targetStarMargin: CGFloat = (targetWidth - targetStarWidth * numOfStars) / (numOfStars - 1)
        return (targetStarWidth, targetStarMargin)
    }
}
