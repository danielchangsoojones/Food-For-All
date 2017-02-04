//
//  EditingGigViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 2/4/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class EditingGigViewController: CreationViewController {
    var theButtonStackView: UIStackView!
    var theTableViewFooterView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateTableFooter()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func dataStoreSetup() {
        dataStore = EditingGigDataStore(delegate: self)
    }
    
    fileprivate func updateTableFooter() {
        theTableViewFooterView = UIView(frame: CGRect(x: 0, y: 0, w: self.view.frame.width, h: 100))
        stackViewSetup()
        theTableView.tableFooterView = theTableViewFooterView
    }
    
    fileprivate func stackViewSetup() {
        theButtonStackView = UIStackView()
        theButtonStackView.axis = .horizontal
        theButtonStackView.alignment = .center
        theButtonStackView.distribution = .equalCentering
        theButtonStackView.spacing = 10
        deleteButtonSetup()
        saveButtonSetup()
        theTableViewFooterView.addSubview(theButtonStackView)
        theButtonStackView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
    
    fileprivate func saveButtonSetup() {
        let saveButton: UIButton = Helpers.stylizeButton(text: "Save")
        saveButton.addTarget(self, action: #selector(save(sender:)), for: .touchUpInside)
        theButtonStackView.addArrangedSubview(saveButton)
    }
    
    fileprivate func deleteButtonSetup() {
        let deleteButton: UIButton = Helpers.stylizeButton(text: "Delete")
        deleteButton.setBackgroundColor(UIColor.red, forState: .normal)
        deleteButton.addTarget(self, action: #selector(delete(sender:)), for: .touchUpInside)
        theButtonStackView.addArrangedSubview(deleteButton)
    }
    
    func save(sender: UIButton) {
        dataStore?.save(gig: gig)
    }
    
    func delete(sender: UIButton) {
        if let dataStore = dataStore as? EditingGigDataStore {
            dataStore.delete(gig: gig)
        }
    }
}
