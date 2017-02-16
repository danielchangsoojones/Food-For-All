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
    var theTitleLabel: UILabel!
    
    var dataStore: NewRatingDataStore?
    var gig: Gig!
    
    init(gig: Gig) {
        super.init(nibName: nil, bundle: nil)
        self.gig = gig
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardNotifierSetup()
        leftBarButtonSetup()
        viewSetup()
        dataStoreSetup()
        scrollWithTyping()
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
        theTitleLabel = newRatingView.theTitleLabel
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
    
    //TODO: I want to turn the status bar black, but can't figure out how to do that yet.
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func dataStoreSetup() {
        dataStore = NewRatingDataStore(delegate: self)
    }
    
    var reviewToSave: Review {
        let review = Review()
        configure(review: review)
        return review
    }
    
    func configure(review: Review) {
        review.description = theTextView.text
        review.stars = theStarsView.rating
        review.gig = gig
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
            dataStore?.save(review: reviewToSave)
        }
    }
    
    var isValidData: Bool {
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

//scroll view extension
extension NewRatingViewController {
    fileprivate func scrollWithTyping() {
        theTextView.delegates.willChangeHeight = {(height: CGFloat) in
            let height: CGFloat = 20
            let visibleRect = CGRect(x: 0, y: self.theScrollView.contentSize.height - height, w: self.theScrollView.contentSize.width, h: height)
            self.theScrollView.scrollRectToVisible(visibleRect, animated: true)
        }
    }
}

//navigation Setup
extension NewRatingViewController {
    fileprivate func leftBarButtonSetup() {
        let button = UIBarButtonItem(image: #imageLiteral(resourceName: "X"), style: .plain, target: self, action: #selector(exitTapped))
        navigationItem.leftBarButtonItem = button
    }
    
    func exitTapped() {
        popVC()
    }
}
