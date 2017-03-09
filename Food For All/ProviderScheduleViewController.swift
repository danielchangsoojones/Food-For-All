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
        let popUpVC = ProviderPopUpViewController(start: event.start, end: event.end, delegate: self)
        let popUpController = STPopupController(rootViewController: popUpVC)
        popUpController.style = .bottomSheet
        popUpController.present(in: self)
    }
    
    override func dataStoreSetup() {
        super.dataStoreSetup()
        providerDataStore = ProviderScheduleDataStore()
    }
    
    override func createDateCell(indexPath: IndexPath) -> DateCollectionViewCell {
        let cell = super.createDateCell(indexPath: indexPath)
        cell.theDayLabel.isHidden = true
        cell.theMonthLabel.isHidden = true
        return cell
    }
    
    override func dayOfWeek(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }
    
    override func registerCells() {
        super.registerCells()
        theCollectionView.register(EditableEventCollectionViewCell.self, forCellWithReuseIdentifier: EditableEventCollectionViewCell.editIdentifier)
    }
    
    override func createCustomEventCell(indexPath: IndexPath) -> EventCollectionViewCell {
        let cell = theCollectionView.dequeueReusableCell(withReuseIdentifier: EditableEventCollectionViewCell.editIdentifier, for: indexPath) as! EditableEventCollectionViewCell
        setPanAttributes(pan: cell.theUpPan)
        setPanAttributes(pan: cell.theDownPan)
        return cell
    }
}

extension ProviderScheduleViewController {
    fileprivate func scheduleCellPressed(indexPath: IndexPath) {
        let selectedHour = indexPath.section - 1 + Constants.startingTime//accounting for the top x axis as section 0
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

extension ProviderScheduleViewController: UIGestureRecognizerDelegate {
    func draggingCell(pan: UIPanGestureRecognizer) {
        if let handle = pan.view, let eventCell = handle.superview {
            if pan.state == .began || pan.state == .changed {
                animateCellChange(pan: pan, handle: handle, eventCell: eventCell)
            } else if pan.state == .ended {
                endHandleDragging(eventCell: eventCell)
            }
        }
    }
    
    fileprivate func animateCellChange(pan: UIPanGestureRecognizer, handle: UIView, eventCell: UIView) {
        UIView.animate(withDuration: 0.05, animations: {
            if let orientation = DragDirection(rawValue: handle.tag) {
                let translation = pan.translation(in: self.view)
                
                switch orientation {
                case .up:
                    eventCell.y += translation.y
                    eventCell.h += -translation.y
                case .down:
                    eventCell.h += translation.y
                }
                
                //the handlePan handler gets called repeatedly as the user moves their finger. By default the translation tells you how far you have moved since the touch started. Since we are using the gestureRecognizer to drag the view and we have already accounted for the translation, we set it back to zero so that the next time handlePan gets called it will report how far the touch has moved from the previous call to handlePan.
                pan.setTranslation(CGPoint.zero, in: self.view)
                
                //makes sure that all subviews of the cell update as we drag, without layoutIfNeeded, the subviews will move around while the cell is being dragged
                eventCell.layoutIfNeeded()
            }
        })
    }
    
    fileprivate func endHandleDragging(eventCell: UIView) {
        let targetMinY = self.getTarget(y: eventCell.frame.minY)
        let targetMaxY = self.getTarget(y: eventCell.frame.maxY)
        updateAndSaveEvent(eventCell: eventCell)
        //TODO: we want to inset the block by 1 because we don't want the cells running over the grid lines
        UIView.animate(withDuration: 0.5, animations: {
            let targetFrame = CGRect(x: eventCell.x, y: targetMinY, w: eventCell.w, h: targetMaxY - targetMinY)
            eventCell.frame = targetFrame
            eventCell.layoutIfNeeded()
        })
    }
    
    fileprivate func updateAndSaveEvent(eventCell: UIView) {
        if let eventCell = eventCell as? UICollectionViewCell, let indexPath = self.theCollectionView.indexPath(for: eventCell)  {
            let event = self.events[indexPath.item]
            let startTime = self.getTimeFrom(position: eventCell.frame.minY)
            event.start = event.start.changed(hour: startTime.hours, minute: startTime.minutes) ?? event.start
            let endTime = self.getTimeFrom(position: eventCell.frame.maxY)
            event.end = event.start.changed(hour: endTime.hours, minute: endTime.minutes) ?? event.end
            print(event.start)
            print(event.end)
        }
    }
    
    fileprivate func getTarget(y: CGFloat) -> CGFloat {
        let minute: CGFloat = CGFloat(ScheduleCollectionViewLayout.Constants.cellHeight / 60)
        let dragUnit: CGFloat = 15 * minute
        let surplus = y / dragUnit
        let targetY = surplus.rounded() * dragUnit
        return targetY
    }
    
    func getTimeFrom(position: CGFloat) -> (minutes: Int, hours: Int) {
        let hourUnit: CGFloat = CGFloat(ScheduleCollectionViewLayout.Constants.cellHeight)
        let minuteUnit: CGFloat = hourUnit / 60
        let hours: CGFloat = floor(position / hourUnit) + CGFloat(Constants.startingTime)
        let minutes = position.truncatingRemainder(dividingBy: hourUnit) / minuteUnit
        return (Int(minutes), Int(hours))
    }
    
    fileprivate func setPanAttributes(pan: UIPanGestureRecognizer) {
        pan.addTarget(self, action: #selector(draggingCell(pan:)))
        pan.delegate = self
    }
}

extension ProviderScheduleViewController: ProviderPopUpDelegate {
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
            providerDataStore?.delete(event: events[selectedIndexPath.row])
            events.remove(at: selectedIndexPath.row)
            layout.removeEventCell(at: selectedIndexPath)
            theCollectionView.reloadSections([theCollectionView.numberOfSections - 1])
        }
    }
}
