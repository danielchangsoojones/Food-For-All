//
//  FreelancerContractView.swift
//  Food For All
//
//  Created by Daniel Jones on 4/26/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class FreelancerContractView: ContractView {
    var theFooterView: UIView!
    var theDeleteButtonView: UIView!
    var theCompleteButtonView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        footerViewSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func footerViewSetup() {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, w: self.frame.width, h: 100))
        stackViewSetup(footerView: footerView)
        theTableView.tableFooterView = footerView
    }
    
    fileprivate func stackViewSetup(footerView: UIView) {
        let rect = CGRect(x: 0, y: 0, w: 50, h: 70)
        
        //change color of x for the delete button
        let xImage = #imageLiteral(resourceName: "X").withRenderingMode(.alwaysTemplate)
        let view = BottomLabelButtonView(frame: rect, buttonImage: xImage, title: "Delete")
        view.theButton.tintColor = CustomColors.BombayGray
        theDeleteButtonView = view
        
        theCompleteButtonView = BottomLabelButtonView(frame: rect, buttonImage: #imageLiteral(resourceName: "Checkmark"), title: "Completed")
        
        let stackView = UIStackView(arrangedSubviews: [theDeleteButtonView, theCompleteButtonView])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        stackView.spacing = 50
        footerView.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
}

