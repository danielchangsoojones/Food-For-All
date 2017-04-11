//
//  MainSearchView.swift
//  Food For All
//
//  Created by Daniel Jones on 1/28/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import SnapKit

class MainSearchView: UIView {
    var theIconImageView: UIImageView!
    var theSearchLabel: UILabel = UILabel()
    
    fileprivate var sideInset: CGFloat {
        return self.frame.width * 0.02
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white.withAlphaComponent(0.26)
        iconSetup()
        searchLabelSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func iconSetup() {
        theIconImageView = UIImageView(image: #imageLiteral(resourceName: "Magnifying Glass"))
        theIconImageView.contentMode = .scaleAspectFit
        self.addSubview(theIconImageView)
        theIconImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(sideInset)
            make.height.equalTo(self).multipliedBy(0.5)
        }
    }
}

//search label extension
extension MainSearchView {
    fileprivate func searchLabelSetup() {
        theSearchLabel.text = "Search"
        theSearchLabel.textColor = UIColor.white
        allowSearchLabelStretching()
        theSearchLabel.font = UIFont.systemFont(ofSize: 17, weight: UIFontWeightRegular)
        self.addSubview(theSearchLabel)
        theSearchLabel.snp.makeConstraints { (make) in
            make.top.equalTo(theIconImageView)
            make.bottom.equalTo(theIconImageView)
            make.leading.equalTo(theIconImageView.snp.trailing).offset(self.frame.width * 0.03)
            make.trailing.equalToSuperview().inset(sideInset)
        }
    }
    
    fileprivate func allowSearchLabelStretching() {
        theSearchLabel.setContentHuggingPriority(250, for: .horizontal)
        theIconImageView.setContentHuggingPriority(1000, for: .horizontal)
    }
}
