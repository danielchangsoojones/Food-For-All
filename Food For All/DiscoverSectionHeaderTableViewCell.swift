//
//  DiscoverSectionHeaderTableViewCell.swift
//  Food For All
//
//  Created by Daniel Jones on 5/1/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class DiscoverSectionHeaderTableViewCell: UITableViewCell {
    struct Constants {
        static let horizontalInset: CGFloat = 10
    }
    
    var theTitleLabel: UILabel!
    var theAllButton: UIButton!
    
    override var reuseIdentifier: String? {
        return DiscoverSectionHeaderTableViewCell.identifier
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        titleLabelSetup()
        allButtonSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setContent(title: String, categoryCount: Int) {
        theTitleLabel.text = title
        theAllButton.setTitle("All \(categoryCount)>", for: .normal)
    }
}

extension DiscoverSectionHeaderTableViewCell {
    fileprivate func titleLabelSetup() {
        theTitleLabel = UILabel()
        theTitleLabel.font = UIFont.systemFont(ofSize: 21, weight: UIFontWeightBold)
        contentView.addSubview(theTitleLabel)
        theTitleLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().inset(Constants.horizontalInset)
            make.centerY.equalToSuperview()
        }
    }
    
    fileprivate func allButtonSetup() {
        theAllButton = UIButton()
        theAllButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: UIFontWeightBold)
        theAllButton.setTitleColor(UIColor.black, for: .normal)
        contentView.addSubview(theAllButton)
        theAllButton.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().inset(Constants.horizontalInset)
            make.centerY.equalToSuperview()
        }
    }
}

extension DiscoverSectionHeaderTableViewCell {
    static let identifier = "discoverSectionHeaderTableCell"
}
