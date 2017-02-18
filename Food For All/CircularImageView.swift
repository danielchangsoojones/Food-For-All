//
//  CircularImageView.swift
//  ChachaT
//
//  Created by Daniel Jones on 9/12/16.
//  Copyright © 2016 Chong500Productions. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

class CircularImageView: CircleView {
    var theImageView = UIImageView()
    //downloader needs to be global variable, or else the function will deallocate it.
    let downloader = ImageDownloader()
    
    init(file: AnyObject?, diameter: CGFloat) {
        let noVisibleImageColor : UIColor = CustomColors.Polar.withAlphaComponent(0.75)
        super.init(diameter: diameter, color: noVisibleImageColor)
        imageViewSetup(diameter)
        update(file: file)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func imageViewSetup(_ diameter: CGFloat) {
        theImageView.contentMode = .scaleAspectFill
        self.addSubview(theImageView)
        theImageView.snp.makeConstraints { (make) in
            make.center.equalTo(self)
            make.height.width.equalTo(diameter)
        }
    }
    
    func update(file: AnyObject?) {
        if let image = file as? UIImage {
            update(image: image)
        } else if let url = file as? String {
            loadFrom(urlString: url)
        } else {
            add(file: file)
        }
    }
    
    func add(file: AnyObject?) {
        theImageView.loadFromFile(file)
    }
    
    func update(image: UIImage) {
        theImageView.image = image
    }
    
    func loadFrom(urlString: String) {
        if let url = URL(string: urlString) {
            let urlRequest = URLRequest(url: url)
            downloader.download(urlRequest) { response in
                if let image = response.result.value {
                    self.theImageView.image = image
                }
            }
        }
    }
}
