//
//  WelcomeView.swift
//  Food For All
//
//  Created by Daniel Jones on 1/10/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import SnapKit

class WelcomeView: UIView {
    fileprivate var theStackView = UIStackView()
    fileprivate var theLogInButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        stackViewSetup()
        logInButtonSetup()
        self.backgroundColor = UIColor.red
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//button creation
extension WelcomeView {
    fileprivate func stackViewSetup() {
        theStackView.axis = .vertical
        theStackView.alignment = .fill
        theStackView.distribution = .equalCentering
        theStackView.spacing = 10
        facebookButtonSetup()
        _ = createButton(title: "Create Account", backgroundColor: UIColor.clear, textColor: UIColor.white)
        self.addSubview(theStackView)
        theStackView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.leading.trailing.equalTo(self).inset(self.frame.width * 0.05)
        }
    }
    
    fileprivate func facebookButtonSetup() {
        //TODO: add f logo to the button like the Airbnb page
        let _ = createButton(title: "Continue With Facebook", backgroundColor: UIColor.white, textColor: CustomColors.JellyTeal)
        
    }
    
    private func createButton(title: String, backgroundColor: UIColor, textColor: UIColor) -> UIButton {
        let button = UIButton()
        button.layer.cornerRadius = 25
        button.addBorder(width: 2, color: textColor)
        button.setTitle(title, for: .normal)
        button.setTitleColor(textColor, for: .normal)
        button.layer.borderColor = textColor.cgColor
        button.backgroundColor = backgroundColor
        theStackView.addArrangedSubview(button)
        button.snp.makeConstraints { (make) in
            make.height.equalTo(50)
        }
        return button
    }
    
    fileprivate func logInButtonSetup() {
        theLogInButton.setTitle("Log In", for: .normal)
        theLogInButton.setTitleColor(UIColor.white, for: .normal)
        theLogInButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(theLogInButton)
        theLogInButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(10)
            make.trailing.equalTo(self).inset(10)
        }
    }
}
