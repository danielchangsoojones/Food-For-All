//
//  SearchNavigationBar.swift
//  Food For All
//
//  Created by Daniel Jones on 4/8/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class SearchNavigationBar: UINavigationBar {
    //allows us to set a customized height for the navigation controller
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let newSize : CGSize = CGSize(width: self.frame.size.width, height: self.frame.height)
        return newSize
    }
    
    static let enlargedHeight: CGFloat = 80
}
