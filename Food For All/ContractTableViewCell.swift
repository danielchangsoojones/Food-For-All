//
//  ContractTableViewCell.swift
//  Food For All
//
//  Created by Daniel Jones on 3/12/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class ContractTableViewCell: UITableViewCell {
    struct Constants {
        static let verticalSpacing: CGFloat = 10
    }
    
    override var reuseIdentifier: String? {
        return ContractTableViewCell.identifier
    }
    
    var theContentView: UIView!
    var theTitleLabel: UILabel!
    var theDescriptionLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.clear
        contentViewSetup()
        titleLabelSetup()
        descriptionLabelSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func contentViewSetup() {
        theContentView = UIView()
        theContentView.addBorder(width: 1.5, color: CustomColors.BombayGray)
        theContentView.backgroundColor = UIColor.white
        theContentView.setCornerRadius(radius: 15)
        self.addSubview(theContentView)
        theContentView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview().inset(10.0)
            make.trailing.leading.equalToSuperview().inset(10.0)
        }
    }
    
    fileprivate func titleLabelSetup() {
        theTitleLabel = UILabel()
        theTitleLabel.textColor = CustomColors.JellyTeal
        theTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightBold)
        theContentView.addSubview(theTitleLabel)
        theTitleLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().inset(15)
            make.top.equalToSuperview().inset(Constants.verticalSpacing)
        }
    }
    
    fileprivate func descriptionLabelSetup() {
        theDescriptionLabel = UILabel()
        theDescriptionLabel.textColor = CustomColors.SilverChalice
        theDescriptionLabel.numberOfLines = 0
        theDescriptionLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightLight)
        theContentView.addSubview(theDescriptionLabel)
        theDescriptionLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(theTitleLabel)
            make.top.equalTo(theTitleLabel.snp.bottom).offset(Constants.verticalSpacing / 2)
            make.bottom.equalToSuperview().inset(Constants.verticalSpacing)
        }
    }
    
    func set(price: String?, time: String?, estimatedDuration: String?) {
        let str: NSMutableAttributedString = NSMutableAttributedString(string: "")
        
        //TODO: my range is manually counted by me. If I ever changed a title, it would break
        if let price = price {
            let priceString: NSMutableAttributedString = NSMutableAttributedString(string: "Price: " + price + "\n")
            priceString.setAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: theDescriptionLabel.font.pointSize, weight: UIFontWeightBold)], range: NSMakeRange(0, 7))
            str.append(priceString)
        }
        if let time = time {
            let timeString: NSMutableAttributedString = NSMutableAttributedString(string: "Time: " + time)
            timeString.setAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: theDescriptionLabel.font.pointSize, weight: UIFontWeightBold)], range: NSMakeRange(0, 6))
            str.append(timeString)
        }
        if let duration = estimatedDuration {
            let durationString: NSMutableAttributedString = NSMutableAttributedString(string: "\n\(ServiceFormViewController.Constants.estimatedDuration): " + duration)
            durationString.setAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: theDescriptionLabel.font.pointSize, weight: UIFontWeightBold)], range: NSMakeRange(0, 20))
            str.append(durationString)
        }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        
        str.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, str.length))
        
        theDescriptionLabel.attributedText = str
    }
}

extension ContractTableViewCell {
    static let identifier = "contractTableCell"
}
