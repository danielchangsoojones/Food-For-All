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
    
    func elementViewSetup() {
        theElementView = UILabel()
        elementViewPosition()
    }
    
    func elementViewPosition() {
        self.addSubview(theElementView)
        theElementView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
        }
    }
    
    fileprivate func accessoryViewSetup() {
        let coloredImage = #imageLiteral(resourceName: "ArrowHead").withRenderingMode(.alwaysTemplate)
        theAccessoryView = UIImageView(image: coloredImage)
        theAccessoryView.contentMode = .scaleAspectFit
        theAccessoryView.tintColor = CustomColors.BombayGray
        self.addSubview(theAccessoryView)
        theAccessoryView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview()
            make.width.height.equalTo(20)
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
