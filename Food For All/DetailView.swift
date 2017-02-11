//
//  DetailView.swift
//  Food For All
//
//  Created by Daniel Jones on 1/25/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class DetailView: CustomScrollerView {
    struct Constants {
        static let topViewHeight: CGFloat = 100
        static let spacing: CGFloat = 18
        static let sideInset: CGFloat = 10
    }
    
    var theTopView: UIView = UIView()
    var theNameLabel: UILabel = UILabel()
    var theProfileImageView: CircularImageView!
    var theTitleLabel: UILabel = UILabel()
    var theDescriptionLabel: UILabel = UILabel()
    var theBottomView: UIView = UIView()
    var thePriceLabel: UILabel = UILabel()
    var theMessageButton: UIButton = UIButton()
    var theExitButton: UIButton = UIButton()
    var theVenmoView: UIView!
    var theRatingView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        topViewSetup()
        titleSetup()
        descriptionSetup()
        ratingItemSetup()
        venmoItemSetup()
        bottomViewSetup()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//the top area
extension DetailView {
    fileprivate func topViewSetup() {
        theTopView.frame = CGRect(x: 0, y: 0, w: self.frame.width, h: Constants.topViewHeight)
        CustomColors.addGradient(colors: CustomColors.searchBarGradientColors, to: theTopView)
        theContentView.addSubview(theTopView)
        theTopView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(Constants.topViewHeight)
        }
        profileImageSetup()
        exitButtonSetup()
        nameLabelSetup()
    }
    
    fileprivate func profileImageSetup() {
        theProfileImageView = CircularImageView(file: nil, diameter: Constants.topViewHeight * 0.75)
        theTopView.addSubview(theProfileImageView)
        theProfileImageView.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().inset(Constants.sideInset)
            make.centerY.equalToSuperview()
        }
    }
    
    fileprivate func nameLabelSetup() {
        theNameLabel.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightLight)
        theNameLabel.textColor = UIColor.white
        theTopView.addSubview(theNameLabel)
        theNameLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().inset(Constants.sideInset)
            make.trailing.equalTo(theProfileImageView.snp.leading)
            make.top.equalTo(theExitButton.snp.bottom).offset(10)
        }
    }
    
    fileprivate func exitButtonSetup() {
        theExitButton.setTitleColor(UIColor.white, for: .normal)
        theExitButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightBold)
        theExitButton.setTitle("X", for: .normal)
        theTopView.addSubview(theExitButton)
        theExitButton.snp.makeConstraints { (make) in
            make.top.equalTo(theTopView).inset(10)
            make.leading.equalToSuperview().inset(Constants.sideInset)
        }
    }
}

//the details of the gig
extension DetailView {
    fileprivate func titleSetup() {
        theTitleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        theContentView.addSubview(theTitleLabel)
        theTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(theTopView.snp.bottom).offset(Constants.spacing)
            make.leading.equalTo(theNameLabel)
        }
    }
    
    fileprivate func descriptionSetup() {
        theDescriptionLabel.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightLight)
        theContentView.addSubview(theDescriptionLabel)
        theDescriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(theTitleLabel.snp.bottom).offset(Constants.spacing)
            make.leading.equalTo(theTitleLabel)
            make.trailing.equalToSuperview().inset(Constants.sideInset)
        }
    }
}

//gig items
extension DetailView {
    fileprivate func venmoItemSetup() {
        theVenmoView = VenmoItemView(frame: CGRect.zero)
        theContentView.addSubview(theVenmoView)
        theVenmoView.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(theDescriptionLabel)
            make.top.equalTo(theRatingView.snp.bottom).offset(Constants.spacing)
            make.height.equalTo(70)
            make.bottom.equalTo(theContentView)
        }
    }
    
    fileprivate func ratingItemSetup() {
        theRatingView = RatingItemView(numOfReviews: 50, avgStars: 2.5)
        theContentView.addSubview(theRatingView)
        theRatingView.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(theDescriptionLabel)
            make.top.equalTo(theDescriptionLabel.snp.bottom).offset(Constants.spacing)
            make.height.equalTo(70)
        }
    }
}

//the pricing view
extension DetailView {
    fileprivate func bottomViewSetup() {
        self.addSubview(theBottomView)
        let height: CGFloat = 70
        theBottomView.snp.makeConstraints { (make) in
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(height)
        }
        priceLabelSetup()
        messageButtonSetup()
        addLineToBottomView()
        theScrollView.contentInset.bottom = height
        theBottomView.backgroundColor = UIColor.white
    }
    
    fileprivate func priceLabelSetup() {
        thePriceLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightLight)
        theBottomView.addSubview(thePriceLabel)
        thePriceLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalTo(theNameLabel)
        }
    }
    
    fileprivate func messageButtonSetup() {
        theMessageButton.setTitle("Message", for: .normal)
        let inset: CGFloat = 10
        theMessageButton.contentEdgeInsets.left = inset
        theMessageButton.contentEdgeInsets.right = inset
        theMessageButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightLight)
        theMessageButton.setTitleColor(UIColor.white, for: .normal)
        theMessageButton.backgroundColor = CustomColors.AquamarineBlue
        theMessageButton.layer.cornerRadius = 10
        theBottomView.addSubview(theMessageButton)
        theMessageButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(theDescriptionLabel)
            make.height.equalTo(theBottomView).multipliedBy(0.5)
        }
    }
    
    fileprivate func addLineToBottomView() {
        let line = Helpers.line
        theBottomView.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}
