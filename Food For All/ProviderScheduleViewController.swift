//
//  ProviderScheduleViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 3/4/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import Timepiece
import STPopup

class ProviderScheduleViewController: SchedulingViewController {
    var providerDataStore: ProviderScheduleDataStore?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func pressed(cell: UICollectionViewCell, indexPath: IndexPath) {
        super.pressed(cell: cell, indexPath: indexPath)
        if cell is ScheduleCollectionViewCell {
            scheduleCellPressed(indexPath: indexPath)
        }
    }
    
    override func eventCellPressed(indexPath: IndexPath) {
        let event = events[indexPath.row]
        let popUpVC = CalendarPopUpViewController(start: event.start, end: event.end, delegate: self)
        let popUpController = STPopupController(rootViewController: popUpVC)
        popUpController.style = .bottomSheet
        popUpController.present(in: self)
    }
    
    override func dataStoreSetup() {
        super.dataStoreSetup()
        providerDataStore = ProviderScheduleDataStore()
    }
}

extension ProviderScheduleViewController {
    fileprivate func scheduleCellPressed(indexPath: IndexPath) {
        let selectedHour = indexPath.section - 1 //accounting for the top x axis as section 0
        //acounting for the left y axis as item 0
        if let selectedDate: Date = Date() + (indexPath.row - 1).day {
            let startDate = Date(year: selectedDate.year, month: selectedDate.month, day: selectedDate.day, hour: selectedHour, minute: 0, second: 0, nanosecond: 0)
            let endDate: Date = (startDate + 1.hour) ?? startDate
            let event = CustomEvent(start: startDate, end: endDate)
            events.append(event)
            save(event: event)
        }
    }
    
    fileprivate func save(event: CustomEvent) {
        providerDataStore?.save(event: event)
        theCollectionView.reloadSections([theCollectionView.numberOfSections - 1])
    }
}

extension ProviderScheduleViewController: CalendarPopUpDelegate {
    func updateTime(start: Date?, end: Date?) {
        if let selectedIndexPath = theCollectionView.indexPathsForSelectedItems?.last, let layout = theCollectionView.collectionViewLayout as? ScheduleCollectionViewLayout {
            let event = events[selectedIndexPath.item]
            if let start = start {
                event.start = start
            }
            if let end = end {
                event.end = end
            }
            layout.updateEventCell(at: selectedIndexPath)
            save(event: event)
            let cell = theCollectionView.cellForItem(at: selectedIndexPath)
            cell?.isSelected = true
        }
    }
    
    func deleteEvent() {
        if let selectedIndexPath = theCollectionView.indexPathsForSelectedItems?.last, let layout = theCollectionView.collectionViewLayout as? ScheduleCollectionViewLayout {
            events.remove(at: selectedIndexPath.row)
            layout.removeEventCell(at: selectedIndexPath)
            theCollectionView.reloadSections([theCollectionView.numberOfSections - 1])
        }
    }
}
