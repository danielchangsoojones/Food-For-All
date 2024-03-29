//
//  CustomerScheduleViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 3/4/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import STPopup

class CustomerScheduleViewController: SchedulingViewController {
    //need to hold the message helper in global variable because it is a long-running operation, so we don't want the variable to get disposed of when it is called in a function.
    var messageHelper: MessageHelper?

    override func viewDidLoad() {
        super.viewDidLoad()
        navBarSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func eventCellPressed(indexPath: IndexPath) {
        let event = events[indexPath.row]
        let popUpVC = CustomerPopUpViewController(start: event.start, end: event.end, gig: gig, delegate: self)
        let popUpController = STPopupController(rootViewController: popUpVC)
        popUpController.style = .bottomSheet
        popUpController.present(in: self)
    }
    
    fileprivate func navBarSetup() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "skip", style: .plain, target: self, action: #selector(skipPressed))
    }
    
    func skipPressed() {
        messageHelper = MessageHelper(currentVC: self, gig: self.gig)
        messageHelper?.send(type: .withoutTime)
    }
    
    override func registerCells() {
        super.registerCells()
        theCollectionView.register(EventCollectionViewCell.self, forCellWithReuseIdentifier: EventCollectionViewCell.identifier)
    }
    
    override func createCustomEventCell(indexPath: IndexPath) -> EventCollectionViewCell {
        let cell = theCollectionView.dequeueReusableCell(withReuseIdentifier: EventCollectionViewCell.identifier, for: indexPath) as! EventCollectionViewCell
        let event = events[indexPath.row]
        setTitleFor(event: event, cell: cell)
        return cell
    }
}

extension CustomerScheduleViewController: CustomerPopUpDelegate {
    func segueToMessage(time: String) {
        self.messageHelper = MessageHelper(currentVC: self, gig: self.gig)
        self.messageHelper?.send(type: .withTime, time: time)
    }
}
