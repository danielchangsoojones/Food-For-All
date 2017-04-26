//
//  CustomerMessageTableViewCell.swift
//  Food For All
//
//  Created by Daniel Jones on 4/22/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class CustomerMessageTableViewCell: MessageTableViewCell {
    override var reuseIdentifier: String? {
        return CustomerMessageTableViewCell.identifier
    }
    
    func setContents(contract: Contract) {
        theCircleImageView.add(file: contract.customer.profileImage)
        theNameLabel.text = contract.customer.fullName
        theTimeStamp.text = formatTimeStamp(contract.sentDate)
    }
}

extension CustomerMessageTableViewCell {
    static let identifier = "customerMessageCell"
}
