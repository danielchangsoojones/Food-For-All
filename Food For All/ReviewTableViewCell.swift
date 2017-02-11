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
        static let headerHeight: CGFloat = 70
    }
    
    var theCircularProfileView: CircularImageView!
    var theHeaderView: UIView!
    var theNameLabel: UILabel!
    var theDateLabel: UILabel!
    
    var review: Review!
    
    init(review: Review) {
        super.init(style: .default, reuseIdentifier: "allReviewsCell")
        self.review = review
        headerViewSetup()
        profileImageSetup()
        nameSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func headerViewSetup() {
        theHeaderView = UIView(frame: CGRect.zero)
        self.addSubview(theHeaderView)
        theHeaderView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(70)
        }
    }
    
    fileprivate func profileImageSetup() {
        theCircularProfileView = CircularImageView(file: review.creator.profileImage, diameter: Constants.headerHeight)
        theHeaderView.addSubview(theCircularProfileView)
        theCircularProfileView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    fileprivate func nameSetup() {
        theNameLabel = UILabel()
        theNameLabel.text = review.creator.fullName
        theNameLabel.font = UIFont.systemFont(ofSize: 10, weight: UIFontWeightMedium)
        theHeaderView.addSubview(theNameLabel)
        theNameLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(theCircularProfileView.snp.trailing)
            make.top.equalTo(theCircularProfileView)
        }
    }

}
