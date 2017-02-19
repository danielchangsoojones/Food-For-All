//
//  NewPhotoCollectionViewCell.swift
//  Food For All
//
//  Created by Daniel Jones on 2/18/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class NewPhotoCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.addBorder(width: 3, color: CustomColors.SilverChalice)
        plusImageSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func plusImageSetup() {
        let image = #imageLiteral(resourceName: "PlusSign")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        self.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
}

extension NewPhotoCollectionViewCell {
    static var identifier: String {
        return "newPhotoCollectionCell"
    }
}
