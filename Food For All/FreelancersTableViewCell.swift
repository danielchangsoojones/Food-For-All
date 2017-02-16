//
//  FreelancersTableViewCell.swift
//  Food For All
//
//  Created by Daniel Jones on 1/22/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class FreelancersTableViewCell: UITableViewCell {
    struct Constants {
        static let verticalWordSpacing: CGFloat = 5
        static let sideInset: CGFloat = 10
    }

    var theProfileImageView: CircularImageView!
    var theNameLabel: UILabel = UILabel()
    var theServiceTitleLabel: UILabel = UILabel()
    var thePriceLabel: UILabel = UILabel()
    var theCosmosView: MyCosmosView!

    var gig: Gig?
    
    var cellHeight: CGFloat = 0
    
    init(gig: Gig, height: CGFloat) {
        super.init(style: .default, reuseIdentifier: "freelancerCell")
        self.cellHeight = height
        self.gig = gig
        profileViewSetup()
        nameLabelSetup()
        serviceTitleLabelSetup()
        priceLabelSetup()
        starsSetup()
        lineSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func profileViewSetup() {
        theProfileImageView = CircularImageView(file: gig?.frontImage, diameter: cellHeight * 0.75)
        self.addSubview(theProfileImageView)
        theProfileImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.leading.equalTo(self).inset(self.frame.width * 0.05)
        }
    }
    
    fileprivate func nameLabelSetup() {
        theNameLabel.text = gig?.creator.fullName
        theNameLabel.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightBold)
        self.addSubview(theNameLabel)
        theNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(theProfileImageView)
            make.leading.equalTo(theProfileImageView.snp.trailing).offset(Constants.sideInset)
        }
    }
    
    fileprivate func serviceTitleLabelSetup() {
        theServiceTitleLabel.text = gig?.title
        theServiceTitleLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightLight)
        self.addSubview(theServiceTitleLabel)
        theServiceTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(theNameLabel.snp.bottom).offset(Constants.verticalWordSpacing)
            make.leading.equalTo(theNameLabel)
        }
    }

    fileprivate func priceLabelSetup() {
        if let priceText = gig?.priceString {
            thePriceLabel.text = priceText
            thePriceLabel.textColor = CustomColors.JellyTeal
            thePriceLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightLight)
            self.addSubview(thePriceLabel)
            thePriceLabel.snp.makeConstraints({ (make) in
                make.top.equalTo(theServiceTitleLabel.snp.bottom).offset(Constants.verticalWordSpacing)
                make.leading.equalTo(theNameLabel)
            })
        }
    }
    
    fileprivate func starsSetup() {
        theCosmosView = MyCosmosView(rating: 0)
        theCosmosView.settings.starMargin = 0.5
        theCosmosView.settings.starSize = 16
        self.addSubview(theCosmosView)
        theCosmosView.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().inset(Constants.sideInset)
            make.centerY.equalTo(thePriceLabel)
        }
        
        let numOfReviews = gig?.numOfReviews
        let avgStars = gig?.avgStars
        if let numOfReviews = numOfReviews,let avgStars = avgStars, numOfReviews > 0, avgStars > 0 {
            theCosmosView.rating = avgStars
            setCosmosText(numOfRatings: numOfReviews)
        } else {
            theCosmosView.isHidden = true
        }
    }
    
    //until Cosmos Cocoapod gets updated where I can move the cosmos label to the left hand side, this is a hack around.
    fileprivate func setCosmosText(numOfRatings: Int) {
        let cosmosLabel = UILabel()
        cosmosLabel.text = "(\(numOfRatings))"
        cosmosLabel.font = UIFont.systemFont(ofSize: 13, weight: UIFontWeightLight)
        cosmosLabel.textColor = CustomColors.SilverChalice
        self.addSubview(cosmosLabel)
        cosmosLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(theCosmosView)
            make.trailing.equalTo(theCosmosView.snp.leading).offset(-2)
        }
        //so the price label doesn't overflow
        thePriceLabel.snp.makeConstraints { (make) in
            make.trailing.equalTo(cosmosLabel.snp.leading).priority(250)
        }
    }

    //TODO: can just change the tableView seperator instead
    fileprivate func lineSetup() {
        let line: UIView = Helpers.line
        self.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.bottom.leading.trailing.equalTo(self)
            make.height.equalTo(1)
        }
    }
}
