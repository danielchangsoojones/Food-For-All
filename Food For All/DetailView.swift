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
    }
    
    var theTopView: UIView = UIView()
    var theNameLabel: UILabel = UILabel()
    var theProfileImageView: CircularImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.red
        topViewSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func topViewSetup() {
        theContentView.addSubview(theTopView)
        theTopView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(Constants.topViewHeight)
            make.bottom.equalTo(theContentView)
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
        theTopView.addSubview(theNameLabel)
        theNameLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().inset(10)
            make.trailing.equalTo(theProfileImageView.snp.leading)
            make.top.equalTo(theProfileImageView)
        }
    }
}
