//
//  PhotoDetailCollectionViewCell.swift
//  Food For All
//
//  Created by Daniel Jones on 2/18/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class PhotoDetailCollectionViewCell: UICollectionViewCell {
    var theImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageViewSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(file: Any?) {
        theImageView.loadFromFile(file as AnyObject?)
    }
    
    fileprivate func imageViewSetup() {
        theImageView = UIImageView()
        theImageView.contentMode = .scaleAspectFit
        theImageView.setCornerRadius(radius: 9)
        self.addSubview(theImageView)
        theImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

extension PhotoDetailCollectionViewCell {
    static var identifier: String {
        return "photoDetailCell"
    }
}
