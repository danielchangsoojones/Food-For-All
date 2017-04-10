//
//  TransactionContentView.swift
//  Food For All
//
//  Created by Daniel Jones on 4/8/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class TransactionContentView: UIView {
    var theTitleLabel: UILabel!
    var theDescriptionLabel: UILabel!
    
    init() {
        super.init(frame: CGRect.zero)
        titleLabelSetup()
        descriptionLabelSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setContents(review: Review) {
        theTitleLabel.text = review.title ?? review.gig?.title
        theDescriptionLabel.text = review.description
    }
    
    fileprivate func titleLabelSetup() {
        theTitleLabel = UILabel()
        theTitleLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightBold)
        self.addSubview(theTitleLabel)
        theTitleLabel.snp.makeConstraints { (make) in
            make.leading.top.trailing.equalToSuperview()
        }
    }
    
    fileprivate func descriptionLabelSetup() {
        theDescriptionLabel = UILabel()
        theDescriptionLabel.font = UIFont.systemFont(ofSize: 14)
        theDescriptionLabel.numberOfLines = 0
        self.addSubview(theDescriptionLabel)
        theDescriptionLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(theTitleLabel.snp.bottom).offset(5)
            make.bottom.equalToSuperview()
        }
    }
}
