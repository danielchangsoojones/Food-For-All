//
//  BottomLabelButtonView.swift
//  Food For All
//
//  Created by Daniel Jones on 3/12/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class BottomLabelButtonView: UIView {
    var theButton: UIButton!
    
    init(frame: CGRect, buttonImage: UIImage, title: String) {
        super.init(frame: frame)
        buttonSetup(image: buttonImage)
        labelSetup(title: title)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func buttonSetup(image: UIImage) {
        theButton = UIButton()
        theButton.setImage(image, for: .normal)
        theButton.backgroundColor = UIColor.white
        theButton.addBorder(width: 1, color: CustomColors.BombayGray)
        let side = self.frame.width
        let inset = side * 0.25
        theButton.imageEdgeInsets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        theButton.setCornerRadius(radius: side / 2)
        self.addSubview(theButton)
        theButton.snp.makeConstraints { (make) in
            make.top.centerX.equalToSuperview()
            make.height.width.equalTo(side)
        }
    }
    
    fileprivate func labelSetup(title: String) {
        let label = UILabel()
        label.text = title
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 10, weight: UIFontWeightBold)
        self.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.top.equalTo(theButton.snp.bottom).offset(4)
            make.centerX.equalTo(self)
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return self.frame.size
    }
}
