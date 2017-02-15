//
//  ForwardAccessoryView.swift
//  Food For All
//
//  Created by Daniel Jones on 1/16/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import UIKit

class ForwardAccessoryView: UIView {
    struct Constants {
        static let defaultHeight: CGFloat = 70
    }
    
    var theForwardButton: UIButton = UIButton()
    var theSpinner: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        forwardButtonSetup()
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        for subview in subviews {
            if subview.frame.contains(point) {
                return subview
            }
        }
        return nil
    }
    
    fileprivate func forwardButtonSetup() {
        theForwardButton.backgroundColor = UIColor.white
        let side: CGFloat = 40
        theForwardButton.layer.cornerRadius = side / 2
        theForwardButton.setImage(#imageLiteral(resourceName: "ArrowHead"), for: .normal)
        theForwardButton.setImage(UIImage(), for: .selected) //have no image on the selected state, so we can replace it with an UIActivityIndicator
        theForwardButton.imageView?.contentMode = .scaleAspectFit
        let inset = side * 0.25
        theForwardButton.imageEdgeInsets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        theForwardButton.clipsToBounds = true
        theForwardButton.alpha = 0.8
        self.addSubview(theForwardButton)
        theForwardButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(self).inset(WelcomeFormView.Constants.trailingInset)
            make.width.height.equalTo(side)
        }
        spinnerSetup()
    }
    
    fileprivate func spinnerSetup() {
        theForwardButton.addSubview(theSpinner)
        theSpinner.color = CustomColors.JellyTeal
        theSpinner.isHidden = true
        theSpinner.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(theForwardButton.frame.height * 0.05)
        }
    }
}
