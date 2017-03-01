//
//  SchedulingViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 2/27/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import Timepiece

class SchedulingViewController: UIViewController {
    struct Constants {
        static let numberOfSections: Int = 25
        static let numberOfColumns: Int = 7 //show a week's worth
    }
    
    var theCollectionView: UICollectionView!
    
    var initialContentOffset: CGPoint = CGPoint.zero

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension SchedulingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionViewSetup() {
        let layout = ScheduleCollectionViewLayout()
        theCollectionView = ScheduleCollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        registerCells()
        theCollectionView.dataSource = self
        theCollectionView.delegate = self
        theCollectionView.backgroundColor = CustomColors.CalendarGrey //grey color from vantage calender on App Store
        
        theCollectionView.isDirectionalLockEnabled = true
        theCollectionView.alwaysBounceVertical = true
        theCollectionView.alwaysBounceHorizontal = true
        
        self.view.addSubview(theCollectionView)
    }
    
    fileprivate func registerCells() {
        theCollectionView.register(ScheduleCollectionViewCell.self, forCellWithReuseIdentifier: ScheduleCollectionViewCell.identifier)
        theCollectionView.register(HourUnitCollectionViewCell.self, forCellWithReuseIdentifier: HourUnitCollectionViewCell.identifier)
        theCollectionView.register(DateCollectionViewCell.self, forCellWithReuseIdentifier: DateCollectionViewCell.identifier)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Constants.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constants.numberOfColumns
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = indexPath.section
        let item = indexPath.item
        
        if item == 0 {
            //the sticky y axis hour unit cells
            let cell = createHourUnitCell(indexPath: indexPath, collectionView: collectionView)
            return cell
        } else if section == 0 {
            //the sticky top x axis to hold the dates
            return createDateCell(indexPath: indexPath)
        } else {
            // get a reference to our storyboard cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScheduleCollectionViewCell.identifier, for: indexPath) as! ScheduleCollectionViewCell
            
            // Use the outlet in our custom class to get a reference to the UILabel in the cell
            cell.label.text = "Sec \(indexPath.section)/Item \(indexPath.item)"
            
            return cell
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        initialContentOffset = scrollView.contentOffset
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.isDragging {
            let velocity = scrollView.panGestureRecognizer.velocity(in: scrollView)
            
            if abs(velocity.y) > abs(velocity.x) {
                scrollView.contentOffset = CGPoint(x: initialContentOffset.x, y: scrollView.contentOffset.y)
            } else if abs(velocity.x) > abs(velocity.y) {
                scrollView.contentOffset = CGPoint(x: scrollView.contentOffset.x, y: initialContentOffset.y)
            }
        }
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
        return cell
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


