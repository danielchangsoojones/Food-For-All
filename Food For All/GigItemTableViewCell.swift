//
//  GigItemTableViewCell.swift
//  Food For All
//
//  Created by Daniel Jones on 2/16/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class GigItemTableViewCell: UITableViewCell {
    var theElementView: UIView!
    var theAccessoryView: UIView!
    
    init() {
        super.init(style: .default, reuseIdentifier: "gigItemCell")
        elementViewSetup()
        accessoryViewSetup()
        bottomLineSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func elementViewSetup() {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightLight)
        theElementView = label
        elementViewPosition()
    }
    
    func elementViewPosition() {
        self.addSubview(theElementView)
        theElementView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(DetailView.Constants.sideInset)
        }
    }
    
    func set(title: String) {
        if let label = theElementView as? UILabel {
            label.text = title
        }
    }
    
    func accessoryViewSetup() {
        let coloredImage = #imageLiteral(resourceName: "ArrowHead").withRenderingMode(.alwaysTemplate)
        theAccessoryView = UIImageView(image: coloredImage)
        theAccessoryView.contentMode = .scaleAspectFit
        theAccessoryView.tintColor = CustomColors.BombayGray
        self.addSubview(theAccessoryView)
        theAccessoryView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(DetailView.Constants.sideInset)
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
