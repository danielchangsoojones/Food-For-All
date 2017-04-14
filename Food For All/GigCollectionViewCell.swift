//
//  GigCollectionViewCell.swift
//  Food For All
//
//  Created by Daniel Jones on 4/14/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import GlidingCollection

class GigCollectionViewCell: UICollectionViewCell {
    struct Constants {
        static let height: CGFloat = 280
        static let verticalSpacing: CGFloat = 5
        static let horizontalInset: CGFloat = 5
    }
    
    override var reuseIdentifier: String? {
        return GigCollectionViewCell.identifier
    }
    
    var theProfileImageView: UIImageView!
    var theNameLabel: UILabel!
    var theServiceLabel: UILabel!
    var thePriceLabel: UILabel!
    var theStarsView: MyCosmosView?
    var theDescriptionView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        profileImageSetup()
        descriptionViewSetup()
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.white
        //Need to use contentView corner radius, or if we use self.corner radius, then the shadow will not show
        contentView.layer.cornerRadius = 10
        addShadow()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setContents(gig: Gig) {
        theProfileImageView.loadFromFile(gig.frontImage ?? gig.creator.profileImage)
        toggleStars(avgStars: 5)
        theNameLabel.text = gig.creator.fullName
        theServiceLabel.text = gig.title
        thePriceLabel.text = gig.priceString
    }
    
    fileprivate func addShadow() {
        contentView.clipsToBounds = true
        
        let config = GlidingConfig.shared
        layer.shadowOffset = config.cardShadowOffset
        layer.shadowColor = config.cardShadowColor.cgColor
        layer.shadowOpacity = config.cardShadowOpacity
        layer.shadowRadius = config.cardShadowRadius
        
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
}

//view setup
extension GigCollectionViewCell {
    fileprivate func profileImageSetup() {
        theProfileImageView = UIImageView()
        theProfileImageView.contentMode = .scaleAspectFill
        theProfileImageView.clipsToBounds = true //so the image doesn't expand beyond the imageView
        contentView.addSubview(theProfileImageView)
        theProfileImageView.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(self.frame.width)
        }
    }
    
    fileprivate func descriptionViewSetup() {
        theDescriptionView = UIView()
        contentView.addSubview(theDescriptionView)
        theDescriptionView.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(theProfileImageView)
            make.top.equalTo(theProfileImageView.snp.bottom)
            make.bottom.equalToSuperview()
        }
        nameLabelSetup()
        serviceLabelSetup()
        priceLabelSetup()
    }
    
    fileprivate func nameLabelSetup() {
        theNameLabel = UILabel()
        theNameLabel.font = UIFont.systemFont(ofSize: 21, weight: UIFontWeightBold)
        theDescriptionView.addSubview(theNameLabel)
        theNameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(Constants.verticalSpacing)
            make.leading.trailing.equalToSuperview().inset(Constants.horizontalInset)
        }
    }
    
    fileprivate func serviceLabelSetup() {
        theServiceLabel = UILabel()
        theServiceLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightLight)
        theDescriptionView.addSubview(theServiceLabel)
        theServiceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(theNameLabel.snp.bottom).offset(Constants.verticalSpacing)
            make.leading.trailing.equalTo(theNameLabel)
        }
    }
    
    fileprivate func priceLabelSetup() {
        thePriceLabel = UILabel()
        thePriceLabel.font =  UIFont.systemFont(ofSize: 14, weight: UIFontWeightLight)
        thePriceLabel.textColor = CustomColors.JellyTeal
        theDescriptionView.addSubview(thePriceLabel)
        thePriceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(theServiceLabel.snp.bottom).offset(Constants.verticalSpacing)
            make.leading.trailing.equalTo(theNameLabel)
        }
    }
}

//stars view
extension GigCollectionViewCell {
    fileprivate func toggleStars(avgStars: Double) {
        if avgStars <= 0 {
            //have no rating
            theStarsView?.removeFromSuperview()
        } else {
            //has a rating
            starsViewSetup(avgStars: avgStars)
        }
    }
    
    private func starsViewSetup(avgStars: Double) {
        if theStarsView == nil {
            theStarsView = MyCosmosView(rating: avgStars)
            backgroundStarsBlurSetup()
        }
        
        if let starsView = theStarsView {
            starsView.rating = avgStars
            theProfileImageView.addSubview(starsView)
            starsView.snp.makeConstraints({ (make) in
                make.leading.equalToSuperview().inset(Constants.horizontalInset)
                make.bottom.equalToSuperview().inset(Constants.verticalSpacing)
            })
        }
    }
    
    private func backgroundStarsBlurSetup() {
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.4
        blurEffectView.frame = theStarsView?.bounds ?? CGRect.zero
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        theStarsView?.insertSubview(blurEffectView, at: 0)
    }
}

extension GigCollectionViewCell {
    static let identifier = "gigCollectionCell"
}
