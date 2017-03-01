//
//  SchedulingViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 2/27/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import EZSwiftExtensions

class SchedulingViewController: UIViewController {
    struct Constants {
        static let numberOfSections: Int = 25
    }
    
    var theCollectionView: UICollectionView!
    
    var initialContentOffset: CGPoint = CGPoint.zero

    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = ScheduleCollectionViewLayout()
        theCollectionView = ScheduleCollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        theCollectionView.register(ScheduleCollectionViewCell.self, forCellWithReuseIdentifier: ScheduleCollectionViewCell.identifier)
        theCollectionView.register(HourUnitCollectionViewCell.self, forCellWithReuseIdentifier: HourUnitCollectionViewCell.identifier)
        theCollectionView.dataSource = self
        theCollectionView.delegate = self
        theCollectionView.backgroundColor = UIColor(r: 33, g: 34, b: 36)
        
        theCollectionView.isDirectionalLockEnabled = true
        theCollectionView.alwaysBounceVertical = true
        theCollectionView.alwaysBounceHorizontal = true
        self.view.addSubview(theCollectionView)
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
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Constants.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let section = indexPath.section
        let item = indexPath.item
        
        if item == 0 {
            //the y axis hour unit cells
            let cell = createHourUnitCell(indexPath: indexPath, collectionView: collectionView)
            return cell
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


