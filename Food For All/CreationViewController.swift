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
    
    var cellDatas: [CellData] = CellData.creationCellDatas
    var completions: [Bool] = [] //keeping track to make sure all mandatory cells are completed before continuing
    
    var gig: Gig = Gig()
    
    var dataStore: CreationDataStore?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        navBarSetup()
        populateCompletions()
        dataStoreSetup()
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
    
    fileprivate func dataStoreSetup() {
        dataStore = CreationDataStore(delegate: self)
    }
    
    func populateCompletions() {
        let imageEntryCount = 1
        let itemsToComplete = imageEntryCount + cellDatas.count
        for _ in 0..<itemsToComplete {
            completions.append(false)
        }
    }
}

extension CreationViewController {
    func finishButtonTapped(sender: UIButton) {
        if !completions.contains(false) {
            //save and finish
            dataStore?.save(gig: gig)
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
    
    func exitTapped() {
        self.navigationController?.dismissVC(completion: nil)
    }
}

extension CreationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cellDatas[indexPath.row].cell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellData = cellDatas[indexPath.row]
        cellData.cell.selectionStyle = .none
        let destinationVC = cellData.destinationVC
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
        if let row = theTableView.indexPathForSelectedRow?.row {
            let previouslyTappedCell = cellDatas[row].cell
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
        print(description)
    }
    
    func finishedSaving(gig: Gig) {
        dump(gig)
    }
}

