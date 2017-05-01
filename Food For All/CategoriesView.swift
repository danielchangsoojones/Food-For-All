//
//  CategoriesView.swift
//  Food For All
//
//  Created by Daniel Jones on 5/1/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class CategoriesView: UIView {
    var theTableView: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        tableViewSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func tableViewSetup() {
        theTableView = UITableView(frame: self.bounds, style: .grouped)
        theTableView.separatorStyle = .none
        theTableView.backgroundColor = UIColor.white
        self.addSubview(theTableView)
    }
}
