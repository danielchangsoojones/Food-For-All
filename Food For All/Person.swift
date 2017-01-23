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
    var profileImage: PFFile?
    
    var user: User = User()
}
