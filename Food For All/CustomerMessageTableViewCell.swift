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
    
    func setContents(message: Message) {
        if let message = message as? CustomerMessage {
            theCircleImageView.add(file: message.customer.profileImage)
            theNameLabel.text = message.customer.fullName
            theTimeStamp.text = formatTimeStamp(message.sentDate)
        }
    }
}

extension CustomerMessageTableViewCell {
    static let identifier = "customerMessageCell"
}
