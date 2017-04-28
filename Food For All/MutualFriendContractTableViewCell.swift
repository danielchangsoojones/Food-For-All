//
//  MutualFriendContractTableViewCell.swift
//  Food For All
//
//  Created by Daniel Jones on 4/26/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class MutualFriendContractTableViewCell: MutualFriendTableViewCell {
    var theContentView: UIView!
    
    override init(numOfFriends: Int) {
        super.init(numOfFriends: numOfFriends)
        stylizeCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //TODO: this is not the perfect way to stylize a cell, and I am making the mutual friend cell in multiple places, which is bad code. But, better to just have it built and we can refactor later
    fileprivate func stylizeCell() {
        self.addBorder(width: 1.5, color: CustomColors.BombayGray)
        self.backgroundColor = UIColor.white
        self.setCornerRadius(radius: 15)
    }
}
