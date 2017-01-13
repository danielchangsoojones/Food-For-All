//
//  WelcomeFormViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 1/12/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class WelcomeFormViewController: UIViewController {
    fileprivate var theKeyboardAccessoryView: UIView!
    fileprivate var theForwardButton: UIButton!
    fileprivate var theSpinner: UIActivityIndicatorView!
    fileprivate var theScrollView: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func viewSetup() {
        let welcomeFormView = WelcomeFormView(frame: self.view.bounds, title: "Log In", topTextFieldTitle: "hi", bottomTextFieldTitle: "boo")
        self.view = welcomeFormView
        theKeyboardAccessoryView = welcomeFormView.theKeyboardAccessoryView
        theForwardButton = welcomeFormView.theForwardButton
        theSpinner = welcomeFormView.theSpinner
        theScrollView = welcomeFormView.theScrollView
    }
    
    override var inputAccessoryView: UIView? {
        return theKeyboardAccessoryView
    }
    
    //for the inputAccessoryView to show
    override var canBecomeFirstResponder: Bool {
        return true
    }
}

//keyboard extension
extension WelcomeFormViewController {
    func keyboardWillShow(_ notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            //the keyboard accessory view is factored into the keyboardHeight already
            theScrollView.contentInset.bottom = keyboardHeight
        }
    }
}
