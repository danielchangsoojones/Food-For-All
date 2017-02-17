//
//  VenmoTableViewCell.swift
//  Food For All
//
//  Created by Daniel Jones on 2/16/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class VenmoTableViewCell: GigItemTableViewCell {
    override func elementViewSetup() {
        theElementView = UIImageView(image: #imageLiteral(resourceName: "venmo_logo_blue"))
        theElementView.contentMode = .scaleAspectFit
        elementViewPosition()
    }
}
