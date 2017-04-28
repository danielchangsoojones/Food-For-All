//
//  FreelancerMessageTableViewCell.swift
//  Food For All
//
//  Created by Daniel Jones on 4/27/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class FreelancerMessageTableViewCell: MessageTableViewCell {
    override var reuseIdentifier: String? {
        return FreelancerMessageTableViewCell.identifier
    }
    
    override func setContents(contract: Contract) {
        super.setContents(contract: contract)
        theCircleImageView.add(file: contract.gig.creator.profileImage)
        theNameLabel.text = contract.gig.creator.fullName
    }
}

extension FreelancerMessageTableViewCell {
    static let identifier = "freelancerMessageCell"
}
