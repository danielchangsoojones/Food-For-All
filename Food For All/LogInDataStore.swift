//
//  LogInDataStore.swift
//  Food For All
//
//  Created by Daniel Jones on 1/18/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse

protocol AdmissionFormDataStoreDelegate {
    func segueIntoApplication()
    func displayError(title: String, subtitle: String)
    func stopSpinner()
}

class LogInDataStore {
    var delegate: AdmissionFormDataStoreDelegate?
    
    init(delegate: AdmissionFormDataStoreDelegate) {
        self.delegate = delegate
    }
    
    func logIn(email: String, password: String) {
        let lowerCaseEmail = email.lowercased()
        let lowerCasePassword = password.lowercased()
        
        User.logInWithUsername(inBackground: lowerCaseEmail, password: lowerCasePassword) { (user, error) -> Void in
            self.delegate?.stopSpinner()
            
            if let _ = user, error == nil {
                //not totally sure what this installation stuff is doing at the moment, normally, I know we use installations for push notifications.
                let installation = PFInstallation.current()
                installation!["user"] = User.current()
                installation!.saveEventually(nil)
                self.delegate?.segueIntoApplication()
            } else if let error = error, let code = PFErrorCode(rawValue: error._code) {
                if code == .errorObjectNotFound {
                    self.delegate?.displayError(title: "No User Found", subtitle: "No user exists for that email.")
                } else {
                    self.delegate?.displayError(title: "Login Failed", subtitle: error.localizedDescription)
                }
            }
        }
    }
}
