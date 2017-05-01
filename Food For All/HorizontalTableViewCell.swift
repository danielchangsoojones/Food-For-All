//
//  HorizontalTableViewCell.swift
//  Food For All
//
//  Created by Daniel Jones on 2/18/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class HorizontalTableViewCell: UITableViewCell {
    var theCollectionView: UICollectionView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        collectionViewSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func collectionViewSetup() {
        let layout = createCollectionViewFlowLayout()
        theCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        theCollectionView.backgroundColor = UIColor.clear
        theCollectionView.showsHorizontalScrollIndicator = false
        self.addSubview(theCollectionView)
        theCollectionView.snp.makeConstraints { (make) in
            make.trailing.leading.bottom.equalToSuperview()
            make.top.equalToSuperview()
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
}
