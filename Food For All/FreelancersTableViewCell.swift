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
    
    init(gig: Gig) {
        super.init(style: .default, reuseIdentifier: "freelancerCell")
        self.gig = gig
        profileViewSetup()
        titleLabelSetup()
        priceLabelSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func profileViewSetup() {
        theProfileImageView = CircularImageView(file: gig?.creator.profileImage, diameter: self.frame.height * 0.75)
        self.addSubview(theProfileImageView)
        theProfileImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.leading.equalTo(self).inset(self.frame.width * 0.1)
        }
    }
    
    fileprivate func titleLabelSetup() {
        theTitleLabel.text = gig?.title
        self.addSubview(theTitleLabel)
        theTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(theProfileImageView)
            make.leading.equalTo(theProfileImageView.snp.trailing).offset(10)
        }
    }
    
    fileprivate func priceLabelSetup() {
        let unitText = "/hr"
        if let priceText = gig?.price.toString {
            thePriceLabel.text = priceText + unitText
            self.addSubview(thePriceLabel)
            thePriceLabel.snp.makeConstraints({ (make) in
                make.top.equalTo(theTitleLabel.snp.bottom).inset(5)
                make.leading.equalTo(theTitleLabel)
            })
        }
    }

}
