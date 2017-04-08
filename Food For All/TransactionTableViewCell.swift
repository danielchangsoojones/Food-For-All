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
    var theContentView: TransactionContentView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        headingSetup()
        contentSetup()
    }
    
    func setContents(review: Review) {
        theHeadView.setContents(review: review)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TransactionTableViewCell {
    fileprivate func headingSetup() {
        theHeadView = TransactionHeadView(width: self.frame.width)
        self.addSubview(theHeadView)
        theHeadView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.height.equalTo(TransactionHeadView.Constants.height)
            make.leading.trailing.equalToSuperview().inset(15)
        }
    }
    
    fileprivate func contentSetup() {
        theContentView = TransactionContentView()
        self.addSubview(theContentView)
        theContentView.snp.makeConstraints { (make) in
            make.top.equalTo(theHeadView.snp.bottom).offset(5)
            //For some reason, aligning it with the headView doesn't work
            make.leading.trailing.equalTo(theHeadView)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
}

extension TransactionTableViewCell {
    static let reuseIdentifier: String = "transactionTableCell"
}
