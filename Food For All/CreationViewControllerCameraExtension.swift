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
        Helpers.showNewPhotoChoices(vc: self)
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
            var image: UIImage = picture
            let divider: CGFloat = picture.size.width / 300 //how big we want the resized image to be
            if divider > 1 {
                image = Camera.resize(image: picture, targetSize: CGSize(width: picture.size.width / divider, height: picture.size.height / divider)) //resize the image if it is massive. divider > 1 because if it is a small image, then we don't want to resize it. Only big images.
            }
            
            theProfileCircleView.update(image: image)
            completions[0] = true //could break if we ever change position of the image circle
            gig.frontImage = image
            gig.fullSizeFrontImage = picture
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
