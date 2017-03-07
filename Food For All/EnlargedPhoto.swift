//
//  EnlargedPhoto.swift
//  Food For All
//
//  Created by Daniel Jones on 2/21/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import NYTPhotoViewer
import Parse

protocol EnlargedPhotoDelegate {
    func loaded(photo: EnlargedPhoto)
}

class EnlargedPhoto: NSObject, NYTPhoto { 
    var image: UIImage?
    var imageData: Data?
    var placeholderImage: UIImage?
    let attributedCaptionTitle: NSAttributedString? = nil
    let attributedCaptionSummary: NSAttributedString? = nil
    let attributedCaptionCredit: NSAttributedString? = nil
    
    var delegate: EnlargedPhotoDelegate?
    
    init(file: Any?, delegate: EnlargedPhotoDelegate) {
        super.init()
        self.delegate = delegate
        load(file: file)
    }
    
    func set(file: Any?) {
        load(file: file)
    }
    
    fileprivate func load(file: Any?) {
        if let file = file as? PFFile {
            file.getDataInBackground { (data, error) in
                if let data = data {
                    self.imageData = data
                    self.delegate?.loaded(photo: self)
                } else if let error = error {
                    print(error)
                }
            }
        }
    }
}
