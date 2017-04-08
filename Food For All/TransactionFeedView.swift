//
//  TransactionFeedView.swift
//  Food For All
//
//  Created by Daniel Jones on 4/8/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class TransactionFeedView: UIView {
    var theTableView: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        tableViewSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func tableViewSetup() {
        theTableView = UITableView(frame: self.frame)
        self.addSubview(theTableView)
    }
}
