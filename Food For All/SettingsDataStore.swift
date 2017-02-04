//
//  SettingsDataStore.swift
//  Food For All
//
//  Created by Daniel Jones on 2/4/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse

class SettingsDataStore {
    func logOut() {
        User.logOutInBackground()
    }
}

