//
//  WelcomeFormViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 1/12/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class WelcomeFormViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func viewSetup() {
        let welcomeFormView = WelcomeFormView(frame: self.view.bounds, title: "Log In", topTextFieldTitle: "hi", bottomTextFieldTitle: "boo")
        self.view = welcomeFormView
    }
}
