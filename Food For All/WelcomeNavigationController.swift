//
//  WelcomeNavigationController.swift
//  Food For All
//
//  Created by Daniel Jones on 1/13/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class WelcomeNavigationController: CustomNavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        makeTransparent()
        self.navigationBar.barStyle = UIBarStyle.black //white view controller title
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func resetToDefaults() {
        navigationBar.tintColor = Constants.navBarTintColor
    }
}
