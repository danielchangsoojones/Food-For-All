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
    var theTopTextField: KaedeTextField!
    var theBottomTextField: KaedeTextField!
    var theStackView: UIStackView!
    
    init(frame: CGRect, title: String, topTextFieldTitle: String, bottomTextFieldTitle: String) {
        super.init(frame: frame)
        titleLabelSetup(title: title)
        self.backgroundColor = UIColor.green
//        createTextFields(topTitle: topTextFieldTitle, bottomTitle: bottomTextFieldTitle)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func titleLabelSetup(title: String) {
        theTitleLabel.text = title
        theTitleLabel.font = UIFont.systemFont(ofSize: 40)
        self.addSubview(theTitleLabel)
        theTitleLabel.snp.makeConstraints { (make) in
            make.top.trailing.leading.equalTo(self)
        }
    }
}

extension WelcomeFormView {
    fileprivate func createTextFields(topTitle: String, bottomTitle: String) {
        theTopTextField = textFieldSetup()
        theBottomTextField = textFieldSetup()
        createTextFieldStackView()
    }
    
    fileprivate func createTextFieldStackView() {
        theStackView = UIStackView(arrangedSubviews: [theTopTextField, theBottomTextField])
        theStackView.axis = .vertical
        theStackView.alignment = .fill
        theStackView.distribution = .fillEqually
        theStackView.spacing = 10
        self.addSubview(theStackView)
        theStackView.snp.makeConstraints { (make) in
            make.trailing.leading.equalToSuperview()
            make.top.equalTo(theTitleLabel)
    
            //TODO: set the bottom to the button
            make.bottom.equalTo(self)
        }
    }
    
    
    fileprivate func textFieldSetup() -> KaedeTextField {
        let textField = KaedeTextField(frame: CGRect.zero)
        textField.placeholderColor = UIColor.blue
        textField.foregroundColor = UIColor.red
        return textField
    }
}
