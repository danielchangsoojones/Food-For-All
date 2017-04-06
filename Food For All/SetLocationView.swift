//
//  SetLocationView.swift
//  Food For All
//
//  Created by Daniel Jones on 4/5/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import TextFieldEffects
import EZSwiftExtensions

class SetLocationView: UIView {
    var theStackView: UIStackView!
    var theLocationButton: UIButton!
    var theZipCodeTextField: UITextField!
    var theSaveButton: UIButton!
    var theKeyboardAccessoryView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        stackViewSetup()
        keyboardAccessoryViewSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func stackViewSetup() {
        theStackView = UIStackView()
        theStackView.axis = .vertical
        theStackView.distribution = .equalSpacing
        theStackView.alignment = .center
        theStackView.spacing = 20
        searchingLabelSetup()
        locationButtonSetup()
        zipCodeTextFieldSetup()
        self.addSubview(theStackView)
        theStackView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            //I'm not sure why, but just having it centered looks funny
            make.centerY.equalToSuperview().offset(-20)
        }
    }
    
    fileprivate func searchingLabelSetup() {
        let searchingLabel = UILabel()
        searchingLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightBold)
        searchingLabel.textColor = UIColor.white
        searchingLabel.textAlignment = .center
        searchingLabel.text = "Where are you searching?"
        theStackView.addArrangedSubview(searchingLabel)
    }
    
    fileprivate func locationButtonSetup() {
        theLocationButton = UIButton()
        theLocationButton.setCornerRadius(radius: 15)
        theLocationButton.backgroundColor = CustomColors.Polar
        theLocationButton.setTitle("Get Current Location", for: .normal)
        theLocationButton.setTitleColor(CustomColors.SilverChalice, for: .normal)
        theLocationButton.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: UIFontWeightBold)
        theLocationButton.setImage(#imageLiteral(resourceName: "LocationIcon"), for: .normal)
        
        
        //putting the image on the left side of the title
        theLocationButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        theLocationButton.titleLabel?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        theLocationButton.imageView?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        let leftPadding: CGFloat = 5
        theLocationButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -leftPadding, bottom: 0, right: leftPadding)
        
        let contentInset: CGFloat = 15
        theLocationButton.contentEdgeInsets = UIEdgeInsets(top: contentInset, left: contentInset + leftPadding, bottom: contentInset, right: contentInset)
        theStackView.addArrangedSubview(theLocationButton)
    }
    
    fileprivate func zipCodeTextFieldSetup() {
        theZipCodeTextField = UITextField()
        theZipCodeTextField.font = UIFont.systemFont(ofSize: 30)
        theZipCodeTextField.attributedPlaceholder = NSAttributedString(string: "Enter Zip Code", attributes: [NSForegroundColorAttributeName: UIColor.white.withAlphaComponent(0.5)])
        theZipCodeTextField.textColor = UIColor.white
        theZipCodeTextField.backgroundColor = UIColor.clear
        theZipCodeTextField.textAlignment = .center
        theZipCodeTextField.keyboardType = .numberPad
        addBottomLineToTextField()
        theStackView.addArrangedSubview(theZipCodeTextField)
    }
    
    fileprivate func addBottomLineToTextField() {
        let line = Helpers.line
        line.backgroundColor = UIColor.white
        line.alpha = 1
        theZipCodeTextField.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.bottom.leading.trailing.equalToSuperview()
        }
    }
}

extension SetLocationView {
    fileprivate func keyboardAccessoryViewSetup() {
        //TODO: the height right now is not really based upon anything.
        theKeyboardAccessoryView = UIView(x: 0, y: 0, w: self.frame.width, h: 70)
        saveButtonSetup()
    }
    
    fileprivate func saveButtonSetup() {
        theSaveButton = Helpers.stylizeButton(text: "Save")
        theKeyboardAccessoryView.addSubview(theSaveButton)
        theSaveButton.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
}
