//
//  DataInput.swift
//  Food For All
//
//  Created by Daniel Jones on 1/31/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation

class DataInput {
    func signUpUser() {
        let firstName = "Jessie"
        let lastName = "DiGiovanni"
        let email = "jdigiova@indiana.edu"
        
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
    
    fileprivate func createGig(user: User) {
        let title = "Finite M-118 Tutoring"
        let price: Double = 20
        let detailDescription = "I've tutored a couple people who've reached out to me before for pay. Received 4.0 in Finite. Price is negotiable."
        let phoneNumber: Int = 5862588651
        
        let gig = GigParse()
        gig.title = title
        gig.price = price
        gig.detailDescription = detailDescription
        gig.phoneNumber = phoneNumber
        gig.creator = user
        gig.saveInBackground()
    }
}
