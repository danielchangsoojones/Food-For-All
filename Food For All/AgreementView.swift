//
//  AgreementView.swift
//  Food For All
//
//  Created by Daniel Jones on 2/23/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class AgreementView: UIView {
    struct Constants {
        static let verticalSpacing: CGFloat = 15
    }
    
    var theTitleLabel: UILabel!
    var theStackView: UIStackView!
    
    var sideInset: CGFloat {
        return self.frame.width * 0.05
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleSetup()
        stackViewSetup()
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
            make.leading.trailing.equalToSuperview().inset(sideInset)
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
}
