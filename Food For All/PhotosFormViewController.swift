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
    
    var photos: [GigPhoto] = []
    var gig: Gig?
    
    var dataStore: PhotosFormDataStore = PhotosFormDataStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewSetup()
        self.view.backgroundColor = UIColor.white
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        gig?.photos = photos
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
        collectionView.backgroundColor = CustomColors.BombayGray.withAlphaComponent(0.22)
        registerCells()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.view.addSubview(collectionView)
    }
    
    fileprivate func registerCells() {
        collectionView.register(HintCollectionViewFooter.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: HintCollectionViewFooter.identifier)
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.cellIdentifier)
        collectionView.register(NewPhotoCollectionViewCell.self, forCellWithReuseIdentifier: NewPhotoCollectionViewCell.identifier)
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
        return photos.count + 1 //acount for initial creation cell
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell = UICollectionViewCell()
        if indexPath.row == 0 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewPhotoCollectionViewCell.identifier, for: indexPath) as! NewPhotoCollectionViewCell
        } else {
            let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.cellIdentifier, for: indexPath) as! PhotoCollectionViewCell
            let photo = photos[indexPath.row - 1] //acounting for the initial creation cell
            if let image = photo.smallImage {
                photoCell.update(image: image)
            }
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
        //Acount for the creation cell
        let toIndex = toIndexPath.row - 1
        let fromIndex = atIndexPath.row - 1
        let photo = photos.remove(at: fromIndex)
        photos.insert(photo, at: toIndex)
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

//collection footer
extension PhotosFormViewController {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: HintCollectionViewFooter.identifier, for: indexPath as IndexPath)
        return view
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
        //TODO: delete with datastore
        let index = at - 1 //Account for creation cell
        photos.remove(at: index)
        reloadCollection()
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
        if let gig = gig {
            let photo = GigPhoto(parent: gig)
            photo.position = 0
            photo.fullImage = image
            incrementPositions()
            photos.insertAsFirst(photo)
            reloadCollection()
        }
    }
    
    fileprivate func incrementPositions() {
        for photo in photos {
            photo.position += 1
        }
    }
    
    fileprivate func decrementPositions() {
        for photo in photos {
            photo.position -= 1
        }
    }
    
    func reloadCollection() {
        //reloading a single section gives a nice animation, and I only have 1 anyway
        collectionView.reloadSections(IndexSet(integer: 0))
    }
}
