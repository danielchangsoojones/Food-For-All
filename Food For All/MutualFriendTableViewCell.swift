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
    var theHeadingLabel: UILabel!
    
    init() {
        super.init(style: .default, reuseIdentifier: "mutualFriendCell")
        headingSetup()
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
    
    fileprivate func headingSetup() {
        theHeadingLabel = UILabel()
        theHeadingLabel.text = "Mutual Friends"
        theHeadingLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold)
        self.addSubview(theHeadingLabel)
        theHeadingLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().inset(DetailView.Constants.sideInset)
            make.top.equalToSuperview().offset(5)
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
        theCollectionView.backgroundColor = UIColor.clear
        theCollectionView.showsHorizontalScrollIndicator = false
        self.addSubview(theCollectionView)
        theCollectionView.snp.makeConstraints { (make) in
            make.trailing.leading.bottom.equalToSuperview()
            make.top.equalTo(theHeadingLabel.snp.bottom)
        }
    }
    
    fileprivate func createCollectionViewFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: DetailView.Constants.sideInset, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 80, height: 103)
        return layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FriendCollectionViewCell.reuseIdentifier, for: indexPath) as! FriendCollectionViewCell
        return cell
    }
}
