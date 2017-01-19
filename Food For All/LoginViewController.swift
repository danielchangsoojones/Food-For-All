//
//  LoginViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 1/18/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import BRYXBanner

class LoginViewController: AdmissionFormViewController {
    var dataStore: LogInDataStore!
    
    
    override var welcomeFormView: WelcomeFormView {
        return WelcomeFormView(frame: self.view.bounds, title: "Log In", topTextFieldTitle: "Email", bottomTextFieldTitle: "Password")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        dataStore = LogInDataStore(delegate: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func forwardButtonPressed(sender: UIButton?) {
        if validateEmail() && validatePassword() {
            super.forwardButtonPressed()
            dataStore.logIn(email: theTopTextField?.text ?? "", password: theBottomTextField?.text ?? "")
        }
    }
}
