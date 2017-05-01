//
//  EmptyGigsCollectionViewCell.swift
//  Food For All
//
//  Created by Daniel Jones on 4/15/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class EmptyGigsCollectionViewCell: GlidingCollectionViewCell {
    override var reuseIdentifier: String? {
        return EmptyGigsCollectionViewCell.identifier
    }
    
    var theTitleLabel: UILabel!
    var theDescriptionLabel: UILabel!
    var theCreateButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabelSetup()
        createButtonSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EmptyGigsCollectionViewCell {
    var verticalInset: CGFloat {
        return self.frame.height * 0.1
    }
    
    fileprivate func titleLabelSetup() {
        theTitleLabel = UILabel()
        theTitleLabel.textAlignment = .center
        theTitleLabel.font = UIFont.systemFont(ofSize: 25, weight: UIFontWeightBold)
        theTitleLabel.numberOfLines = 2
        theTitleLabel.text = "No Services\nNearby"
        //adding to content view because we don't want to add to self, or else if we use clip to bounds, then the shadow breaks
        contentView.addSubview(theTitleLabel)
        theTitleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(verticalInset)
        }
    }
    
    fileprivate func createButtonSetup() {
        theCreateButton = Helpers.stylizeButton(text: "Create")
        ///not having user interaction because if they click a cell, then we just want them to go to creation page, may change in the future
        theCreateButton.isUserInteractionEnabled = false
        contentView.addSubview(theCreateButton)
        theCreateButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(verticalInset)
        }
        descriptionLabelSetup()
    }
    
    fileprivate func descriptionLabelSetup() {
        theDescriptionLabel = UILabel()
        theDescriptionLabel.textAlignment = .center
        theDescriptionLabel.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightLight)
        theDescriptionLabel.text = "Create Your Own:"
        contentView.addSubview(theDescriptionLabel)
        theDescriptionLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(theCreateButton.snp.top).offset(-10)
        }
    }
}

extension EmptyGigsCollectionViewCell {
    static let identifier = "emptyGigsCollectionCell"
}
