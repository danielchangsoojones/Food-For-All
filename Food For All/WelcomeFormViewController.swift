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
    var theTopTextField: UITextField?
    var theBottomTextField: UITextField?
    
    open var welcomeFormView: WelcomeFormView {
        return WelcomeFormView(frame: self.view.bounds, title: "Welcome", topTextFieldTitle: "top", bottomTextFieldTitle: "bottom")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        theTopTextField?.becomeFirstResponder()
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
        self.view = welcomeFormView
        if let aWelcomeFormView = self.view as? WelcomeFormView {
            theKeyboardAccessoryView = aWelcomeFormView.theKeyboardAccessoryView
            theForwardButton = aWelcomeFormView.theForwardButton
            theForwardButton.addTarget(self, action: #selector(forwardButtonPressed(sender:)), for: .touchUpInside)
            theSpinner = aWelcomeFormView.theSpinner
            theScrollView = aWelcomeFormView.theScrollView
            if let bottomTextField = aWelcomeFormView.theBottomTextField {
                theBottomTextField = bottomTextField
                theBottomTextField?.delegate = self
            }
            if let topTextField = aWelcomeFormView.theTopTextField {
                theTopTextField = topTextField
                theTopTextField?.delegate = self
            }
        }
    }
    
    override var inputAccessoryView: UIView? {
        return theKeyboardAccessoryView
    }
    
    func forwardButtonPressed(sender: UIButton? = nil) {
        theForwardButton.isSelected = true
        theSpinner.isHidden = false
        theSpinner.startAnimating()
    }
}

//keyboard/keyboard Accessory view extension
extension WelcomeFormViewController {
    func keyboardWillShow(_ notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            //the keyboard accessory view is factored into the keyboardHeight already
            theScrollView.contentInset.bottom = keyboardHeight
        }
    }
}

extension WelcomeFormViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let welcomeFormView = self.view as? WelcomeFormView {
            welcomeFormView.togglePlaceholderColor(textField: textField, shouldDarken: true)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let welcomeFormView = self.view as? WelcomeFormView {
            welcomeFormView.togglePlaceholderColor(textField: textField, shouldDarken: false)
        }
    }
    
    func validateEmail() -> Bool {
        if let email = theTopTextField?.text {
            if !email.isEmail {
                Helpers.showBanner(title: "Invalid Email", subtitle: "You must input a proper email")
                return false
            }
        }
        return true
    }
    
    func validatePassword() -> Bool {
        if let password = theBottomTextField?.text {
            if password.isBlank {
                Helpers.showBanner(title: "Invalid Password", subtitle: "You must input a password")
                return false
            }
        }
        return true
    }
}
