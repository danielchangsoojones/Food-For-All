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
    var theCollectionView: UICollectionView!
    
    var initialContentOffset: CGPoint = CGPoint.zero

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        let layout = ScheduleCollectionViewLayout()
        theCollectionView = ScheduleCollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        theCollectionView.register(ScheduleCollectionViewCell.self, forCellWithReuseIdentifier: ScheduleCollectionViewCell.identifier)
        theCollectionView.dataSource = self
        theCollectionView.delegate = self
        theCollectionView.backgroundColor = UIColor.red
        
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
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScheduleCollectionViewCell.identifier, for: indexPath) as! ScheduleCollectionViewCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        cell.label.text = "Sec \(indexPath.section)/Item \(indexPath.item)"
        
        return cell
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
