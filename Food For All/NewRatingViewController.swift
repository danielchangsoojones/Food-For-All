//
//  NewRatingViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 2/14/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class NewRatingViewController: UIViewController {
    var theScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardNotifierSetup()
        viewSetup()
    }
    
    fileprivate func viewSetup() {
        let newRatingView = NewRatingView(frame: self.view.bounds)
        self.view = newRatingView
        self.theScrollView = newRatingView.theScrollView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self);
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
