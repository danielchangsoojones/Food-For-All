//
//  DataInput.swift
//  Food For All
//
//  Created by Daniel Jones on 1/31/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse

class DataInput {
    func signUpUser() {
        let firstName = "Robert"
        let lastName = "Brown"
        let email = "robhbrow@indiana.edu"
        
        let newUser = User()
        newUser.theFirstName = firstName
        newUser.theLastName = lastName
        newUser.email = email
        newUser.username = email
        newUser.password = "password"
        newUser.signUpInBackground { (success, error) in
            if success {
                self.createGig(user: newUser)
            } else if let error = error {
                print(error)
            }
        }
    }
    
    func findUser() {
        let email = "mikefrancismc@aol.com"
        
        let query = User.query() as! PFQuery<User>
        query.whereKey("email", equalTo: email)
        query.getFirstObjectInBackground { (user, error) in
            if let user = user {
                self.createGig(user: user)
            } else if let error = error {
                print(error)
            }
        }
    }
    
    
    fileprivate func createGig(user: User) {
        let title = "M118/M119 Tutoring"
        let price: Double = 25
        let detailDescription = "I have two years of experience tutoring for Indiana University in the athletic department where I met with students weekly or multiple times per week to prepare for exams and work through assignments. I am available in all of the following subjects: M118, M119, A100."
        let phoneNumber: Int = 3176453197
        let tag = "tutoring"
        
        let gig = GigParse()
        gig.title = title
        gig.price = price
        gig.detailDescription = detailDescription
        gig.phoneNumber = phoneNumber
        gig.creator = user
        gig.addUniqueObject(tag.lowercased(), forKey: "tags")
        gig.saveInBackground()
    }
}
