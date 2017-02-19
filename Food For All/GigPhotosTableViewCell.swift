//
//  GigPhotoTableViewCell.swift
//  Food For All
//
//  Created by Daniel Jones on 2/18/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class GigPhotosTableViewCell: HorizontalTableViewCell {
    var photos: [GigPhoto] = []
    
    init(photos: [GigPhoto]) {
        super.init(frame: CGRect.zero, identifier: "gigPhotosCell")
        theCollectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.cellIdentifier)
        theCollectionView.delegate = self
        theCollectionView.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GigPhotosTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return photos.count
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.cellIdentifier, for: indexPath) as! PhotoCollectionViewCell
//        if let file = photos[indexPath.row].smallImageFile {
//            cell.update(file: file)
//        }
        
        
        
        //Testing Purposes
        cell.update(image: #imageLiteral(resourceName: "FullStar"))
        
        
        
        
        return cell
    }
}
