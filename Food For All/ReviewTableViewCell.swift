//
//  ReviewTableViewCell.swift
//  Food For All
//
//  Created by Daniel Jones on 2/11/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {
    struct Constants {
        static let headerHeight: CGFloat = 50
        static let headerFontSize: CGFloat = 15
    }
    
    var theCircularProfileView: CircularImageView!
    var theHeaderView: UIView!
    var theNameLabel: UILabel!
    var theDateLabel: UILabel!
    var theContentView: UIView!
    
    var review: Review!
    
    init(review: Review) {
        super.init(style: .default, reuseIdentifier: "allReviewsCell")
        self.review = review
        headerViewSetup()
        contentViewSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//header view extension
extension ReviewTableViewCell {
    fileprivate func headerViewSetup() {
        theHeaderView = UIView(frame: CGRect.zero)
        self.addSubview(theHeaderView)
        theHeaderView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalToSuperview()
            make.height.equalTo(70)
        }
        profileImageSetup()
        nameSetup()
        dateSetup()
    }
    
    fileprivate func profileImageSetup() {
        theCircularProfileView = CircularImageView(file: review.creator.profileImage, diameter: Constants.headerHeight)
        theHeaderView.addSubview(theCircularProfileView)
        theCircularProfileView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    //TODO: the name and date should probably be better calculated on height, like maybe stick into a stack view and then fit to size or something. Right now, it is just hard coded.
    fileprivate func nameSetup() {
        theNameLabel = UILabel()
        theNameLabel.text = review.creator.firstName
        theNameLabel.font = UIFont.systemFont(ofSize: Constants.headerFontSize, weight: UIFontWeightMedium)
        theHeaderView.addSubview(theNameLabel)
        theNameLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(theCircularProfileView.snp.trailing).offset(10)
            make.top.equalTo(theCircularProfileView).offset(3)
        }
    }
    
    fileprivate func dateSetup() {
        theDateLabel = UILabel()
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, y"
        theDateLabel.text = formatter.string(from: review.updated)
        theDateLabel.font = UIFont.systemFont(ofSize: Constants.headerFontSize, weight: UIFontWeightLight)
        theHeaderView.addSubview(theDateLabel)
        theDateLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(theNameLabel)
            make.top.equalTo(theNameLabel.snp.bottom).offset(5)
        }
    }
}

//description
extension ReviewTableViewCell {
    func contentViewSetup() {
        theContentView = UIView()
        theContentView.backgroundColor = UIColor.red
        self.addSubview(theContentView)
        theContentView.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(theHeaderView)
            make.top.equalTo(theHeaderView.snp.bottom)
            make.bottom.equalToSuperview()
        }
    }
}
