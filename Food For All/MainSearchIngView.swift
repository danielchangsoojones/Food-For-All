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
    
    init(frame: CGRect, navBarHeight: CGFloat) {
        super.init(frame: frame)
        self.beginningTopInset = navBarHeight
        self.backgroundColor = UIColor.red
        searchAreaViewSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//search area extension
extension MainSearchingView {
    fileprivate func searchAreaViewSetup() {
        let theSearchAreaView = UIView()
        theSearchAreaView.backgroundColor = UIColor.blue
        self.addSubview(theSearchAreaView)
        theSearchAreaView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(beginningTopInset)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        let searchBar = CustomSearchBar()
        theSearchAreaView.addSubview(searchBar)
        searchBar.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
