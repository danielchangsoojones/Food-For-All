//
//  SettingsDataStore.swift
//  Food For All
//
//  Created by Daniel Jones on 2/4/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse
import SCLAlertView

class SettingsDataStore {
    func logOut() {
        User.logOutInBackground()
    }
    
    func seeUserMetrics() {
        let allowedUserObjectIds: [String] = ["c5xsQgNgBC", "evQC6ALBk3", "dAEbxYVLs8", "ZpF0Ufet5T"]
        if allowedUserObjectIds.contains(User.current()?.objectId ?? "") {
            let query = User.query() as! PFQuery<User>
            query.order(byDescending: "createdAt")
            query.countObjectsInBackground { (count, error) in
                query.getFirstObjectInBackground(block: { (newUser, error) in
                    if let newUser = newUser {
                        let fullName = newUser.fullName ?? ""
                        _ = SCLAlertView().showInfo("\(count) Total Users", subTitle: fullName + " is the most recent")
                    }
                })
            }
        }
    }
}

