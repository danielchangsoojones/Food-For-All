//
//  CreationViewControllerCameraExtension.swift
//  Food For All
//
//  Created by Daniel Jones on 2/3/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import UIKit

extension CreationViewController {
    func showNewPhotoChoices() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { (alertAction: UIAlertAction) in
            _ = Camera.shouldStartPhotoLibrary(target: self, canEdit: false)
        }
        
        let cameraAction = UIAlertAction(title: "Take Photo", style: .default) { (alertAction: UIAlertAction) in
            //If you are on mac simulator, then the camera crashes because mac doesn't have a camera on simulator, only photo library.
            _ = Camera.shouldStartCamera(target: self, canEdit: false, frontFacing: true)
        }
        
        alert.addAction(photoLibraryAction)
        alert.addAction(cameraAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    func profileCircleTapped(sender: UIView) {
        showNewPhotoChoices()
    }
}

// MARK: - UIImagePickerControllerDelegate
extension CreationViewController:  UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var picture = info[UIImagePickerControllerOriginalImage] as? UIImage
        if picture == nil {
            picture = info[UIImagePickerControllerEditedImage] as? UIImage
        } else if let picture = picture {
            let resizedImage = Camera.resize(image: picture, targetSize: CGSize(width: picture.size.width / 8, height: picture.size.height / 8))
            theProfileCircleView.update(image: resizedImage)
            completions[0] = true //could break if we ever change position of the image circle
            print(resizedImage.size)
            gig.frontImage = resizedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
