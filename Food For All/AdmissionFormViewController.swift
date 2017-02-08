//
//  AdmissionFormViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 1/18/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

//A superclass for the log-in/sign-up viewControllers
class AdmissionFormViewController: WelcomeFormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        theBottomTextField?.isSecureTextEntry = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//extension for commonality between login/signup
extension WelcomeFormViewController: AdmissionFormDataStoreDelegate {
    func displayError(title: String, subtitle: String) {
        Helpers.showBanner(title: title, subtitle: subtitle)
    }
    
    func stopSpinner() {
        theSpinner.stopAnimating()
        theForwardButton.isSelected = false
        theForwardButton.isUserInteractionEnabled = true
    }
    
    func segueIntoApplication() {
        Helpers.enterApplication(from: self)
    }
    
    func validateEmail() -> Bool {
        if let email = theTopTextField?.text {
            if !email.isEmail {
                Helpers.showBanner(title: "Invalid Email", subtitle: "You must input a proper email")
                return false
            }
        }
        return true
    }
    
    func validatePassword() -> Bool {
        if let password = theBottomTextField?.text {
            if password.isBlank {
                Helpers.showBanner(title: "Invalid Password", subtitle: "You must input a password")
                return false
            }
        }
        return true
    }
}
