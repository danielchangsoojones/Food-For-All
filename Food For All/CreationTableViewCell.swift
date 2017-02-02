//
//  CreationTableViewCell.swift
//  Food For All
//
//  Created by Daniel Jones on 2/1/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class CreationTableViewCell: UITableViewCell {
    struct Constants {
        static let completedImage: UIImage = #imageLiteral(resourceName: "Checkmark")
        static let uncompletedImage: UIImage = #imageLiteral(resourceName: "Arrow")
    }
    
    var theIconImageView: UIImageView = UIImageView()
    var theLine: UIView!
    var theTitleLabel: UILabel = UILabel()
    var theCompletionImageView: UIImageView = UIImageView()
    var theContentView: UIView = UIView()
    
    init(iconImage: UIImage, titleText: String) {
        super.init(style: .default, reuseIdentifier: "creationCell")
        self.backgroundColor = UIColor.clear
        contentViewSetup()
        completionImageViewSetup()
        iconSetup(image: iconImage)
        lineSetup()
        titleSetup(text: titleText)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    fileprivate func contentViewSetup() {
        theContentView.addBorder(width: 1.5, color: CustomColors.BombayGray)
        theContentView.backgroundColor = UIColor.white
        theContentView.setCornerRadius(radius: 15)
        self.addSubview(theContentView)
        theContentView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview().inset(10.0)
            make.trailing.leading.equalToSuperview().inset(10.0)
        }
    }
    
    var horizontalSpacing: CGFloat {
        return self.frame.width * 0.03
    }
    
    fileprivate func iconSetup(image: UIImage) {
        theIconImageView.setContentHuggingPriority(1000, for: .horizontal)
        theIconImageView.image = image
        theIconImageView.contentMode = .scaleAspectFit
        theContentView.addSubview(theIconImageView)
        theIconImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(horizontalSpacing)
            make.width.equalToSuperview().multipliedBy(0.05)
            make.height.equalToSuperview().multipliedBy(0.65)
        }
    }
    
    fileprivate func lineSetup() {
        theLine = Helpers.line
        theContentView.addSubview(theLine)
        theLine.snp.makeConstraints { (make) in
            make.leading.equalTo(theIconImageView.snp.trailing).offset(horizontalSpacing)
            make.top.bottom.equalTo(theIconImageView)
            make.width.equalTo(1)
        }
    }
    
    fileprivate func titleSetup(text: String) {
        theTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightLight)
        theTitleLabel.text = text
        theTitleLabel.textColor = CustomColors.JellyTeal
        theContentView.addSubview(theTitleLabel)
        theTitleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalTo(theLine.snp.trailing).offset(horizontalSpacing)
            make.trailing.equalTo(theCompletionImageView.snp.leading)
        }
    }
    
    fileprivate func completionImageViewSetup() {
        theCompletionImageView.image = Constants.uncompletedImage
        theCompletionImageView.contentMode = .scaleAspectFit
        theContentView.addSubview(theCompletionImageView)
        theCompletionImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(horizontalSpacing)
            make.width.equalTo(20.0)
        }
    }
}
