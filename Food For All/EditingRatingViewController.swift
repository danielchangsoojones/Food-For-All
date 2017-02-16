//
//  EditingRatingViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 2/15/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import SCLAlertView

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
        rightBarButtonSetup()
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

//nav bar extension
extension EditingRatingViewController {
    fileprivate func rightBarButtonSetup() {
        let button = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteReview))
        navigationItem.rightBarButtonItem = button
    }
    
    func deleteReview() {
        let alertView = SCLAlertView()
        alertView.addButton("Delete") {
            self.editDelegate?.remove(review: self.review)
            if let dataStore = self.dataStore as? EditRatingDataStore {
                dataStore.delete(review: self.review)
            }
            self.popVC()
        }
        alertView.showWarning("Delete Review", subTitle: "Are you sure you want to delete this review?")
    }
}
