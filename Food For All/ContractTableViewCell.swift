//
//  ContractTableViewCell.swift
//  Food For All
//
//  Created by Daniel Jones on 3/12/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class ContractTableViewCell: UITableViewCell {
    struct Constants {
        static let verticalSpacing: CGFloat = 10
    }
    
    override var reuseIdentifier: String? {
        return ContractTableViewCell.identifier
    }
    
    var theContentView: UIView!
    var theTitleLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.clear
        contentViewSetup()
        titleLabelSetup()
        descriptionLabelSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func contentViewSetup() {
        theContentView = UIView()
        theContentView.addBorder(width: 1.5, color: CustomColors.BombayGray)
        theContentView.backgroundColor = UIColor.white
        theContentView.setCornerRadius(radius: 15)
        self.addSubview(theContentView)
        theContentView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview().inset(10.0)
            make.trailing.leading.equalToSuperview().inset(10.0)
        }
    }
    
    fileprivate func titleLabelSetup() {
        theTitleLabel = UILabel()
        theTitleLabel.textColor = CustomColors.JellyTeal
        theTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightBold)
        theContentView.addSubview(theTitleLabel)
        theTitleLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().inset(15)
            make.top.equalToSuperview().inset(Constants.verticalSpacing)
        }
    }
    
    fileprivate func descriptionLabelSetup() {
        let label = UILabel()
        label.textColor = CustomColors.SilverChalice
        theContentView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.leading.equalTo(theTitleLabel)
            make.top.equalTo(theTitleLabel.snp.bottom).offset(Constants.verticalSpacing)
        }
    }
}

extension ContractTableViewCell {
    static let identifier = "contractTableCell"
}
