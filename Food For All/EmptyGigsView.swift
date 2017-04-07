//
//  EmptyGigsView.swift
//  Food For All
//
//  Created by Daniel Jones on 4/7/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class EmptyGigsView: UIView {
    var theMessageLabel: UILabel!
    var theCreateButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        labelSetup()
        createButtonSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func labelSetup() {
        theMessageLabel = UILabel()
        theMessageLabel.text = "Sorry! It looks like there are no freelancers for this type of service in your area. If you're incredibly angry, we suggest making a passive aggressive Facebook post. Or create your own service: "
        let bubbleColor = UIColor(red: CGFloat(57)/255, green: CGFloat(81)/255, blue: CGFloat(104)/255, alpha :1)
        theMessageLabel.textColor = bubbleColor
        theMessageLabel.numberOfLines = 0
        theMessageLabel.textAlignment = .center
        theMessageLabel.font = UIFont(name: "TrebuchetMS", size: 18)
        theMessageLabel.sizeToFit()
        self.addSubview(theMessageLabel)
        theMessageLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalToSuperview().offset(self.frame.height * 0.25)
        }
    }
    
    fileprivate func createButtonSetup() {
        theCreateButton = Helpers.stylizeButton(text: "Create")
        self.addSubview(theCreateButton)
        theCreateButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(theMessageLabel.snp.bottom).offset(20)
        }
    }

}
