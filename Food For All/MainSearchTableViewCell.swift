//
//  MainSearchTableViewCell.swift
//  Food For All
//
//  Created by Daniel Jones on 1/28/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class MainSearchTableViewCell: UITableViewCell {
    var theTitleLabel: UILabel = UILabel()
    
    init(title: String) {
        super.init(style: .default, reuseIdentifier: "mainSearchCell")
        titleSetup(text: title)
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func titleSetup(text: String) {
        theTitleLabel.text = text
        theTitleLabel.textColor = UIColor.white
        theTitleLabel.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightBold)
        self.addSubview(theTitleLabel)
        theTitleLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().inset(MainSearchingViewConstants.leadingInset)
            make.centerY.equalToSuperview()
        }
    }
}
