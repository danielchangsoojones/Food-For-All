//
//  CreationViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 2/1/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class CreationViewController: UIViewController {
    var theTableView: UITableView!
    var theCameraImageView: UIImageView!
    var theFinishButton: UIButton!
    var theProfileCircleView: CircularImageView!
    var theSpinnerView: UIView?
    
    var completions: [Bool] = [] //keeping track to make sure all mandatory cells are completed before continuing
    
    var gig: Gig = Gig()
    
    var dataStore: CreationDataStore?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        navBarSetup()
        populateCompletions()
        dataStoreSetup()
        setContent()
    }
    
    fileprivate func viewSetup() {
        let creationView = CreationView(frame: self.view.bounds)
        self.view = creationView
        theTableView = creationView.theTableView
        theTableView.delegate = self
        theTableView.dataSource = self
        theCameraImageView = creationView.theCameraImageView
        theProfileCircleView = creationView.theProfileCircleView
        theProfileCircleView.addTapGesture(target: self, action: #selector(profileCircleTapped(sender:)))
        theFinishButton = creationView.theFinishButton
        theFinishButton.addTarget(self, action: #selector(finishButtonTapped(sender:)), for: .touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func dataStoreSetup() {
        dataStore = CreationDataStore(delegate: self)
    }
    
    func populateCompletions() {
        let imageEntryCount = 1
        let itemsToComplete = imageEntryCount + Creation.count
        for _ in 0..<itemsToComplete {
            completions.append(false)
        }
    }
    
    func exitTapped() {
        self.navigationController?.dismissVC(completion: nil)
    }
    
    func finishedSaving(gig: Gig) {
        self.navigationController?.dismissVC(completion: nil)
    }
}

extension CreationViewController {
    func setContent() {
        if let gigPhotoFile = gig.frontImage {
            theProfileCircleView.add(file: gigPhotoFile)
            completions[0] = true
        } else if let profileImage = Person.current().profileImage {
            theProfileCircleView.add(file: profileImage)
            completions[0] = true
        }
    }
    
    func finishButtonTapped(sender: UIButton) {
        if !completions.contains(false) {
            //save and finish
            theSpinnerView = Helpers.showActivityIndicatory(uiView: self.view)
            dataStore?.save(gig: gig)
        } else if !completions[0] {
            //the gig picture hasn't been completed
            Helpers.showBanner(title: "No Picture", subtitle: "Please input a photo", bannerType: .error, duration: 5.0)
        } else {
            //incomplete fields
            //TODO: shake the fields that haven't been done yet and add red to them
            Helpers.showBanner(title: "Incomplete Fields", subtitle: "Please complete all necessary fields", bannerType: .error, duration: 5.0)
        }
    }
}

//nav controller
extension CreationViewController {
    fileprivate func navBarSetup() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "X"), style: .plain, target: self, action: #selector(exitTapped))
    }
}

extension CreationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Creation.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: CreationTableViewCell!
        if let creation: Creation = Creation(rawValue: indexPath.row) {
            switch creation {
            case .service:
                cell = CreationData().serviceCell
            case .pricing:
                cell = CreationData().pricingCell
            case .contact:
                cell = CreationData().contactCell
            }
        }
        
        setInitialContent(cell: cell, row: indexPath.row)
        return cell
    }
    
    fileprivate func setInitialContent(cell: CreationTableViewCell, row: Int) {
        if let creation = Creation(rawValue: row) {
            let title = CreationData.extractCellTitle(gig: gig, type: creation)
            let isComplete = CreationData.validateCompletion(gig: gig, type: creation)
            
            if let title = title {
                cell.theTitleLabel.text = title
            }
            toggle(shouldComplete: isComplete, for: cell, index: row)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var destinationVC = SuperCreationFormViewController()
        if let creation = Creation(rawValue: indexPath.row) {
            switch creation {
            case .service:
                destinationVC = CreationData().service.destinationVC
            case .pricing:
                destinationVC = CreationData().pricing.destinationVC
            case .contact:
                destinationVC = CreationData().contact.destinationVC
            }
        }
        
        destinationVC.delegate = self
        destinationVC.gig = self.gig
        pushVC(destinationVC)
    }
}

protocol CreationVCDelegate {
    func updateCell(title: String?, isComplete: Bool)
}

extension CreationViewController: CreationVCDelegate {
    func updateCell(title: String?, isComplete: Bool) {
        if let selectedIndexPath = theTableView.indexPathForSelectedRow, let previouslyTappedCell = theTableView.cellForRow(at: selectedIndexPath) as? CreationTableViewCell {
            let row = selectedIndexPath.row
            toggle(shouldComplete: isComplete, for: previouslyTappedCell, index: row)
            if let title = title {
                update(cellTitle: title, for: previouslyTappedCell)
            }
        }
    }
    
    fileprivate func toggle(shouldComplete: Bool, for cell: CreationTableViewCell, index: Int) {
        cell.theCompletionImageView.image = shouldComplete ? CreationTableViewCell.Constants.completedImage : CreationTableViewCell.Constants.uncompletedImage
        completions[index + 1] = shouldComplete //+1 to account for the photo entry view, which needs completion, but isn't a cell.
    }
    
    fileprivate func update(cellTitle: String, for cell: CreationTableViewCell) {
        cell.theTitleLabel.text = cellTitle
    }
}

extension CreationViewController: CreationDataStoreDelegate {
    func errorOccurred(description: String) {
        Helpers.showBanner(title: "Error", subtitle: description, bannerType: .error)
        theSpinnerView?.removeFromSuperview()
    }
}

