//
//  PersonalReviewTableViewCell.swift
//  Food For All
//
//  Created by Daniel Jones on 2/15/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class PersonalReviewTableViewCell: ReviewTableViewCell {
    override init(review: Review) {
        super.init(review: review)
        editButtonSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func editButtonSetup() {
        let editButton = UIButton()
        editButton.setTitle("Edit", for: .normal)
        editButton.setTitleColor(CustomColors.JellyTeal, for: .normal)
        editButton.titleLabel?.font = theDateLabel.font
        theHeaderView.addSubview(editButton)
        editButton.snp.makeConstraints { (make) in
            make.trailing.equalTo(theStarsView)
            make.firstBaseline.equalTo(theDateLabel)
        }
    }
}
