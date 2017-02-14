//
//  ReviewTableViewCell.swift
//  Food For All
//
//  Created by Daniel Jones on 2/11/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import ReadMoreTextView

class ReviewTableViewCell: UITableViewCell {
    struct Constants {
        static let headerHeight: CGFloat = 50
        static let headerFontSize: CGFloat = 15
        static let headerInset: CGFloat = 10
    }
    
    var theCircularProfileView: CircularImageView!
    var theHeaderView: UIView!
    var theNameLabel: UILabel!
    var theDateLabel: UILabel!
    var theContentView: UIView!
    var theDescriptionTextView: ReadMoreTextView!
    
    var review: Review!
    
    var less = true
    
    init(review: Review) {
        super.init(style: .default, reuseIdentifier: "allReviewsCell")
        self.review = review
        headerViewSetup()
        contentViewSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//header view extension
extension ReviewTableViewCell {
    fileprivate func headerViewSetup() {
        theHeaderView = UIView(frame: CGRect.zero)
        self.addSubview(theHeaderView)
        theHeaderView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(Constants.headerInset)
            make.top.equalToSuperview()
            make.height.equalTo(70)
        }
        profileImageSetup()
        nameSetup()
        dateSetup()
    }
    
    fileprivate func profileImageSetup() {
        theCircularProfileView = CircularImageView(file: review.creator.profileImage, diameter: Constants.headerHeight)
        theHeaderView.addSubview(theCircularProfileView)
        theCircularProfileView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    //TODO: the name and date should probably be better calculated on height, like maybe stick into a stack view and then fit to size or something. Right now, it is just hard coded.
    fileprivate func nameSetup() {
        theNameLabel = UILabel()
        theNameLabel.text = review.creator.firstName
        theNameLabel.font = UIFont.systemFont(ofSize: Constants.headerFontSize, weight: UIFontWeightMedium)
        theHeaderView.addSubview(theNameLabel)
        theNameLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(theCircularProfileView.snp.trailing).offset(10)
            make.top.equalTo(theCircularProfileView).offset(3)
        }
    }
    
    fileprivate func dateSetup() {
        theDateLabel = UILabel()
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, y"
        theDateLabel.text = formatter.string(from: review.updated)
        theDateLabel.font = UIFont.systemFont(ofSize: Constants.headerFontSize, weight: UIFontWeightLight)
        theHeaderView.addSubview(theDateLabel)
        theDateLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(theNameLabel)
            make.top.equalTo(theNameLabel.snp.bottom).offset(5)
        }
    }
}

//description
extension ReviewTableViewCell {
    fileprivate func contentViewSetup() {
        theContentView = UIView()
        self.addSubview(theContentView)
        theContentView.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(theHeaderView)
            make.top.equalTo(theHeaderView.snp.bottom)
            make.bottom.equalTo(self)
        }
        descriptionSetup()
    }
    
    //TODO: the goal is to get the reviews to have a readme and readLess button at the end, but I can't get the cells to grow correctly in accordance with this
    fileprivate func descriptionSetup() {
        let reviewText = "Bacon ipsum dolor amet tongue salami beef ribs shoulder t-bone, doner kevin jowl pancetta meatloaf tail. Salami pig sausage fatback jowl turkey, tongue kielbasa. Pig tail hamburger shank filet mignon tri-tip boudin chicken turducken rump flank sirloin. Shankle andouille pork chop short ribs drumstick swine tail meatball fatback pancetta.Bacon ipsum dolor amet tongue salami beef ribs shoulder t-bone, doner kevin jowl pancetta meatloaf tail. Salami pig sausage fatback jowl turkey, tongue kielbasa. Pig tail hamburger shank filet mignon tri-tip boudin chicken turducken rump flank sirloin. Shankle andouille pork chop short ribs drumstick swine tail meatball fatback pancetta.Bacon ipsum dolor amet tongue salami beef ribs shoulder t-bone, doner kevin jowl pancetta meatloaf tail. Salami pig sausage fatback jowl turkey, tongue kielbasa. Pig tail hamburger shank filet mignon tri-tip boudin chicken turducken rump flank sirloin. Shankle andouille pork chop short ribs drumstick swine tail meatball fatback pancetta.Bacon ipsum dolor amet tongue salami beef ribs shoulder t-bone, doner kevin jowl pancetta meatloaf tail. Salami pig sausage fatback jowl turkey, tongue kielbasa. Pig tail hamburger shank filet mignon tri-tip boudin chicken turducken rump flank sirloin. Shankle andouille pork chop short ribs drumstick swine tail meatball fatback pancetta."
        theDescriptionTextView = ReadMoreTextView()
        theDescriptionTextView.text = reviewText
        theDescriptionTextView.shouldTrim = true //If I don't use shouldTrim, then no table appears for some reason.
        theContentView.addSubview(theDescriptionTextView)
        theDescriptionTextView.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalTo(theContentView)
            let height: CGFloat = calculateReviewTextHeight(text: reviewText)
            make.height.equalTo(height)
        }
    }
    
    func calculateReviewTextHeight(text: String) -> CGFloat {
        let height = text.heightWithConstrainedWidth(width: self.frame.width, font: theDescriptionTextView.font ?? UIFont.systemFont(ofSize: UIFont.systemFontSize))
        let roundedHeight = height.rounded() + 1 //idk why, but for some reason, if I give a constraint with a decimal (i.e. 350.5) then it gets mad about the constraints
        return roundedHeight
    }
}

extension String {
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return boundingBox.height
    }
}
