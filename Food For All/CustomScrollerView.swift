//
//  CustomScrollerView.swift
//  Food For All
//
//  Created by Daniel Jones on 1/25/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class CustomScrollerView: UIView {
    var theScrollView: UIScrollView = UIScrollView()
    var theContentView: UIView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        scrollViewSetup()
        theContentView.backgroundColor = UIColor.blue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func scrollViewSetup() {
        contentViewSetup()
        self.addSubview(theScrollView)
        theScrollView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalTo(self)
            make.top.equalTo(self)
        }
    }
    
    fileprivate func contentViewSetup() {
        theScrollView.addSubview(theContentView)
        theContentView.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalTo(theScrollView)
            make.width.equalTo(self.frame.width)
        }
    }
}
