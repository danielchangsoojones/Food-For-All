//
//  GigCollectionViewCell.swift
//  Food For All
//
//  Created by Daniel Jones on 4/14/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class GigCollectionViewCell: UICollectionViewCell {
    override var reuseIdentifier: String? {
        return GigCollectionViewCell.identifier
    }
    
    var theProfileImageView: UIImageView!
    var theNameLabel: UILabel!
    var theServiceLabel: UILabel!
    var thePriceLabel: UILabel!
    var theStarsView: MyCosmosView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        profileImageSetup()
        self.backgroundColor = UIColor.green
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setContents(image: UIImage) {
        theProfileImageView.image = image
    }
    
    fileprivate func profileImageSetup() {
        theProfileImageView = UIImageView()
        theProfileImageView.contentMode = .scaleAspectFill
        self.addSubview(theProfileImageView)
        theProfileImageView.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(self.frame.width)
        }
    }
}

extension GigCollectionViewCell {
    static let identifier = "gigCollectionCell"
}
