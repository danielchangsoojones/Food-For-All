//
//  ProfileView.swift
//  Food For All
//
//  Created by Daniel Jones on 2/3/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class ProfileView: UIView {
    var theTopBackgroundView: UIView = UIView()
    var theNameLabel: UILabel = UILabel()
    var theProfileCircleView: CircularImageView!
    var theTableHolderView: UIView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        topBackgroundViewSetup()
        tableViewHolderSetup()
        self.backgroundColor = UIColor.blue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//top area
extension ProfileView {
    fileprivate func topBackgroundViewSetup() {
        theTopBackgroundView.frame = CGRect(x: 0, y: 0, w: self.frame.width, h: self.frame.height * 0.4)
        CustomColors.addGradient(colors: CustomColors.creationGradientColors, to: theTopBackgroundView)
        self.addSubview(theTopBackgroundView)
        profileCircleSetup()
        nameLabelSetup()
    }
    
    fileprivate func profileCircleSetup() {
        theProfileCircleView = CircularImageView(file: nil, diameter: 113)
        theTopBackgroundView.addSubview(theProfileCircleView)
        theProfileCircleView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
    
    fileprivate func nameLabelSetup() {
        theNameLabel.textColor = UIColor.white
        theNameLabel.font = UIFont.systemFont(ofSize: 25, weight: UIFontWeightMedium)
        theTopBackgroundView.addSubview(theNameLabel)
        theNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(theProfileCircleView.snp.bottom).inset(5)
            make.centerX.equalTo(theProfileCircleView)
        }
    }
}

//table view
extension ProfileView {
    fileprivate func tableViewHolderSetup() {
        self.addSubview(theTableHolderView)
        theTableHolderView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(theTopBackgroundView.snp.bottom)
        }
    }
}
