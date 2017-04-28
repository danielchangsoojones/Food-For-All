//
//  MessageTableViewCell.swift
//  Food For All
//
//  Created by Daniel Jones on 4/22/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import Timepiece

class MessageTableViewCell: UITableViewCell {
    struct Constants {
        static let horizontalInset: CGFloat = 10
    }
    
    var theNameLabel : UILabel!
    var theCircleImageView : CircularImageView!
    var theTimeStamp : UILabel!
    var theSubtitleLabel : UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        profileCircleSetup()
        timeStampSetup()
        nameLabelSetup()
        subtitleLabelSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setContents(contract: Contract) {
        theTimeStamp.text = formatTimeStamp(contract.sentDate)
    }
    
    fileprivate func profileCircleSetup() {
        let diameter : CGFloat = self.frame.width * 0.2
        theCircleImageView = CircularImageView(file: nil, diameter: diameter)
        self.addSubview(theCircleImageView)
        theCircleImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.leading.equalTo(self).offset(Constants.horizontalInset)
            make.width.height.equalTo(diameter)
        }
    }
    
    fileprivate func timeStampSetup() {
        theTimeStamp = UILabel()
        theTimeStamp.font = UIFont.systemFont(ofSize: 10)
        //We want the timeStamp to not grow, nor shrink in regards to the size of theNameLabel. theNameLabel, if too long, should be the one to shrink.
        theTimeStamp.sizeToFit()
        theTimeStamp.setContentHuggingPriority(1000, for: .horizontal)
        theTimeStamp.setContentCompressionResistancePriority(1000, for: .horizontal)
        self.addSubview(theTimeStamp)
        theTimeStamp.snp.makeConstraints { (make) in
            make.trailing.equalTo(self).inset(Constants.horizontalInset)
            //TODO: I want this line up with the Name Label center, but can't figure out how to do that.
            make.top.equalTo(theCircleImageView).offset(13)
        }
    }
    
    func formatTimeStamp(_ date: Date) -> String {
        let formatter = DateFormatter()
        let lessThan24Hours : Bool = date >= 1.day.ago ?? Date()
        if lessThan24Hours {
            formatter.dateFormat = "h:mm a"
            formatter.amSymbol = "AM"
            formatter.pmSymbol = "PM"
            let dateString = formatter.string(from: date) //ex: "10:15 AM"
            return dateString
        } else {
            formatter.dateStyle = .medium
            formatter.timeStyle = .none
            let dateString = formatter.string(from: date) //ex: "Sep 10, 2015"
            return dateString
        }
    }
    
    fileprivate func nameLabelSetup() {
        theNameLabel = UILabel()
        theNameLabel.font = UIFont.systemFont(ofSize: 20)
        self.addSubview(theNameLabel)
        theNameLabel.snp.makeConstraints { (make) in
            //TODO: line up the top of timestamp and the top of the nameLabel
            make.top.equalTo(theCircleImageView).offset(10)
            make.leading.equalTo(theCircleImageView.snp.trailing).offset(10)
            make.trailing.equalTo(theTimeStamp.snp.leading)
        }
    }
    
    fileprivate func subtitleLabelSetup() {
        theSubtitleLabel = UILabel()
        self.addSubview(theSubtitleLabel)
        theSubtitleLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(theNameLabel)
            make.top.equalTo(theNameLabel.snp.bottom)
            make.trailing.equalTo(theTimeStamp.snp.trailing)
        }
    }
}
