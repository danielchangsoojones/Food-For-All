//
//  TimeButton.swift
//  Food For All
//
//  Created by Daniel Jones on 3/16/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class TimeButton: UIButton {
    init() {
        super.init(frame: CGRect.zero)
        titleLabel?.font = CalendarPopUpView.Constants.font.withSize(12)
        setTitleColor(CustomColors.SilverChalice, for: .normal)
        backgroundColor = CustomColors.Polar
        setCornerRadius(radius: 14)
        let horInset: CGFloat = 10
        let vertInset: CGFloat = horInset / 2
        contentEdgeInsets = UIEdgeInsets(top: vertInset, left: horInset, bottom: vertInset, right: horInset)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
