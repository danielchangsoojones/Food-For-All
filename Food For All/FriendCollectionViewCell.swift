//
//  FriendCollectionViewCell.swift
//  Food For All
//
//  Created by Daniel Jones on 2/16/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class FriendCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        addFriendProfile()
    }
    
    static var reuseIdentifier: String = "friendCollectionViewCell"
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func addFriendProfile() {
        let profileView = CircleProfileView(frame: self.frame, name: "Daniel", imageFile: Person.current().profileImage)
        self.addSubview(profileView)
        profileView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
