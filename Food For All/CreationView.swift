//
//  CreationView.swift
//  Food For All
//
//  Created by Daniel Jones on 2/1/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class CreationView: UIView {
    var theTableView: UITableView = UITableView()
    var thePhotoEntryView: UIView = UIView()
    var theCameraImageView: UIImageView!
    var theFinishButton: UIButton = UIButton()
    var theProfileCircleView: CircularImageView!
    var footerView: UIView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        gradientSetup()
        tableViewSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func gradientSetup() {
        let start: CGPoint = CGPoint(x: 0.3, y: 0.3)
        let end: CGPoint = CGPoint(x: 1.0, y: 1.0)
        CustomColors.addGradient(colors: CustomColors.creationGradientColors, to: self, startPoint: start, endPoint: end)
    }
}

//static tableView extension
extension CreationView {
    fileprivate func tableViewSetup() {
        theTableView.separatorStyle = .none
        theTableView.backgroundColor = UIColor.clear
        
        self.addSubview(theTableView)
        theTableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        footerViewSetup()
        headerViewSetup()
    }
    
    fileprivate func headerViewSetup() {
        thePhotoEntryView.frame = CGRect(x: 0, y: 0, w: self.frame.width, h: 200)
        circularImageViewSetup(diameter: thePhotoEntryView.frame.height)
        theTableView.tableHeaderView = thePhotoEntryView
    }
    
    fileprivate func circularImageViewSetup(diameter: CGFloat) {
        theProfileCircleView = CircularImageView(file: nil, diameter: diameter * 0.75)
        theProfileCircleView.backgroundColor = CustomColors.Polar
        addCameraImage(to: theProfileCircleView)
        thePhotoEntryView.addSubview(theProfileCircleView)
        theProfileCircleView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
    
    fileprivate func addCameraImage(to view: UIView) {
        theCameraImageView = UIImageView(image: #imageLiteral(resourceName: "Camera"))
        theCameraImageView.contentMode = .scaleAspectFit
        if let circularImageView = view as? CircularImageView {
            circularImageView.insertSubview(theCameraImageView, belowSubview: circularImageView.theImageView)
            theCameraImageView.snp.makeConstraints { (make) in
                make.center.equalToSuperview()
            }
        }
    }
}

extension CreationView {
    fileprivate func footerViewSetup() {
        footerView.frame = CGRect(x: 0, y: 0, w: self.frame.width, h: 100)
        finishButtonSetup()
        theTableView.tableFooterView = footerView
    }
    
    fileprivate func finishButtonSetup() {
        theFinishButton = Helpers.stylizeButton(text: "Finish")
        footerView.addSubview(theFinishButton)
        theFinishButton.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
}
