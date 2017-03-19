//
//  SignUpDataStore.swift
//  Food For All
//
//  Created by Daniel Jones on 1/18/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse
import Mixpanel

class SignUpDataStore {
    var delegate: AdmissionFormDataStoreDelegate?
    
    init(delegate: AdmissionFormDataStoreDelegate) {
        self.delegate = delegate
    }
    
    func signUp(email: String, password: String) {
        let newUser = User()
        newUser.username = email
        newUser.password = password
        newUser.email = email
        
        newUser.signUpInBackground { (success, error: Error?) -> Void in
            self.delegate?.stopSpinner()
            if success {
                let installation = PFInstallation.current()
                installation!["user"] = User.current()
                installation!.saveInBackground()
                self.delegate?.segueIntoApplication()
            }
            else {
                if let error = error, let code = PFErrorCode(rawValue: error._code) {
                    switch code {
                    case .errorInvalidEmailAddress:
                        self.delegate?.displayError(title: "Invalid Email Address", subtitle: "Please enter a valid email address")
                    case .errorUserEmailTaken:
                        self.delegate?.displayError(title: "Email Already Taken", subtitle: "Email already exists, please use a different one or log in.")
                    default:
                        self.delegate?.displayError(title: "Sign Up Error", subtitle: error.localizedDescription)
                    }
                }
            }
        }
    }
}
