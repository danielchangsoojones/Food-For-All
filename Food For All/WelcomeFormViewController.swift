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
    fileprivate var theTopTextField: UITextField!
    fileprivate var theBottomTextField: UITextField!
    
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
        theForwardButton.addTarget(self, action: #selector(forwardButtonPressed(sender:)), for: .touchUpInside)
        theSpinner = welcomeFormView.theSpinner
        theScrollView = welcomeFormView.theScrollView
        theBottomTextField = welcomeFormView.theBottomTextField
        theTopTextField = welcomeFormView.theTopTextField
        theBottomTextField.delegate = self
        theTopTextField.delegate = self
    }
    
    override var inputAccessoryView: UIView? {
        return theKeyboardAccessoryView
    }
    
    //for the inputAccessoryView to show
    override var canBecomeFirstResponder: Bool {
        return true
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
    
    func forwardButtonPressed(sender: UIButton? = nil) {
        print("implement whatever segue we should be doing")
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
}
