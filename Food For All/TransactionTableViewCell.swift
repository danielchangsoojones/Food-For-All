//
//  TransactionTableViewCell.swift
//  Food For All
//
//  Created by Daniel Jones on 4/8/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
    override var reuseIdentifier: String? {
        return TransactionTableViewCell.reuseIdentifier
    }
    
    var theHeadView: TransactionHeadView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        headingSetup()
    }
    
    func setContents(review: Review) {
        theHeadView.setContents(review: review)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TransactionTableViewCell {
    func headingSetup() {
        theHeadView = TransactionHeadView(width: self.frame.width)
        self.addSubview(theHeadView)
    }
}

extension TransactionTableViewCell {
    static let reuseIdentifier: String = "transactionTableCell"
}
