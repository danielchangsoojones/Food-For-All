//
//  MainSearchIngView.swift
//  Food For All
//
//  Created by Daniel Jones on 1/28/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class MainSearchingView: UIView {
    var beginningTopInset: CGFloat = 0
    var theSearchAreaView: UIView = UIView()
    var theSearchBar: CustomSearchBar = CustomSearchBar()
    var theTableView: UITableView = UITableView()
    
    var lineColor: UIColor {
        return UIColor.white.withAlphaComponent(0.5)
    }
    
    init(frame: CGRect, navBarHeight: CGFloat) {
        super.init(frame: frame)
        self.beginningTopInset = navBarHeight
        addGradient()
        searchAreaViewSetup()
        tableViewSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addGradient() {
        let gradient:CAGradientLayer = CAGradientLayer()
        gradient.frame.size = self.frame.size
        gradient.colors = [CustomColors.AquamarineBlue.cgColor, CustomColors.GrannySmithGreen.cgColor]
        gradient.startPoint = CGPoint(x: 0.4, y: 0.4)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        self.layer.insertSublayer(gradient, at: 0)
    }
}

//search area extension
extension MainSearchingView {
    fileprivate func searchAreaViewSetup() {
        self.addSubview(theSearchAreaView)
        theSearchAreaView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(beginningTopInset)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        searchBarSetup()
        lineSetup()
    }
    
    fileprivate func searchBarSetup() {
        theSearchAreaView.addSubview(theSearchBar)
        theSearchBar.snp.makeConstraints { (make) in
            let verticalInset: CGFloat = 5.0
            let horizontalInset: CGFloat = MainSearchingViewConstants.leadingInset
            make.top.bottom.equalToSuperview().inset(verticalInset)
            make.leading.trailing.equalToSuperview().inset(horizontalInset)
        }
    }
    
    fileprivate func lineSetup() {
        let line = Helpers.line
        line.backgroundColor = lineColor
        theSearchAreaView.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}

//tableview extension
extension MainSearchingView {
    fileprivate func tableViewSetup() {
        theTableView.separatorInset = UIEdgeInsets(top: 0, left: MainSearchingViewConstants.leadingInset, bottom: 0, right: MainSearchingViewConstants.leadingInset)
        theTableView.separatorColor = lineColor
        theTableView.tableFooterView = UIView() //makes it so, the tableView will only show real cells, not empty ones
        self.addSubview(theTableView)
        theTableView.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(theSearchAreaView)
            make.top.equalTo(theSearchAreaView.snp.bottom)
            make.bottom.equalToSuperview()
        }
        theTableView.backgroundColor = UIColor.clear
    }
}
