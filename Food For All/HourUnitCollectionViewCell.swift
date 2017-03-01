//
//  HourUnitCollectionView.swift
//  Food For All
//
//  Created by Daniel Jones on 2/28/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class HourUnitCollectionViewCell: UICollectionViewCell {
    var theTimeLabel: UILabel!
    
    override var reuseIdentifier: String? {
        return HourUnitCollectionViewCell.identifier
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        labelSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func labelSetup() {
        theTimeLabel = UILabel()
        theTimeLabel.textColor = CustomColors.SilverChalice
        self.addSubview(theTimeLabel)
        theTimeLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(self.snp.bottom)
        }
    }
    
    func setTime(title: String?) {
        theTimeLabel.text = title
    }
}

extension HourUnitCollectionViewCell {
    static let identifier: String = "hourUnitCollectionCell"
}
