//
//  WelcomeFormView.swift
//  Food For All
//
//  Created by Daniel Jones on 1/12/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import TextFieldEffects

class WelcomeFormView: UIView {
    let theTitleLabel: UILabel = UILabel()
    var theTopTextField: UITextField!
    var theBottomTextField: UITextField!
    var theStackView: UIStackView!
    var theScrollView: UIScrollView = UIScrollView()
    var theContentView: UIView = UIView()
    var theKeyboardAccessoryView: UIView = UIView()
    var theForwardButton: UIButton = UIButton()
    var theSpinner: UIActivityIndicatorView = UIActivityIndicatorView()
    
    init(frame: CGRect, title: String, topTextFieldTitle: String, bottomTextFieldTitle: String) {
        super.init(frame: frame)
        scrollViewSetup()
        titleLabelSetup(title: title)
        self.backgroundColor = UIColor.green
        createTextFields(topTitle: topTextFieldTitle, bottomTitle: bottomTextFieldTitle)
        keyboardAccessoryViewSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func titleLabelSetup(title: String) {
        theTitleLabel.text = title
        theTitleLabel.textColor = UIColor.white
        theTitleLabel.font = UIFont.systemFont(ofSize: 40)
        theContentView.addSubview(theTitleLabel)
        theTitleLabel.snp.makeConstraints { (make) in
            make.trailing.leading.equalTo(self)
            make.top.equalTo(theContentView)
        }
    }
}

//scroll view
extension WelcomeFormView {
    fileprivate func scrollViewSetup() {
        contentViewSetup()
        self.addSubview(theScrollView)
        theScrollView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalTo(self)
            make.top.equalTo(self)
        }
    }
    
    fileprivate func contentViewSetup() {
        theScrollView.addSubview(theContentView)
        theContentView.backgroundColor = UIColor.blue
        theContentView.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalTo(theScrollView)
            make.width.equalTo(self.frame.width)
        }
    }
}

//textfields
extension WelcomeFormView {
    fileprivate func createTextFields(topTitle: String, bottomTitle: String) {
        theTopTextField = textFieldSetup(placeholder: topTitle)
        theBottomTextField = textFieldSetup(placeholder: bottomTitle)
        createTextFieldStackView()
    }
    
    fileprivate func createTextFieldStackView() {
        theStackView = UIStackView(arrangedSubviews: [theTopTextField, theBottomTextField])
        theStackView.axis = .vertical
        theStackView.alignment = .fill
        theStackView.distribution = .fillEqually
        theStackView.spacing = 10
        theContentView.addSubview(theStackView)
        theStackView.snp.makeConstraints { (make) in
            make.trailing.leading.equalToSuperview()
            make.top.equalTo(theTitleLabel.snp.bottom)
            make.height.equalTo(200)
            make.bottom.equalToSuperview() //to tell the scrollView/ContentView how big it should be
        }
    }
    
    
    fileprivate func textFieldSetup(placeholder: String) -> UITextField {
        let textField = HoshiTextField(frame: CGRect.zero)
        togglePlaceholderColor(textField: textField, shouldDarken: false)
        textField.font = UIFont.boldSystemFont(ofSize: 20)
        textField.placeholderFontScale = 0.9
        textField.borderActiveColor = UIColor.white
        textField.borderInactiveColor = UIColor.white.withAlphaComponent(0.5)
        textField.textColor = UIColor.white
        textField.placeholder = placeholder
        return textField
    }
    
    func togglePlaceholderColor(textField: UITextField, shouldDarken: Bool) {
        //TODO: the textfield label alpha is not changing because in the hoshiText field class, it is animating it to 0.5 over 0.2 seconds. So, when we change the textfieldLabel alpha in here, it just gets changed back over time. We will need to subclass the hoshi text field or something to make it change the alpha after the animation has completed.
        if let hoshiTextField = textField as? HoshiTextField {
            let defaultColor = UIColor.white.withAlphaComponent(0.5)
            let elevatedColor: UIColor = textField.textColor ?? defaultColor
            hoshiTextField.placeholderColor = shouldDarken ? elevatedColor : defaultColor
        }
    }
}

//keyboard accessory view
extension WelcomeFormView {
    fileprivate func keyboardAccessoryViewSetup() {
        theKeyboardAccessoryView.frame = CGRect(x: 0, y: 0, w: self.frame.width, h: 100)
        theKeyboardAccessoryView.backgroundColor = UIColor.clear
        forwardButtonSetup()
    }
    
    fileprivate func forwardButtonSetup() {
        theForwardButton.backgroundColor = UIColor.white
        let side: CGFloat = 40
        theForwardButton.layer.cornerRadius = side / 2
        theForwardButton.setImage(#imageLiteral(resourceName: "ArrowHead"), for: .normal)
        theForwardButton.imageView?.contentMode = .scaleAspectFit
        let inset = side * 0.25
        theForwardButton.imageEdgeInsets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        theForwardButton.clipsToBounds = true
        theForwardButton.alpha = 0.8
        theKeyboardAccessoryView.addSubview(theForwardButton)
        theForwardButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(theKeyboardAccessoryView)
            make.width.height.equalTo(side)
        }
        spinnerSetup()
    }
    
    fileprivate func spinnerSetup() {
        theForwardButton.addSubview(theSpinner)
        theSpinner.color = CustomColors.JellyTeal
        theSpinner.isHidden = true
        theSpinner.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(theForwardButton.frame.height * 0.05)
        }
    }
}
