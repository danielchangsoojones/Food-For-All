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
    
    var cells: [UITableViewCell] = CellData.creationCells
    var completions: [Bool] = [] //keeping track to make sure all mandatory cells are completed before continuing
    
    var gig: Gig = Gig()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        navBarSetup()
        populateCompletions()
    }
    
    fileprivate func viewSetup() {
        let creationView = CreationView(frame: self.view.bounds)
        self.view = creationView
        theTableView = creationView.theTableView
        theTableView.delegate = self
        theTableView.dataSource = self
        theCameraImageView = creationView.theCameraImageView
        theFinishButton = creationView.theFinishButton
        theFinishButton.addTarget(self, action: #selector(finishButtonTapped(sender:)), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(gig.description)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func populateCompletions() {
        let imageEntryCount = 1
        let itemsToComplete = imageEntryCount + cells.count
        for _ in 0...itemsToComplete {
            completions.append(false)
        }
    }
}

extension CreationViewController {
    func finishButtonTapped(sender: UIButton) {
        if !completions.contains(false) {
            //save and finish
        } else {
            //incomplete fields
            //TODO: shake the fields that haven't been done yet and add red to them
            Helpers.showBanner(title: "Incomplete Fields", subtitle: "Please complete all necessary fields", bannerType: .error)
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
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cells[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destinationVC = ServiceFormViewController()
        destinationVC.gig = self.gig
        pushVC(destinationVC)
    }
}

protocol CreationVCDelegate {
    func updateCell(title: String, isComplete: Bool)
}

extension CreationViewController: CreationVCDelegate {
    func updateCell(title: String, isComplete: Bool) {
        if let row = theTableView.indexPathForSelectedRow?.row, let previouslyTappedCell = cells[row] as? CreationTableViewCell {
            toggle(shouldComplete: isComplete, for: previouslyTappedCell, index: row)
            update(cellTitle: title, for: previouslyTappedCell)
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
