//
//  FreelancersTableViewCell.swift
//  Food For All
//
//  Created by Daniel Jones on 1/22/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class FreelancersTableViewCell: UITableViewCell {
    var theProfileImageView: CircularImageView!
    var theTitleLabel: UILabel = UILabel()
    var thePriceLabel: UILabel = UILabel()
    
    var gig: Gig?
    
    var cellHeight: CGFloat = 0
    
    init(gig: Gig, height: CGFloat) {
        super.init(style: .default, reuseIdentifier: "freelancerCell")
        self.cellHeight = height
        self.gig = gig
        profileViewSetup()
        titleLabelSetup()
        priceLabelSetup()
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
    
    fileprivate func titleLabelSetup() {
        theTitleLabel.text = gig?.title
        theTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightLight)
        self.addSubview(theTitleLabel)
        theTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(theProfileImageView)
            make.leading.equalTo(theProfileImageView.snp.trailing).offset(10)
        }
    }
    
    fileprivate func priceLabelSetup() {
        let unitText = "$ per hour"
        if let priceText = gig?.priceString {
            thePriceLabel.text = priceText + unitText
            thePriceLabel.textColor = CustomColors.JellyTeal
            thePriceLabel.font = UIFont.boldSystemFont(ofSize: 15)
            self.addSubview(thePriceLabel)
            thePriceLabel.snp.makeConstraints({ (make) in
                make.top.equalTo(theTitleLabel.snp.bottom).offset(5)
                make.leading.equalTo(theTitleLabel)
            })
        }
    }
    
    fileprivate func lineSetup() {
        let line: UIView = Helpers.line
        self.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.bottom.leading.trailing.equalTo(self)
            make.height.equalTo(1)
        }
    }
}
