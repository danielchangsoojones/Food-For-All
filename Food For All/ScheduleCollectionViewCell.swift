//
//  ScheduleCollectionViewCell.swift
//  Food For All
//
//  Created by Daniel Jones on 2/27/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class ScheduleCollectionViewCell: UICollectionViewCell {
    var label: UILabel = UILabel()
    
    override var reuseIdentifier: String? {
        return ScheduleCollectionViewCell.identifier
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = 5.0
        self.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
}

extension ScheduleCollectionViewCell {
    static let identifier: String = "scheduleCollectionCell"
}
