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
        self.photos = photos
        theCollectionView.register(PhotoDetailCollectionViewCell.self, forCellWithReuseIdentifier: PhotoDetailCollectionViewCell.identifier)
        theCollectionView.delegate = self
        theCollectionView.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GigPhotosTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoDetailCollectionViewCell.identifier, for: indexPath) as! PhotoDetailCollectionViewCell
        if let file = photos[indexPath.row].smallImageFile {
            cell.update(file: file)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 120)
    }

}
