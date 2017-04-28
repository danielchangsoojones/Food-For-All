//
//  MessageIndexView.swift
//  Food For All
//
//  Created by Daniel Jones on 4/22/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class MessageIndexView: UIView {
    var theTableView: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        tableViewSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func tableViewSetup() {
        theTableView = UITableView(frame: self.bounds)
        theTableView.separatorColor = CustomColors.SilverChalice
        theTableView.tableFooterView = UIView() //removes any extra empty tableview cells
        self.addSubview(theTableView)
    }
}