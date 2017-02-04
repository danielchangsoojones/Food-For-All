//
//  PersonalFreelancersTableViewCell.swift
//  Food For All
//
//  Created by Daniel Jones on 2/3/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class PersonalFreelancersTableViewCell: FreelancersTableViewCell {
    var editButtonTapped: (() -> Void)? = nil
    
    override init(gig: Gig, height: CGFloat) {
        super.init(gig: gig, height: height)
        addEditButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func addEditButton() {
        let button = UIButton()
        button.setTitle("Edit", for: .normal)
        button.setTitleColor(CustomColors.JellyTeal, for: .normal)
        button.addTarget(self, action: #selector(editTapped), for: .touchUpInside)
        button.setContentHuggingPriority(1000, for: .horizontal)
        self.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.firstBaseline.equalTo(theTitleLabel)
            make.trailing.equalToSuperview().inset(5)
        }
        remakeTopLabelConstraints(to: button)
    }
    
    fileprivate func remakeTopLabelConstraints(to view: UIButton) {
        theTitleLabel.snp.makeConstraints { (make) in
            make.trailing.equalTo(view.snp.leading) // so they don't overlap if someone has very long name
        }
    }
    
    func editTapped() {
        _ = editButtonTapped
    }
}
