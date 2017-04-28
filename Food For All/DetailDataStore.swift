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
    
    func save(contract: Contract) {
        let contractParse = ContractParse(contract: contract)
        contractParse.saveInBackground()
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
    
    func getEnlargedProfileImage(enlargedPhoto: EnlargedPhoto, gig: Gig) {
        let query = GigImage.query()! as! PFQuery<GigImage>
        query.whereKey("parent", equalTo: gig.gigParse)
        query.getFirstObjectInBackground { (photo, error) in
            if let photo = photo {
                //We have to set the file on this enlargedPhoto, rather than creating a new instance because NYTPhotoViewController requires that photos be at initialization, so we had to add a placeholder photo, and then we just update the file on that image. It's hacky, but it's a workaround. 
                if let file = photo.fullFrontImage {
                    enlargedPhoto.set(file: file)
                } else {
                    //no enlarged photo file exists for the gig currently
                    enlargedPhoto.set(file: gig.fullSizeFrontImage)
                }
            } else if let error = error {
                if let code = PFErrorCode(rawValue: error._code) {
                    switch code {
                    case .errorObjectNotFound:
                        enlargedPhoto.set(file: gig.fullSizeFrontImage)
                    default:
                        print(error)
                    }
                }
            }
        }
    }
}


