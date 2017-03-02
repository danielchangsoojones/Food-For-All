//
//  EventCollectionViewCell.swift
//  Food For All
//
//  Created by Daniel Jones on 3/1/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class EventCollectionViewCell: UICollectionViewCell {
    override var reuseIdentifier: String? {
        return EventCollectionViewCell.identifier
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.red
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EventCollectionViewCell {
    static let identifier: String = "eventCollectionCell"
}
