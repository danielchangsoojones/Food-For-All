//
//  MainSearchView.swift
//  Food For All
//
//  Created by Daniel Jones on 1/28/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import SnapKit

protocol MainSearchViewDelegate {
    func handleTap()
}

class MainSearchView: UIView {
    var theIconImageView: UIImageView!
    var theSearchLabel: UILabel = UILabel()
    var theClearButton: UIButton = UIButton()
    
    var icon: UIImage {
        return #imageLiteral(resourceName: "Magnifying Glass")
    }
    
    var searchString: String {
        return "Class Type"
    }
    
    fileprivate var sideInset: CGFloat {
        return self.frame.width * 0.02
    }
    
    fileprivate var delegate: MainSearchViewDelegate?
    
    init(frame: CGRect, delegate: MainSearchViewDelegate) {
        super.init(frame: frame)
        backgroundColor = UIColor.white.withAlphaComponent(0.26)
        iconSetup()
        clearButtonSetup()
        searchLabelSetup()
        self.delegate = delegate
        makeTappable()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func iconSetup() {
        theIconImageView = UIImageView(image: icon)
        theIconImageView.contentMode = .scaleAspectFit
        
        self.addSubview(theIconImageView)
        theIconImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(sideInset)
            make.height.equalTo(self).multipliedBy(0.5)
        }
    }
}

//search label extension
extension MainSearchView {
    fileprivate func searchLabelSetup() {
        theSearchLabel.text = searchString
        theSearchLabel.textColor = UIColor.white
        allowSearchLabelStretching()
        theSearchLabel.font = UIFont.systemFont(ofSize: 17, weight: UIFontWeightRegular)
        self.addSubview(theSearchLabel)
        theSearchLabel.snp.makeConstraints { (make) in
            make.top.equalTo(theIconImageView)
            make.bottom.equalTo(theIconImageView)
            make.leading.equalTo(theIconImageView.snp.trailing).offset(self.frame.width * 0.03)
            make.trailing.equalTo(theClearButton.snp.leading)
        }
    }
    
    fileprivate func allowSearchLabelStretching() {
        theSearchLabel.setContentHuggingPriority(250, for: .horizontal)
        theIconImageView.setContentHuggingPriority(1000, for: .horizontal)
    }
}

extension MainSearchView {
    func showClearButton() {
        theClearButton.isHidden = false
    }
    
    func hideClearButton() {
        theClearButton.isHidden = true
    }
    
    func reset() {
        UIView.animate(withDuration: 0.2, animations: {
            self.theSearchLabel.text = self.searchString
            self.hideClearButton()
        })
    }
    
    fileprivate func clearButtonSetup() {
        let side: CGFloat = self.frame.height * 0.4
        theClearButton.isHidden = true
        theClearButton.backgroundColor = UIColor.white.withAlphaComponent(0.68)
        theClearButton.setCornerRadius(radius: side / 2)
        theClearButton.setTitle("X", for: .normal)
        theClearButton.setTitleColor(CustomColors.JellyTeal, for: .normal)
        theClearButton.titleLabel?.font = UIFont.systemFont(ofSize: 10, weight: UIFontWeightRegular)
        self.addSubview(theClearButton)
        theClearButton.snp.makeConstraints({ (make) in
            make.trailing.equalToSuperview().inset(sideInset)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(side)
        })
    }
}

//tap gesture extension
extension MainSearchView {
    fileprivate func makeTappable() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        addGestureRecognizer(tap)
    }
    
    func handleTap(sender: UITapGestureRecognizer? = nil) {
        delegate?.handleTap()
    }
}
