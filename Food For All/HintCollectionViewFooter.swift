//
//  HintCollectionViewFooter.swift
//  Food For All
//
//  Created by Daniel Jones on 2/18/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class HintCollectionViewFooter: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        labelSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func labelSetup() {
        let label = UILabel()
        label.text = "Hint: hold & drag photos to change order"
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.textAlignment = .center
        self.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.75)
        }
    }
}

extension HintCollectionViewFooter {
    static var identifier: String {
        return "hintFooter"
    }
}
