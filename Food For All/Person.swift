//
//  Person.swift
//  Food For All
//
//  Created by Daniel Jones on 1/22/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse

class Person {
    var firstName: String?
    var lastName: String?
    var birthDate: Date?
    var venmoUsername: String?
    var profileImage: PFFile?
    
    var user: User = User()
    
    init(user: User) {
        self.user = user
        self.firstName = user.theFirstName
        self.lastName = user.theLastName
        self.birthDate = user.birthDate
        self.profileImage = user.profileImage
        self.venmoUsername = user.venmoUsername
    }
    
    static func current() -> Person {
        return Person(user: User.current() ?? User())
    }
    
    var fullName: String? {
        if let firstName = firstName, let lastName = lastName {
            return firstName + " " + lastName
        }
        return nil
    }
}
