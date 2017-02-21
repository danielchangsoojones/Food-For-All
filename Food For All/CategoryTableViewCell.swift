//
//  CategoryTableViewCell.swift
//  Food For All
//
//  Created by Daniel Jones on 2/20/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    var theButton: UIButton!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: CategoryTableViewCell.identifier)
        backgroundColor = UIColor.clear
        selectionStyle = .none
        createButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setButton(title: String) {
        theButton.setTitle(title, for: .normal)
    }
    
    private func createButton() {
        theButton = UIButton()
        theButton.isUserInteractionEnabled = false
        theButton.layer.cornerRadius = 25
//        let textColor = UIColor.white
//        let backgroundColor = UIColor.clear
        let textColor = CustomColors.JellyTeal
        let backgroundColor = UIColor.white
        theButton.addBorder(width: 2, color: textColor)
        theButton.setTitleColor(textColor, for: .normal)
        theButton.layer.borderColor = textColor.cgColor
        theButton.backgroundColor = backgroundColor
        self.addSubview(theButton)
        theButton.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
        }
    }

}

extension CategoryTableViewCell {
    static var identifier: String {
        return "categoryCell"
    }
    
    static var cellHeight: CGFloat {
        return 60
    }
}
