//
//  WelcomeDataStore.swift
//  Food For All
//
//  Created by Daniel Jones on 1/18/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import ParseFacebookUtilsV4
import Alamofire

protocol WelcomeDataStoreDelegate {
    func segueIntoApplication()
}

class WelcomeDataStore {
    var delegate: WelcomeDataStoreDelegate?
    
    init(delegate: WelcomeDataStoreDelegate) {
        self.delegate = delegate
    }
}

//facebook extension
extension WelcomeDataStore {
    private enum FBReadPermissions: String {
        case publicProfile = "public_profile"
        case email
        case birthday = "user_birthday"
        case friends = "user_friends"
        
        static var all: [String] = [FBReadPermissions.publicProfile.rawValue, FBReadPermissions.email.rawValue, FBReadPermissions.birthday.rawValue, FBReadPermissions.friends.rawValue]
    }
    
    func accessFaceBook() {
        PFFacebookUtils.logInInBackground(withReadPermissions: FBReadPermissions.all) { (user, error) in
            if let currentUser = user as? User {
                if currentUser.isNew {
                    print("this is a new user that just signed up")
                    self.updateProfileFromFacebook(true)
                } else {
                    //let the facebook user sign-in
                    self.updateProfileFromFacebook(false)
                    //                    self.delegate?.performSegueIntoApp()
                }
            } else if let error = error {
                print(error)
            }
        }
    }
    
    private enum FBRequests: String {
        case id
        case email
        case firstName = "first_name"
        case lastName = "last_name"
        
        static var apiString: String = FBRequests.all.joined(separator: ", ")
        static var all: [String] = FBRequests.allFBRequests.map { (request: FBRequests) -> String in
            return request.rawValue
        }
        static var allFBRequests: [FBRequests] = [id, email, firstName, lastName]
    }
    
    //the API request to facebook will look something like this: graph.facebook.com/me?fields=name,email,picture
    //me is a special endpoint that somehow figures out the user's id or token, and then it can access the currentusers info like name, email and picture.
    //look into Facebook Graph API to learn more
    private func updateProfileFromFacebook(_ isNew : Bool) {
        if FBSDKAccessToken.current() != nil {
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": FBRequests.apiString]).start(completionHandler: { (connection, result, error) -> Void in
                if error == nil {
                    print("updating profile from facebook")
                    let currentUser = User.current()!
                    
                    let userData = result as! NSDictionary
                    if let firstName = userData[FBRequests.firstName.rawValue] as? String {
                        currentUser.theFirstName = firstName
                    }
                    if let lastName = userData[FBRequests.lastName.rawValue] as? String {
                        currentUser.theLastName = lastName
                    }
                    currentUser.facebookId = userData[FBRequests.id.rawValue] as? String
                    currentUser.email = userData["email"] as? String
                    currentUser.saveInBackground(block: { (success, error) in
                        if let error = error {
                            let code = error._code
                            if code == PFErrorCode.errorUserEmailTaken.rawValue {
                                //need to make the email a random string with @random.com email address because parse is being stupid. If a user made a facebook account and normal account with the same email address, then it throws this error, and nothing will save for the user. This really only has happened to me in testing because most production users wouldn't create two accounts. But, this will be a temporary fix for now.
                                //TODO: don't let users create a facebook account and normal email address account with same email address.
                                currentUser.email = Helpers.randomString(length: 10) + "@random.com"
                                currentUser.saveInBackground()
                            }
                        }
                    })
                    self.updateFacebookImage()
                } else if let error = error {
                    print(error)
                }
            })
        }
    }
    
    private func updateFacebookImage() {
        let currentUser = User.current()!
        if let facebookId = currentUser.facebookId {
            let pictureURL = "https://graph.facebook.com/" + facebookId + "/picture?type=square&width=600&height=600"
            Alamofire.request(pictureURL).responseData(completionHandler: { (response) in
                if response.result.error == nil {
                    let data = response.result.value
                    currentUser.profileImage = PFFile(name: "profileImage.jpg", data: data!)
                    currentUser.saveInBackground()
                    self.delegate?.segueIntoApplication()
                } else {
                    print("Failed to update profile image from facebook: \(response.result.error)")
                }
            })
        }
    }
}
