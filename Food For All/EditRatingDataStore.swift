//
//  EditRatingDataStore.swift
//  Food For All
//
//  Created by Daniel Jones on 2/15/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation

class EditRatingDataStore: NewRatingDataStore {
    override func save(review: Review) {
        let r = review.reviewParse
        r?.detail = review.description
        r?.stars = review.stars
        r?.saveInBackground(block: { (success, error) in
            if success {
                self.delegate?.finishedSaving(review: review)
            } else if let error = error {
                print(error)
                self.delegate?.savingErrorOccurred()
            }
        })
    }
}
