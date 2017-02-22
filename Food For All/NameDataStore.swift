//
//  NameDataStore.swift
//  Food For All
//
//  Created by Daniel Jones on 2/21/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse

class NameDataStore {
    func save(firstName: String, lastName: String) {
        if let currentUser = User.current() {
            currentUser.theFirstName = firstName
            currentUser.theLastName = lastName
            sendMessageToGroupMe(firstName: firstName, lastName: lastName)
            currentUser.saveInBackground()
        }
    }
    
    fileprivate func sendMessageToGroupMe(firstName: String, lastName: String) {
        let dataStore = WelcomeDataStore()
        dataStore.sendNewUserIntoGroupMe()
    }
}
