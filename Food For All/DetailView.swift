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
    }
    
    var theTopView: UIView = UIView()
    var theNameLabel: UILabel = UILabel()
    var theProfileImageView: CircularImageView!
    var theTitleLabel: UILabel = UILabel()
    var theDescriptionLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        topViewSetup()
        titleSetup()
        descriptionSetup()
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
        nameLabelSetup()
    }
    
    fileprivate func profileImageSetup() {
        theProfileImageView = CircularImageView(file: nil, diameter: Constants.topViewHeight * 0.75)
        theTopView.addSubview(theProfileImageView)
        theProfileImageView.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
        }
    }
    
    fileprivate func nameLabelSetup() {
        theNameLabel.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightLight)
        theNameLabel.textColor = UIColor.white
        theTopView.addSubview(theNameLabel)
        theNameLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().inset(10)
            make.trailing.equalTo(theProfileImageView.snp.leading)
            make.top.equalTo(theProfileImageView)
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
            make.bottom.equalTo(theContentView)
        }
    }
}

//the pricing view
extension DetailView {
    
}
