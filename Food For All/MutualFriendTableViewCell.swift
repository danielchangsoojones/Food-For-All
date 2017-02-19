//
//  MutualFriendTableViewCell.swift
//  Food For All
//
//  Created by Daniel Jones on 2/16/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class MutualFriendTableViewCell: HorizontalTableViewCell {
    var theHeadingLabel: UILabel!
    
    var mutualFriends: [MutualFriend] = [MutualFriend(firstName: "bododod", profileImage: #imageLiteral(resourceName: "FullStar"))]
    
    init(numOfFriends: Int) {
        super.init(frame: CGRect.zero, identifier: "mutualFriendCell")
        theCollectionView.delegate = self
        theCollectionView.dataSource = self
        headingSetup(numOfFriends: numOfFriends)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func headingSetup(numOfFriends: Int) {
        theHeadingLabel = UILabel()
        theHeadingLabel.text = "\(numOfFriends) Mutual Friends"
        theHeadingLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold)
        self.addSubview(theHeadingLabel)
        theHeadingLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().inset(DetailView.Constants.sideInset)
            make.top.equalToSuperview().offset(5)
        }
        updateCollectionViewConstraints()
    }
    
    fileprivate func updateCollectionViewConstraints() {
        theCollectionView.snp.remakeConstraints { (make) in
            make.top.equalTo(theHeadingLabel.snp.bottom)
        }
    }
}

//collection view
extension MutualFriendTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FriendCollectionViewCell.reuseIdentifier, for: indexPath) as! FriendCollectionViewCell
        cell.friend = MutualFriend(firstName: "bododod", profileImage: #imageLiteral(resourceName: "FullStar"))
        return cell
    }
}
