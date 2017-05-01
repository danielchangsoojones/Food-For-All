//
//  DiscoverSectionFooterTableViewCell.swift
//  Food For All
//
//  Created by Daniel Jones on 5/1/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class DiscoverSectionFooterTableViewCell: UITableViewCell {
    override var reuseIdentifier: String? {
        return DiscoverSectionFooterTableViewCell.identifier
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DiscoverSectionFooterTableViewCell {
    static let identifier = "discoverSectionFooterTableCell"
}
