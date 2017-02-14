//
//  AllReviewsView.swift
//  Food For All
//
//  Created by Daniel Jones on 2/11/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class AllReviewsView: UIView {
    var theTableView: UITableView!
    var theTableHeaderView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        tableViewSetup()
        tableViewHeaderSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//table view setup
extension AllReviewsView {
    fileprivate func tableViewSetup() {
        theTableView = UITableView()
        self.addSubview(theTableView)
        theTableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    fileprivate func tableViewHeaderSetup() {
        theTableHeaderView = UIView(frame: CGRect(x: 0, y: 0, w: 0, h: 75))
        addLabelToHeader()
    }
    
    fileprivate func addLabelToHeader() {
        let label = UILabel()
        label.text = "Reviews"
        label.font = UIFont.systemFont(ofSize: 30, weight: UIFontWeightBold)
        theTableHeaderView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(ReviewTableViewCell.Constants.headerInset)
        }
    }
}
