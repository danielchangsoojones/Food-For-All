//
//  CircleProfileView.swift
//  ChachaT
//
//  Created by Daniel Jones on 9/9/16.
//  Copyright © 2016 Chong500Productions. All rights reserved.
//

import Foundation
import UIKit

class CircleProfileView: UIView {
    fileprivate struct ProfileViewConstants {
        static let circleViewCenterOffset: CGFloat = -10
    }
    
    let theNameLabel = UILabel()
    var circleView: CircleView!
    
    init(frame: CGRect, name: String, imageFile: AnyObject?) {
        super.init(frame: frame)
        let diameter = frame.size.width
        circleViewSetup(diameter, file: imageFile)
        nameLabelSetup(name)
    }
    
    //TODO: right now, I am ust using a constant to make an offset to show the name label, but I could probably be more exact about things.
    func circleViewSetup(_ diameter: CGFloat, file: AnyObject?) {
        circleView = CircularImageView(file: file, diameter: diameter)
        self.addSubview(circleView)
        circleView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).offset(ProfileViewConstants.circleViewCenterOffset)
        }
    }
    
    func nameLabelSetup(_ name: String) {
        theNameLabel.text = name
        theNameLabel.textColor = CustomColors.SilverChalice
        theNameLabel.lineBreakMode = .byClipping
        theNameLabel.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(theNameLabel)
        theNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(circleView.snp.bottom).offset(1)
            make.centerX.equalTo(self)
            make.width.lessThanOrEqualTo(circleView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
