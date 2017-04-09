//
//  SearchNavigationBar.swift
//  Food For All
//
//  Created by Daniel Jones on 4/8/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class SearchNavigationBar: UINavigationBar {
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let newSize : CGSize = CGSize(width: self.frame.size.width, height: 80)
        return newSize
    }

}
