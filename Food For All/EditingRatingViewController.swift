//
//  EditingRatingViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 2/15/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

protocol EditRatingVCDelegate: NewRatingVCDelegate {
    func update(review: Review)
    func remove(review: Review)
}

class EditingRatingViewController: NewRatingViewController {
    var review: Review!
    
    var editDelegate: EditRatingVCDelegate?
    
    override var reviewToSave: Review {
        configure(review: review)
        return review
    }
    
    init(gig: Gig, review: Review) {
        super.init(gig: gig)
        self.review = review
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setContent()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func setContent() {
        theTitleLabel.text = "Edit Rating"
        theStarsView.rating = review.stars
        theTextView.text = review.description
    }
    
    override func dataStoreSetup() {
        dataStore = EditRatingDataStore(delegate: self)
    }
    
    override func updateDelegate(review: Review) {
        editDelegate?.update(review: review)
    }
}
