//
//  FriendCollectionViewCell.swift
//  Food For All
//
//  Created by Daniel Jones on 2/16/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class FriendCollectionViewCell: UICollectionViewCell {
    var profileView: CircleProfileView?
    var friend: MutualFriend? {
        didSet {
            if let friend = friend {
                updateProfile(friend: friend)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addProfile()
    }
    
    static var reuseIdentifier: String = "friendCollectionViewCell"
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func addProfile() {
        profileView = CircleProfileView(frame: self.frame, name:"", imageFile: nil)
        if let profileView = profileView {
            self.addSubview(profileView)
            profileView.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
        }
    }
    
    fileprivate func updateProfile(friend: MutualFriend) {
        if let profileView = profileView {
            profileView.update(name: friend.firstName)
            profileView.update(image: friend.profileImage)
        }
    }
}
