//
//  CustomerPopUpView.swift
//  Food For All
//
//  Created by Daniel Jones on 3/4/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class CustomerPopUpView: CalendarPopUpView {
    var theTimeButton: UIButton!
    var theNextButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        timeButtonSetup()
        nextButtonSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func timeButtonSetup() {
        theTimeButton = TimeButton()
        self.addSubview(theTimeButton)
        theTimeButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(theDayLabel.snp.bottom).offset(10)
        }
    }
    
    fileprivate func nextButtonSetup() {
        theNextButton = Helpers.stylizeButton(text: "Next")
        self.addSubview(theNextButton)
        theNextButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(theTimeButton.snp.bottom).offset(10)
        }
    }

}
