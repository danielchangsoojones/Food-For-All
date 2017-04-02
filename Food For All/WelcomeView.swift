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
    struct Constants {
        static let topCornerInset: CGFloat = 10
        static let sideCornerInset: CGFloat = 10
    }
    
    var theStackView = UIStackView()
    var theLogInButton = UIButton()
    var theFacebookButton = UIButton()
    var theSignUpButton = UIButton()
    var theLogoImageView: UIImageView = UIImageView(image: #imageLiteral(resourceName: "Logo"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addBackgroundGradient()
        stackViewSetup()
        logInButtonSetup()
        signInButtonSetup()
        logoSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addBackgroundGradient() {
        CustomColors.addGradient(colors: CustomColors.welcomeGradientColors, to: self)
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
        self.addSubview(theStackView)
        theStackView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.leading.trailing.equalTo(self).inset(self.frame.width * 0.05)
        }
        facebookWarningLabelSetup()
    }
    
    fileprivate func facebookButtonSetup() {
        //TODO: add f logo to the button like the Airbnb page
        theFacebookButton = createButton(title: "Continue With Facebook", backgroundColor: UIColor.white, textColor: CustomColors.JellyTeal)
    }
    
    fileprivate func facebookWarningLabelSetup() {
        let warningLabel = UILabel()
        warningLabel.text = "Don't Worry! We never post to Facebook without your permission"
        warningLabel.textColor = UIColor.white
        warningLabel.numberOfLines = 0
        warningLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightRegular)
        warningLabel.textAlignment = .center
        self.addSubview(warningLabel)
        warningLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(theFacebookButton).inset(10)
            make.top.equalTo(theFacebookButton.snp.bottom).offset(10)
        }
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
        theLogInButton = createCornerButton(title: "Log In")
        theLogInButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(Constants.topCornerInset)
            make.trailing.equalTo(self).inset(Constants.sideCornerInset)
        }
    }
    
    fileprivate func signInButtonSetup() {
        theSignUpButton = createCornerButton(title: "Email")
        theSignUpButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(Constants.topCornerInset)
            make.leading.equalTo(self).inset(Constants.sideCornerInset)
        }
    }
    
    fileprivate func createCornerButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(button)
        return button
    }
}

extension WelcomeView {
    fileprivate func logoSetup() {
        theLogoImageView.image = theLogoImageView.image!.withRenderingMode(.alwaysTemplate)
        theLogoImageView.tintColor = UIColor.white
        theLogoImageView.contentMode = .scaleAspectFit
        self.addSubview(theLogoImageView)
        theLogoImageView.snp.makeConstraints { (make) in
            let inset: CGFloat = self.frame.height * 0.1
            make.top.equalTo(theLogInButton).offset(inset)
            make.bottom.equalTo(theStackView.snp.top).offset(-inset)
            make.centerX.equalToSuperview()
        }
    }
}
