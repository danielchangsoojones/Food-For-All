//
//  PhotosFormViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 2/17/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import RAReorderableLayout

class PhotosFormViewController: UIViewController {
    
    var collectionView: UICollectionView!
    
    var imagesForSection0: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewSetup()
        
        for _ in 0..<18 {
            let image = #imageLiteral(resourceName: "EmptyStar")
            imagesForSection0.append(image)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.contentInset = UIEdgeInsetsMake(topLayoutGuide.length, 0, 0, 0)
    }
}

extension PhotosFormViewController: RAReorderableLayoutDelegate, RAReorderableLayoutDataSource {
    fileprivate func collectionViewSetup() {
        let layout = RAReorderableLayout()
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.cellIdentifier)
        collectionView.register(NewPhotoCollectionViewCell.self, forCellWithReuseIdentifier: NewPhotoCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.view.addSubview(collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let threePiecesWidth = floor(screenWidth / 3.0 - ((2.0 / 3) * 2))
        return CGSize(width: threePiecesWidth, height: threePiecesWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2.0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 2.0, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesForSection0.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell = UICollectionViewCell()
        if indexPath.row == 0 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewPhotoCollectionViewCell.identifier, for: indexPath) as! NewPhotoCollectionViewCell
        } else {
            let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.cellIdentifier, for: indexPath) as! PhotoCollectionViewCell
            photoCell.imageView.image = imagesForSection0[(indexPath as NSIndexPath).item]
            cell = photoCell
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, allowMoveAt indexPath: IndexPath) -> Bool {
        if collectionView.numberOfItems(inSection: (indexPath as NSIndexPath).section) <= 1 {
            return false
        } else if isCreationCell(row: indexPath.row) {
            return false
        }
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, at: IndexPath, canMoveTo: IndexPath) -> Bool {
        return !isCreationCell(row: canMoveTo.row)
    }
    
    fileprivate func isCreationCell(row: Int) -> Bool {
        return row == 0
    }
    
    func collectionView(_ collectionView: UICollectionView, at atIndexPath: IndexPath, didMoveTo toIndexPath: IndexPath) {
        let photo = imagesForSection0.remove(at: (atIndexPath as NSIndexPath).item)
        imagesForSection0.insert(photo, at: (toIndexPath as NSIndexPath).item)
    }
    
    func scrollTrigerEdgeInsetsInCollectionView(_ collectionView: UICollectionView) -> UIEdgeInsets {
        return UIEdgeInsetsMake(100.0, 100.0, 100.0, 100.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, reorderingItemAlphaInSection section: Int) -> CGFloat {
        return 0
    }
    
    func scrollTrigerPaddingInCollectionView(_ collectionView: UICollectionView) -> UIEdgeInsets {
        return UIEdgeInsetsMake(collectionView.contentInset.top, 0, collectionView.contentInset.bottom, 0)
    }
}

extension PhotosFormViewController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isCreationCell(row: indexPath.row) {
            Helpers.showNewPhotoChoices(vc: self, shouldCrop: true)
        } else {
            showExistingPhotoAlert(row: indexPath.row)
        }
    }
    
    fileprivate func showExistingPhotoAlert(row: Int) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (alertAction: UIAlertAction) in
            self.deletePhoto(at: row)
        }
        
        alert.addAction(deleteAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    fileprivate func deletePhoto(at: Int) {
        
    }
}

extension PhotosFormViewController:  UIImagePickerControllerDelegate, UINavigationControllerDelegate, CameraDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var picture = info[UIImagePickerControllerOriginalImage] as? UIImage
        if picture == nil {
            picture = info[UIImagePickerControllerEditedImage] as? UIImage
        } else if let picture = picture {
            var image: UIImage = picture
            let divider: CGFloat = picture.size.width / 300 //how big we want the resized image to be
            if divider > 1 {
                image = Camera.resize(image: picture, targetSize: CGSize(width: picture.size.width / divider, height: picture.size.height / divider)) //resize the image if it is massive. divider > 1 because if it is a small image, then we don't want to resize it. Only big images.
                print(image.size)
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imageWasPicked(image: UIImage) {
        print("successfully passed iamge")
    }
}
