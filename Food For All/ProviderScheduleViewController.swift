//
//  ProviderScheduleViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 3/4/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import Timepiece

class ProviderScheduleViewController: SchedulingViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        super.collectionView(collectionView, didSelectItemAt: indexPath)
//        if let cell = collectionView.cellForItem(at: indexPath) {
//            if cell is ScheduleCollectionViewCell {
//                scheduleCellPressed(indexPath: indexPath)
//            }
//        }
//    }

}

extension ProviderScheduleViewController {
//    fileprivate func scheduleCellPressed(indexPath: IndexPath) {
//        let selectedHour = indexPath.section - 1 //accounting for the top x axis as section 0
//        //acounting for the left y axis as item 0
//        if let selectedDate: Date = Date() + (indexPath.row - 1).day {
//            let startDate = Date(year: selectedDate.year, month: selectedDate.month, day: selectedDate.day, hour: selectedHour, minute: 0, second: 0, nanosecond: 0)
//            let endDate: Date = (startDate + 1.hour) ?? startDate
//            let event = CustomEvent(start: startDate, end: endDate)
//            events.append(event)
//            theCollectionView.reloadSections([theCollectionView.numberOfSections - 1])
//        }
//    }
}
