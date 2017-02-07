//
//  GigItemView.swift
//  Food For All
//
//  Created by Daniel Jones on 2/6/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class GigItemView: UIView {
    var theElementView: UIView!
    var theAccessoryView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        elementViewSetup()
        accessoryViewSetup()
        bottomLineSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func elementViewSetup() {
        theElementView = UILabel()
        self.addSubview(theElementView)
        theElementView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(DetailView.Constants.sideInset)
        }
    }
    
    fileprivate func accessoryViewSetup() {
        let coloredImage = #imageLiteral(resourceName: "ArrowHead").withRenderingMode(.alwaysTemplate)
        theAccessoryView = UIImageView(image: coloredImage)
        theAccessoryView.tintColor = CustomColors.BombayGray
        self.addSubview(theAccessoryView)
        theAccessoryView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(DetailView.Constants.sideInset)
        }
    }
    
    fileprivate func bottomLineSetup() {
        let line = Helpers.line
        self.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.leading.equalTo(theElementView)
            make.trailing.equalTo(theAccessoryView)
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }

}
