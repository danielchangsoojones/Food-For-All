//
//  TransactionHeadView.swift
//  Food For All
//
//  Created by Daniel Jones on 4/8/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class TransactionHeadView: UIView {
    struct Constants {
        static let height: CGFloat = 70
    }
    
    var theProfileImageView: CircularImageView!
    var theTitleLabel: UILabel!
    var theStarsView: MyCosmosView!
    
    init(width: CGFloat) {
        super.init(frame: CGRect(x: 0, y: 0, w: width, h: Constants.height))
        profileImageViewSetup()
        titleLabelSetup()
        starsSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func profileImageViewSetup() {
        theProfileImageView = CircularImageView(file: nil, diameter: self.frame.height * 0.75)
        self.addSubview(theProfileImageView)
        theProfileImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
        }
    }
    
    fileprivate func titleLabelSetup() {
        theTitleLabel = UILabel()
        theTitleLabel.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(theTitleLabel)
        theTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(theProfileImageView)
            make.leading.equalTo(theProfileImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview()
        }
    }
    
    fileprivate func starsSetup() {
        theStarsView = MyCosmosView(rating: 0)
        self.addSubview(theStarsView)
        theStarsView.snp.makeConstraints { (make) in
            make.top.equalTo(theTitleLabel.snp.bottom).offset(7)
            make.leading.equalTo(theTitleLabel)
        }
    }
}

extension TransactionHeadView {
    func setContents(review: Review) {
        theProfileImageView.add(file: review.creator.profileImage)
        updateTitleLabel(review: review)
        theStarsView.rating = review.stars
    }
    
    fileprivate func updateTitleLabel(review: Review) {
        //TODO: make each name be bolded
        let creatorName: String = review.creator.theFirstName
        let freelancerName: String = review.gig?.creator.fullName ?? ""
        let title: String = "\(creatorName) reviewed \(freelancerName)"
        theTitleLabel.text = title
    }
}
