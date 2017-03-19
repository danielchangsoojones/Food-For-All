//
//  NewRatingDataStore.swift
//  Food For All
//
//  Created by Daniel Jones on 2/15/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse
import Mixpanel

protocol NewRatingDataStoreDelegate {
    func finishedSaving(review: Review)
    func savingErrorOccurred()
}

class NewRatingDataStore {
    var delegate: NewRatingDataStoreDelegate?
    
    init(delegate: NewRatingDataStoreDelegate) {
        self.delegate = delegate
    }
    
    func save(review: Review) {
        let r = ReviewParse(review: review)
        r.saveInBackground { (success, error) in
            if success {
                review.reviewParse = r
                self.delegate?.finishedSaving(review: review)
                self.saveReviewAnalytic(review: review)
            } else if let error = error {
                print(error)
                self.delegate?.savingErrorOccurred()
                Helpers.showBanner(title: "Error", subtitle: error.localizedDescription, bannerType: .error)
            }
        }
    }
    
    fileprivate func saveReviewAnalytic(review: Review) {
        if let gig = review.gig {
            Mixpanel.mainInstance().track(event: "New Review", properties: ["Gig Title" : gig.title, "Gig Creator" : gig.creator.fullName ?? "Unknown", "Stars" : review.stars, "Text" : review.description ?? ""])
        }
    }
}
