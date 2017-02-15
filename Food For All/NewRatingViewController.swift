//
//  NewRatingViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 2/14/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class NewRatingViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
    }
    
    fileprivate func viewSetup() {
        let newRatingView = NewRatingView(frame: self.view.bounds)
        self.view = newRatingView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
