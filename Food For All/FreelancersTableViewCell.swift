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
        static let cellHeight: CGFloat = 100
    }
    
    override var reuseIdentifier: String? {
        return FreelancersTableViewCell.identifier
    }

    var theProfileImageView: CircularImageView!
    var theNameLabel: UILabel = UILabel()
    var theServiceTitleLabel: UILabel = UILabel()
    var thePriceLabel: UILabel = UILabel()
    var theCosmosView: MyCosmosView!
    var theCosmosLabel: UILabel!

    var gig: Gig? {
        didSet {
            if let gig = gig {
                setContent(gig: gig)
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
    
    fileprivate func setContent(gig: Gig) {
        theProfileImageView.add(file: gig.frontImage)
        theNameLabel.text = gig.creator.fullName
        theServiceTitleLabel.text = gig.title
        thePriceLabel.text = gig.priceString
        let numOfReviews = gig.numOfReviews
        let avgStars = gig.avgStars
        if numOfReviews > 0 && avgStars > 0 {
            theCosmosView.rating = avgStars
            theCosmosLabel.text = "(\(numOfReviews))"
            theCosmosView.isHidden = false
            theCosmosLabel.isHidden = false
        } else {
            theCosmosView.isHidden = true
            theCosmosLabel.isHidden = true
        }
    }
    
    fileprivate func profileViewSetup() {
        theProfileImageView = CircularImageView(file: nil, diameter: Constants.cellHeight * 0.75)
        self.addSubview(theProfileImageView)
        theProfileImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.leading.equalTo(self).inset(self.frame.width * 0.05)
        }
    }
    
    fileprivate func nameLabelSetup() {
        theNameLabel.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightBold)
        self.addSubview(theNameLabel)
        theNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(theProfileImageView)
            make.leading.equalTo(theProfileImageView.snp.trailing).offset(Constants.sideInset)
        }
    }
    
    fileprivate func serviceTitleLabelSetup() {
        theServiceTitleLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightLight)
        self.addSubview(theServiceTitleLabel)
        theServiceTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(theNameLabel.snp.bottom).offset(Constants.verticalWordSpacing)
            make.leading.equalTo(theNameLabel)
        }
    }

    fileprivate func priceLabelSetup() {
        thePriceLabel.textColor = CustomColors.JellyTeal
        thePriceLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightLight)
        self.addSubview(thePriceLabel)
        thePriceLabel.snp.makeConstraints({ (make) in
            make.top.equalTo(theServiceTitleLabel.snp.bottom).offset(Constants.verticalWordSpacing)
            make.leading.equalTo(theNameLabel)
        })
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
        cosmosTextSetup()
    }
    
    //until Cosmos Cocoapod gets updated where I can move the cosmos label to the left hand side, this is a hack around.
    fileprivate func cosmosTextSetup() {
        theCosmosLabel = UILabel()
        theCosmosLabel.font = UIFont.systemFont(ofSize: 13, weight: UIFontWeightLight)
        theCosmosLabel.textColor = CustomColors.SilverChalice
        self.addSubview(theCosmosLabel)
        theCosmosLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(theCosmosView)
            make.trailing.equalTo(theCosmosView.snp.leading).offset(-2)
        }
        //so the price label doesn't overflow
        thePriceLabel.snp.makeConstraints { (make) in
            make.trailing.equalTo(theCosmosLabel.snp.leading).priority(250)
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

extension FreelancersTableViewCell {
    static let identifier = "freelancerTableCell"
}
