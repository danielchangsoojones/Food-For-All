//
//  BulletLabel.swift
//  Food For All
//
//  Created by Daniel Jones on 2/23/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class BulletLabel: UILabel {
    var sideInset: CGFloat = 0
    
    init(text: String) {
        super.init(frame: CGRect.zero)
        createBulletPoint(text: text)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func createBulletPoint(text: String) {
        let attributesDictionary = [NSFontAttributeName : UIFont.systemFont(ofSize: 35, weight: UIFontWeightThin)]
        let fullAttributedString = NSMutableAttributedString(string: "", attributes: attributesDictionary)
        
        let bulletPoint: String = "\u{2022}"
        let formattedString: String = "\(bulletPoint) \(text)\n"
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: formattedString)
        
        let paragraphStyle = createParagraphAttribute()
        attributedString.addAttributes([NSParagraphStyleAttributeName: paragraphStyle], range: NSMakeRange(0, attributedString.length))
        
        fullAttributedString.append(attributedString)
        
        self.attributedText = fullAttributedString
        self.textColor = UIColor.white
        self.numberOfLines = 0
    }
    
    func createParagraphAttribute() ->NSParagraphStyle {
        var paragraphStyle: NSMutableParagraphStyle
        paragraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.tabStops = [NSTextTab(textAlignment: .left, location: 15, options: NSDictionary() as! [String : AnyObject])]
        paragraphStyle.defaultTabInterval = 15
        paragraphStyle.firstLineHeadIndent = 0
        paragraphStyle.headIndent = 15
        
        return paragraphStyle
    }
}
