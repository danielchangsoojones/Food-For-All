//
//  AgreementView.swift
//  Food For All
//
//  Created by Daniel Jones on 2/23/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import TTTAttributedLabel

class AgreementView: UIView {
    struct Constants {
        static let verticalSpacing: CGFloat = 15
    }
    
    var theTitleLabel: UILabel!
    var theStackView: UIStackView!
    var theAgreementLabel: TTTAttributedLabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleSetup()
        stackViewSetup()
        agreeingLabelSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func stackViewSetup() {
        theStackView = UIStackView()
        theStackView.axis = .vertical
        theStackView.alignment = .leading
        theStackView.distribution = .equalSpacing
        theStackView.spacing = Constants.verticalSpacing
        self.addSubview(theStackView)
        theStackView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(self.frame.width * 0.1)
            make.top.equalTo(theTitleLabel.snp.bottom).offset(40)
        }
        let bullet1 = BulletLabel(text: "I am a Bloomington student")
        let bullet2 = BulletLabel(text: "I understand that no user is considered a \"professional\"")
        let bullet3 = BulletLabel(text: "I will contribute to the honesty of this community")
        theStackView.addArrangedSubview(bullet1)
        theStackView.addArrangedSubview(bullet2)
        theStackView.addArrangedSubview(bullet3)
    }
    
    fileprivate func titleSetup() {
        theTitleLabel = UILabel()
        theTitleLabel.text = "Gigio Oath"
        theTitleLabel.font = UIFont.systemFont(ofSize: 40, weight: UIFontWeightThin)
        theTitleLabel.textColor = UIColor.white
        theTitleLabel.setContentHuggingPriority(1000, for: .vertical)
        self.addSubview(theTitleLabel)
        theTitleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(self.frame.height * 0.1)
        }
    }
    
    fileprivate func agreeingLabelSetup() {
        let tLabel = TTTAttributedLabel(frame: CGRect.zero)
        let termsOfServiceString = "terms of service"
        let privacyPolicyString = "privacy policy"
        let str = "By agreeing, you agree to our \(termsOfServiceString) and \(privacyPolicyString)"
        let nsString: NSString = NSString(string: str)
        
        tLabel.numberOfLines = 2
        tLabel.textColor = UIColor.white
        tLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightBold)
        //You have to make sure that you set the attributes of the text before we set the text, just a bug in TTLabel, and that is the workaround
        tLabel.text = str
        tLabel.textAlignment = .center
        tLabel.linkAttributes = [kCTForegroundColorAttributeName as AnyHashable: UIColor.white, NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue]
        
        let termsRange = nsString.range(of: termsOfServiceString)
        let termsURL = URL(string: "https://www.google.com/")
        tLabel.addLink(to: termsURL, with: termsRange)
        
        
        let privacyRange = nsString.range(of: privacyPolicyString)
        let privacyURL = URL(string: "https://www.google.com/")
        tLabel.addLink(to: privacyURL, with: privacyRange)
        
        theAgreementLabel = tLabel
        self.addSubview(theAgreementLabel)
        theAgreementLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(theStackView)
            make.bottom.equalToSuperview().inset(5)
        }
    }
}
