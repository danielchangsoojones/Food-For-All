//
//  SignUpViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 1/18/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class SignUpViewController: AdmissionFormViewController {
    var dataStore: SignUpDataStore!
    
    override var welcomeFormView: WelcomeFormView {
        return WelcomeFormView(frame: self.view.bounds, title: "Sign Up", topTextFieldTitle: "Email", bottomTextFieldTitle: "Password")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        dataStore = SignUpDataStore(delegate: self)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func forwardButtonPressed(sender: UIButton?) {
        if validateEmail() && validatePassword() {
            super.forwardButtonPressed()
            dataStore.signUp(email: theTopTextField?.text ?? "", password: theBottomTextField?.text ?? "")
        }
    }
    
    override func segueIntoApplication() {
        let nameVC = NameViewController()
        pushVC(nameVC)
    }
}
