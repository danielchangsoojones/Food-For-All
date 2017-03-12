//
//  DetailView.swift
//  Food For All
//
//  Created by Daniel Jones on 1/25/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class DetailView: UIView {
    struct Constants {
        static let topViewHeight: CGFloat = 100
        static let spacing: CGFloat = 18
        static let sideInset: CGFloat = 10
        static let cellHeight: CGFloat = 70
    }
    
    var theTopView: UIView = UIView()
    var theTableView: UITableView!
    var theNameLabel: UILabel = UILabel()
    var theProfileImageView: CircularImageView!
    var theBottomView: UIView = UIView()
    var thePriceLabel: UILabel = UILabel()
    var theBookButton: UIButton = UIButton()
    var theExitButton: UIButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        topViewSetup()
        bottomViewSetup()
        tableViewSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//the top area
extension DetailView {
    fileprivate func topViewSetup() {
        theTopView.frame = CGRect(x: 0, y: 0, w: self.frame.width, h: Constants.topViewHeight)
        CustomColors.addGradient(colors: CustomColors.searchBarGradientColors, to: theTopView)
        self.addSubview(theTopView)
        theTopView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(Constants.topViewHeight)
        }
        profileImageSetup()
        exitButtonSetup()
        nameLabelSetup()
    }
    
    fileprivate func profileImageSetup() {
        theProfileImageView = CircularImageView(file: nil, diameter: Constants.topViewHeight * 0.75)
        theTopView.addSubview(theProfileImageView)
        theProfileImageView.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().inset(Constants.sideInset)
            make.centerY.equalToSuperview()
        }
    }
    
    fileprivate func nameLabelSetup() {
        theNameLabel.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightLight)
        theNameLabel.textColor = UIColor.white
        theTopView.addSubview(theNameLabel)
        theNameLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().inset(Constants.sideInset)
            make.trailing.equalTo(theProfileImageView.snp.leading)
            make.top.equalTo(theExitButton.snp.bottom).offset(10)
        }
    }
    
    fileprivate func exitButtonSetup() {
        theExitButton.setImage(#imageLiteral(resourceName: "X"), for: .normal)
        theTopView.addSubview(theExitButton)
        theExitButton.snp.makeConstraints { (make) in
            make.top.equalTo(theTopView).inset(10)
            make.leading.equalToSuperview().inset(Constants.sideInset)
        }
    }
}

//the tableView
extension DetailView {
    func tableViewSetup() {
        theTableView = UITableView()
        theTableView.separatorStyle = .none
        self.insertSubview(theTableView, at: 0)
        theTableView.snp.makeConstraints { (make) in
            make.top.equalTo(theTopView.snp.bottom)
            make.bottom.equalTo(theBottomView.snp.top)
            make.leading.trailing.equalToSuperview()
        }
    }
}

//the pricing view
extension DetailView {
    fileprivate func bottomViewSetup() {
        self.addSubview(theBottomView)
        let height: CGFloat = 70
        theBottomView.snp.makeConstraints { (make) in
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(height)
        }
        priceLabelSetup()
        bookButtonSetup()
        addLineToBottomView()
        theBottomView.backgroundColor = UIColor.white
    }
    
    fileprivate func priceLabelSetup() {
        thePriceLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightLight)
        theBottomView.addSubview(thePriceLabel)
        thePriceLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalTo(theNameLabel)
        }
    }
    
    fileprivate func bookButtonSetup() {
        theBookButton.setTitle("Book", for: .normal)
        let inset: CGFloat = 10
        theBookButton.contentEdgeInsets.left = inset
        theBookButton.contentEdgeInsets.right = inset
        theBookButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightLight)
        theBookButton.setTitleColor(UIColor.white, for: .normal)
        theBookButton.backgroundColor = CustomColors.AquamarineBlue
        theBookButton.layer.cornerRadius = 10
        theBottomView.addSubview(theBookButton)
        theBookButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(theProfileImageView)
            make.height.equalTo(theBottomView).multipliedBy(0.5)
        }
    }
    
    fileprivate func addLineToBottomView() {
        let line = Helpers.line
        theBottomView.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}
