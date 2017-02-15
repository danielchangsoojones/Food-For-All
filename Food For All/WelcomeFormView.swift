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
    struct Constants {
        static let trailingInset: CGFloat = 10
    }
    
    let theTitleLabel: UILabel = UILabel()
    var theTopTextField: UITextField?
    var theBottomTextField: UITextField?
    var theStackView: UIStackView!
    var theScrollView: UIScrollView = UIScrollView()
    var theContentView: UIView = UIView()
    var theKeyboardAccessoryView: UIView!
    var theForwardButton: UIButton!
    var theSpinner: UIActivityIndicatorView!
    
    init(frame: CGRect, title: String, topTextFieldTitle: String? = nil, bottomTextFieldTitle: String? = nil) {
        super.init(frame: frame)
        CustomColors.addGradient(colors: CustomColors.welcomeGradientColors, to: self)
        scrollViewSetup()
        titleLabelSetup(title: title)
        createStackView()
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
            make.trailing.leading.equalTo(self).inset(Constants.trailingInset)
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
        theContentView.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalTo(theScrollView)
            make.width.equalTo(self.frame.width)
        }
    }
}

//textfields
extension WelcomeFormView {
    fileprivate func createTextFields(topTitle: String?, bottomTitle: String?) {
        if let topTitle = topTitle {
            theTopTextField = textFieldSetup(placeholder: topTitle)
            theStackView.addArrangedSubview(theTopTextField!)
        }
        if let bottomTitle = bottomTitle {
            theBottomTextField = textFieldSetup(placeholder: bottomTitle)
            theStackView.addArrangedSubview(theBottomTextField!)
        }
    }
    
    fileprivate func createStackView() {
        theStackView = UIStackView()
        theStackView.axis = .vertical
        theStackView.alignment = .fill
        theStackView.distribution = .equalCentering
        theStackView.spacing = 10
        theContentView.addSubview(theStackView)
        theStackView.snp.makeConstraints { (make) in
            make.trailing.leading.equalTo(theTitleLabel)
            make.top.equalTo(theTitleLabel.snp.bottom)
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
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.spellCheckingType = .no
        textField.snp.makeConstraints { (make) in
            make.height.equalTo(100)
        }
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
        let inputView = ForwardAccessoryView(frame: CGRect(x: 0, y: 0, w: self.frame.width, h: ForwardAccessoryView.Constants.defaultHeight))
        theForwardButton = inputView.theForwardButton
        theSpinner = inputView.theSpinner
        theKeyboardAccessoryView = inputView
    }
}
