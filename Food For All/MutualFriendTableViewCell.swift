//
//  MutualFriendTableViewCell.swift
//  Food For All
//
//  Created by Daniel Jones on 2/16/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class MutualFriendTableViewCell: UITableViewCell {
    var theCollectionView: UICollectionView!
    
    init() {
        super.init(style: .default, reuseIdentifier: "mutualFriendCell")
        collectionViewSetup()
        bottomLineSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func bottomLineSetup() {
        let line = Helpers.line
        self.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(DetailView.Constants.sideInset)
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}

//collection view
extension MutualFriendTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    fileprivate func collectionViewSetup() {
        let layout = createCollectionViewFlowLayout()
        theCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        theCollectionView.register(FriendCollectionViewCell.self, forCellWithReuseIdentifier: FriendCollectionViewCell.reuseIdentifier)
        theCollectionView.delegate = self
        theCollectionView.dataSource = self
        self.addSubview(theCollectionView)
        theCollectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    fileprivate func createCollectionViewFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: self.frame.height, height: self.frame.height)
        return layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FriendCollectionViewCell.reuseIdentifier, for: indexPath) as! FriendCollectionViewCell
        return cell
    }
}
