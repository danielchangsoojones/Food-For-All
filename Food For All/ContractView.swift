//
//  ContractView.swift
//  Food For All
//
//  Created by Daniel Jones on 3/12/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class ContractView: UIView {
    var theTableView: UITableView!
    var thePhotoView: UIView!
    var theProfileCircleView: CircularImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        gradientSetup()
        tableViewSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func gradientSetup() {
        let start: CGPoint = CGPoint(x: 0.3, y: 0.3)
        let end: CGPoint = CGPoint(x: 1.0, y: 1.0)
        CustomColors.addGradient(colors: CustomColors.creationGradientColors, to: self, startPoint: start, endPoint: end)
    }
}

//tableview extension
extension ContractView {
    fileprivate func tableViewSetup() {
        theTableView = UITableView(frame: self.bounds)
        theTableView.separatorStyle = .none
        theTableView.backgroundColor = UIColor.clear
        theTableView.showsVerticalScrollIndicator = false
        self.addSubview(theTableView)
        headerViewSetup()
    }
    
    fileprivate func headerViewSetup() {
        thePhotoView = UIView(frame: CGRect(x: 0, y: 0, w: self.frame.width, h: 200))
        circularImageViewSetup(diameter: thePhotoView.frame.height)
        theTableView.tableHeaderView = thePhotoView
    }
    
    fileprivate func circularImageViewSetup(diameter: CGFloat) {
        theProfileCircleView = CircularImageView(file: nil, diameter: diameter * 0.75)
        thePhotoView.addSubview(theProfileCircleView)
        theProfileCircleView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
}


