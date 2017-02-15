//
//  NewRatingViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 2/14/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import NextGrowingTextView

class NewRatingViewController: UIViewController {
    var theScrollView: UIScrollView!
    var theInputView: UIView!
    var theSpinner: UIActivityIndicatorView!
    var theForwardButton: UIButton!
    var theTextView: NextGrowingTextView!
    var theStarsView: MyCosmosView!
    
    var dataStore: NewRatingDataStore?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardNotifierSetup()
        viewSetup()
        dataStoreSetup()
    }
    
    fileprivate func viewSetup() {
        let newRatingView = NewRatingView(frame: self.view.bounds)
        self.view = newRatingView
        self.theScrollView = newRatingView.theScrollView
        theInputView = newRatingView.theInputView
        theSpinner = newRatingView.theSpinner
        theForwardButton = newRatingView.theForwardButton
        newRatingView.theForwardButton.addTarget(self, action: #selector(forwardPressed(sender:)), for: .touchUpInside)
        theTextView = newRatingView.theGrowingTextView
        theStarsView = newRatingView.theCosmosView
    }
    
    override var inputAccessoryView: UIView? {
        return theInputView
    }
    
    override var canBecomeFirstResponder: Bool {
        //setting to true, so the keyboard accessory input view shows up at bottom of the screen before a keyboard is ever shown
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self);
    }
    
    fileprivate func dataStoreSetup() {
        dataStore = NewRatingDataStore(delegate: self)
    }
}

extension NewRatingViewController {
    fileprivate func keyboardNotifierSetup() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow(_ notification: NSNotification){
        let keyboardHeight = Helpers.getKeyboardHeight(notification: notification)
        theScrollView.contentInset.bottom = keyboardHeight
    }
    
    func keyboardWillHide(_ notification: NSNotification){
        theScrollView.contentInset.bottom = 0
    }
}

extension NewRatingViewController: NewRatingDataStoreDelegate {
    func forwardPressed(sender: UIButton) {
        if isValidData {
            let review = Review()
            review.description = theTextView.text
            review.stars = theStarsView.rating
            dataStore?.save(review: review)
        }
    }
    
    fileprivate var isValidData: Bool {
        var isValidStars: Bool = false
        if theStarsView.rating > 0 {
            isValidStars = true
        } else {
            Helpers.showBanner(title: "Input Stars", subtitle: "Please input your star rating", bannerType: .error)
            return isValidStars
        }
        
        var isValidText = false
        if theTextView.text.isNotEmpty {
            isValidText = true
        } else {
            Helpers.showBanner(title: "Input a note", subtitle: "Please input some details about your review", bannerType: .error)
            return isValidText
        }
        return isValidText && isValidStars
    }
    
    func finishedSaving(review: Review) {
        toggleButton(disabled: true)
    }
    
    func savingErrorOccurred() {
        toggleButton(disabled: false)
    }
    
    fileprivate func toggleButton(disabled: Bool) {
        theForwardButton.isSelected = disabled
        theForwardButton.isUserInteractionEnabled = !disabled
        if disabled {
            theSpinner.isHidden = false
            theSpinner.startAnimating()
        } else {
            theSpinner.stopAnimating()
        }
    }
}
