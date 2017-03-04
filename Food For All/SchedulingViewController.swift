//
//  SchedulingViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 2/27/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import Timepiece
import STPopup
import EZSwiftExtensions

class SchedulingViewController: UIViewController {
    struct Constants {
        static let numberOfSections: Int = 25
        static let customEventSection: Int = 1
        static let numberOfColumns: Int = 8 //show a week's worth
        static let borderColor: UIColor = UIColor.black
        static let borderWidth: CGFloat = 0.3
        static let calendarGrey: UIColor = UIColor(r: 33, g: 34, b: 36)
        static let alternateCalendarGrey: UIColor = UIColor(r: 40, g: 41, b: 43)
    }
    
    var theCollectionView: UICollectionView!
    
    var events: [CustomEvent] = [] {
        didSet {
            if let layout = theCollectionView.collectionViewLayout as? ScheduleCollectionViewLayout {
                layout.events = events
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = Constants.calendarGrey
        collectionViewSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func pressed(cell: UICollectionViewCell, indexPath: IndexPath) {
        if cell is EventCollectionViewCell {
            eventCellPressed(indexPath: indexPath)
        }
    }
}

extension SchedulingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionViewSetup() {
        let layout = ScheduleCollectionViewLayout()
        edgesForExtendedLayout = [] //for the top x sticky axis to be in the correct placement with a nav bar
        theCollectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        registerCells()
        theCollectionView.dataSource = self
        theCollectionView.delegate = self
        theCollectionView.backgroundColor = Constants.calendarGrey //grey color from vantage calender on App Store
        
        theCollectionView.isDirectionalLockEnabled = true
        theCollectionView.alwaysBounceVertical = true
        theCollectionView.alwaysBounceHorizontal = true
        theCollectionView.showsVerticalScrollIndicator = false
        theCollectionView.showsHorizontalScrollIndicator = false
        
        self.view.addSubview(theCollectionView)
    }
    
    fileprivate func registerCells() {
        theCollectionView.register(ScheduleCollectionViewCell.self, forCellWithReuseIdentifier: ScheduleCollectionViewCell.identifier)
        theCollectionView.register(HourUnitCollectionViewCell.self, forCellWithReuseIdentifier: HourUnitCollectionViewCell.identifier)
        theCollectionView.register(DateCollectionViewCell.self, forCellWithReuseIdentifier: DateCollectionViewCell.identifier)
        theCollectionView.register(EventCollectionViewCell.self, forCellWithReuseIdentifier: EventCollectionViewCell.identifier)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Constants.numberOfSections + Constants.customEventSection
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == Constants.numberOfSections {
            //custom event section
            return events.count
        }
        
        //calender grid items
        return Constants.numberOfColumns
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = indexPath.section
        let item = indexPath.item
        
        if section == collectionView.numberOfSections - 1 {
            //custom events section
            return createCustomEventCell(indexPath: indexPath)
        } else if item == 0 {
            //the sticky y axis hour unit cells
            let cell = createHourUnitCell(indexPath: indexPath, collectionView: collectionView)
            return cell
        } else if section == 0 {
            //the sticky top x axis to hold the dates
            return createDateCell(indexPath: indexPath)
        } else {
            // get a reference to our storyboard cell
            let cell = createScheduleCell(indexPath: indexPath)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            pressed(cell: cell, indexPath: indexPath)
        }
    }
}

//custom event cells
extension SchedulingViewController {
    fileprivate func createCustomEventCell(indexPath: IndexPath) -> EventCollectionViewCell {
        let cell = theCollectionView.dequeueReusableCell(withReuseIdentifier: EventCollectionViewCell.identifier, for: indexPath) as! EventCollectionViewCell
        let event = events[indexPath.row]
        let title = convertToString(event: event)
        cell.set(title: title)
        return cell
    }
    
    fileprivate func convertToString(event: CustomEvent) -> String {
        let format = "h:mm"
        let start = event.start.toString(format: format)
        let end = event.end.toString(format: format)
        return start + " - " + end
    }
    
    fileprivate func eventCellPressed(indexPath: IndexPath) {
        let event = events[indexPath.row]
        let popUpVC = CalendarPopUpViewController(start: event.start, end: event.end, delegate: self)
        let popUpController = STPopupController(rootViewController: popUpVC)
        popUpController.style = .bottomSheet
        popUpController.present(in: self)
    }
}

//the schedule cells
extension SchedulingViewController {
    fileprivate func createScheduleCell(indexPath: IndexPath) -> ScheduleCollectionViewCell {
        let cell = theCollectionView.dequeueReusableCell(withReuseIdentifier: ScheduleCollectionViewCell.identifier, for: indexPath) as! ScheduleCollectionViewCell
        setAlternatingBackground(cell: cell, indexPath: indexPath)
        
        return cell
    }
}

//the y axis of times
extension SchedulingViewController {
    fileprivate func createHourUnitCell(indexPath: IndexPath, collectionView: UICollectionView) -> HourUnitCollectionViewCell {
        let section = indexPath.section
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourUnitCollectionViewCell.identifier, for: indexPath) as! HourUnitCollectionViewCell
        
        if section > 0 && section != Constants.numberOfSections - 1 {
            //add times to any cells, but the top left corner cell, the first time cell and the last time cell. Trying to copy the look of Vantage calender on the App Store
            let timeString = convertNumToTime(num: section)
            cell.setTime(title: timeString)
        } else {
            cell.setTime(title: nil)
        }
        
        return cell
    }
    
    fileprivate func convertNumToTime(num: Int) -> String {
        var suffix: String = "Am"
        var numString: String = num.toString
        
        if num >= 12 {
            suffix = "Pm"
            if num > 12 {
                numString = (num - 12).toString
            }
        }
        
        return "\(numString) \(suffix)"
    }
}

//the top x axis of dates
extension SchedulingViewController {
    fileprivate func createDateCell(indexPath: IndexPath) -> DateCollectionViewCell {
        let cell = theCollectionView.dequeueReusableCell(withReuseIdentifier: DateCollectionViewCell.identifier, for: indexPath) as! DateCollectionViewCell
        let date = getDateFrom(item: indexPath.item)
        cell.set(day: date.day, weekDay: date.weekDay, month: date.month)
        
        setAlternatingBackground(cell: cell, indexPath: indexPath)
        return cell
    }
    
    fileprivate func setAlternatingBackground(cell: UICollectionViewCell, indexPath: IndexPath) {
        if indexPath.item % 2 == 0 {
            cell.backgroundColor = Constants.calendarGrey
        } else {
            cell.backgroundColor = Constants.alternateCalendarGrey
        }
    }
    
    fileprivate func getDateFrom(item: Int) -> (day: Int, weekDay: String, month: String) {
        let date = (Date() + (item - 1).day) ?? Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        
        let month = components.month ?? 0
        let day = components.day ?? 0
        
        let weekDayString: String = dayOfWeek(date: date)
        let monthName: String = DateFormatter().monthSymbols[month - 1]
        return (day, weekDayString, monthName)
    }
    
    func dayOfWeek(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date).capitalized 
    }
}

extension SchedulingViewController: CalendarPopUpDelegate {
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
            theCollectionView.reloadSections([selectedIndexPath.section])
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


