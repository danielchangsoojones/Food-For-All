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
    }

    var theProfileImageView: CircularImageView!
    var theNameLabel: UILabel = UILabel()
    var theServiceTitleLabel: UILabel = UILabel()
    var thePriceLabel: UILabel = UILabel()

    
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
            make.leading.equalTo(theProfileImageView.snp.trailing).offset(10)
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
