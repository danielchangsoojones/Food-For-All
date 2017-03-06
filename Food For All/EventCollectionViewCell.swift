//
//  EventCollectionViewCell.swift
//  Food For All
//
//  Created by Daniel Jones on 3/1/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class EventCollectionViewCell: UICollectionViewCell {
    struct Constants {
        static let borderWidth: CGFloat = 2.0
        static let borderColor: UIColor = CustomColors.JellyTeal
    }
    
    override var reuseIdentifier: String? {
        return EventCollectionViewCell.identifier
    }
    
    var theLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(r: 49, g: 62, b: 70)
        setCornerRadius(radius: 5)
        labelSetup()
        addBorderLeft(size: Constants.borderWidth, color: Constants.borderColor)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        addBorderLeft(size: Constants.borderWidth, color: Constants.borderColor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(title: String) {
        theLabel.text = title
    }
    
    fileprivate func labelSetup() {
        theLabel = UILabel()
        theLabel.textColor = UIColor.white
        theLabel.font = UIFont.systemFont(ofSize: 12, weight: DateCollectionViewCell.Constants.fontWeight)
        self.addSubview(theLabel)
        theLabel.snp.makeConstraints { (make) in
            let inset = 10
            make.leading.equalToSuperview().inset(inset)
            make.top.equalToSuperview().inset(inset)
        }
    }
}

extension EventCollectionViewCell {
    static let identifier: String = "eventCollectionCell"
}
