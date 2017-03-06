//
//  DetailDataStore.swift
//  Food For All
//
//  Created by Daniel Jones on 1/27/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse
import ParseFacebookUtilsV4
import SwiftyJSON

protocol DetailDataStoreDelegate {
    func received(mutualFriends: [MutualFriend], totalCount: Int)
}

class DetailDataStore {
    var delegate: DetailDataStoreDelegate?
    
    func saveVenmoMetric(state: String, gig: Gig) {
        let metric = VenmoMetric()
        if let currentUser = User.current() {
            metric.customer = currentUser
        }
        metric.gig = gig.gigParse
        metric.state = state
        metric.saveInBackground()
    }
}

extension DetailDataStore {
    func getMutualFriends(creator: User) {
        if let creatorFBID = creator.facebookId {
            PFCloud.callFunction(inBackground: "findMutualFriends", withParameters: ["targetUserFacebookID": creatorFBID], block: {
                (result: Any?, error: Error?) -> Void in
                if let result = result {
                    let json = JSON(result)
                    let context = json["context"]["all_mutual_friends"]
                    let totalCount: Int = context["summary"]["total_count"].int ?? 0
                    
                    let mutualFriends: [MutualFriend] = context["data"].arrayValue.map({
                        let firstName = $0["first_name"].stringValue
                        let pictureData = $0["picture"]["data"]
                        let url: String = pictureData["url"].stringValue
                        
                        let mutualFriend = MutualFriend(firstName: firstName, profileImage: url)
                        return mutualFriend
                    })
                    
                    self.delegate?.received(mutualFriends: mutualFriends, totalCount: totalCount)
                } else if let error = error {
                    print(error)
                }
            })
        }
    }
}

extension DetailDataStore {
    func getPhotos(gig: Gig, photoDelegate: PhotoFormDelegate) {
        let photoDataStore = PhotoFormDataStore(delegate: photoDelegate)
        photoDataStore.loadPhotos(for: gig)
    }
    
    func getEnlargedProfileImage(enlargedPhotoDelegate: EnlargedPhotoDelegate, gig: Gig) {
        let query = GigDetailPhoto.query()! as! PFQuery<GigDetailPhoto>
        query.whereKey("parent", equalTo: gig.gigParse)
        query.getFirstObjectInBackground { (gigDetailPhoto, error) in
            if let gigDetailPhoto = gigDetailPhoto {
                let photo: EnlargedPhoto = EnlargedPhoto(file: gigDetailPhoto.fullImageFile, delegate: enlargedPhotoDelegate)
            } else if let error = error {
                print(error)
            }
        }
    }
}


