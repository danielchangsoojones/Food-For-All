//
//  CustomerMessageTableViewCell.swift
//  Food For All
//
//  Created by Daniel Jones on 4/22/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class CustomerMessageTableViewCell: UITableViewCell {
    override var reuseIdentifier: String? {
        return CustomerMessageTableViewCell.identifier
    }
}

extension CustomerMessageTableViewCell {
    static let identifier = "customerMessageCell"
}
