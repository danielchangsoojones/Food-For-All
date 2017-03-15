//
//  VenmoContractTableViewCell.swift
//  Food For All
//
//  Created by Daniel Jones on 3/13/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class VenmoContractTableViewCell: CreationTableViewCell {
    init() {
        super.init(iconImage: #imageLiteral(resourceName: "VenmoIcon"), titleText: "")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func titleSetup(text: String) {
        let venmoImageView = UIImageView(image: #imageLiteral(resourceName: "venmo_logo_blue"))
        venmoImageView.contentMode = .scaleAspectFit
        self.addSubview(venmoImageView)
        venmoImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalTo(theLine.snp.trailing).offset(horizontalSpacing)
        }
    }
}
