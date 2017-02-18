//
//  InformationTableViewCell.swift
//  Food For All
//
//  Created by Daniel Jones on 2/16/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class InformationTableViewCell: UITableViewCell {
    var theTitleLabel: UILabel!
    var theDescriptionLabel: UILabel!
    
    init(title: String, description: String) {
        super.init(style: .default, reuseIdentifier: "informationCell")
        setup(title: title)
        setup(description: description)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setup(title: String) {
        theTitleLabel = UILabel()
        theTitleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        theTitleLabel.text = title
        self.addSubview(theTitleLabel)
        theTitleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(DetailView.Constants.spacing)
            make.leading.equalToSuperview().inset(DetailView.Constants.sideInset)
        }
    }
    
    fileprivate func setup(description: String) {
        theDescriptionLabel = UILabel()
        theDescriptionLabel.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightLight)
        theDescriptionLabel.text = description
        theDescriptionLabel.numberOfLines = 0
        self.addSubview(theDescriptionLabel)
        theDescriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(theTitleLabel.snp.bottom).offset(DetailView.Constants.spacing)
            make.leading.equalTo(theTitleLabel)
            make.trailing.equalToSuperview().inset(DetailView.Constants.sideInset)
            make.bottom.equalToSuperview()
        }
    }

}
