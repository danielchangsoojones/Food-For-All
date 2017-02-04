//
//  CircularImageView.swift
//  ChachaT
//
//  Created by Daniel Jones on 9/12/16.
//  Copyright © 2016 Chong500Productions. All rights reserved.
//

import Foundation
import UIKit

class CircularImageView: CircleView {
    var theImageView = UIImageView()
    
    init(file: AnyObject?, diameter: CGFloat) {
        let noVisibleImageColor : UIColor = CustomColors.Polar.withAlphaComponent(0.75)
        super.init(diameter: diameter, color: noVisibleImageColor)
        imageViewSetup(diameter)
        if let image = file as? UIImage {
            theImageView.image = image
        } else {
            theImageView.loadFromFile(file)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func imageViewSetup(_ diameter: CGFloat) {
        self.addSubview(theImageView)
        theImageView.snp.makeConstraints { (make) in
            make.center.equalTo(self)
            make.height.width.equalTo(diameter)
        }
    }
    
    func add(file: AnyObject) {
        theImageView.loadFromFile(file)
    }
    
    func update(image: UIImage) {
        theImageView.image = image
    }
}
