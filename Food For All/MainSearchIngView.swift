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
    
    init(frame: CGRect, navBarHeight: CGFloat) {
        super.init(frame: frame)
        self.beginningTopInset = navBarHeight
        addGradient()
        searchAreaViewSetup()
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
        theSearchAreaView.backgroundColor = UIColor.blue
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
            let inset: CGFloat = 5.0
            make.top.bottom.equalToSuperview().inset(inset)
            make.leading.trailing.equalToSuperview().inset(inset)
        }
    }
    
    fileprivate func lineSetup() {
        let line = Helpers.line
        line.backgroundColor = UIColor.white
        theSearchAreaView.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}
