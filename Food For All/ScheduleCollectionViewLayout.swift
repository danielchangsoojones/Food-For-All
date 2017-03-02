//
//  ScheduleCollectionViewLayout.swift
//  Food For All
//
//  Created by Daniel Jones on 2/27/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import EZSwiftExtensions

class ScheduleCollectionViewLayout: UICollectionViewLayout {
    
    let CELL_HEIGHT = 45.0
    var CELL_WIDTH: Double = 0
    var yAxisCellWidth: Double {
        return CELL_WIDTH / 2
    }
    
    var cellAttrsDictionary = Dictionary<IndexPath, UICollectionViewLayoutAttributes>()
    var contentSize = CGSize.zero
    
    // Used to determine if a data source update has occured.
    // Note: The data source would be responsible for updating
    // this value if an update was performed.
    var dataSourceDidUpdate = true
    
    override init() {
        super.init()
        CELL_WIDTH = Double(ez.screenWidth / 3.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var collectionViewContentSize: CGSize {
        return contentSize
    }
    
    override func prepare() {
        // Only update header cells.
        if !dataSourceDidUpdate {
            
            // Determine current content offsets.
            let xOffset = collectionView!.contentOffset.x
            let yOffset = collectionView!.contentOffset.y
            
            if collectionView!.numberOfSections > 0 {
                //subtracting one because the final custom event section is not calculated with this. Its cells get placed above the current grid.
                for section in 0..<collectionView!.numberOfSections-1 {
                    
                    // Confirm the section has items.
                    if collectionView!.numberOfItems(inSection: section) > 0 {
                        
                        // Update all items in the first row.
                        if section == 0 {
                            for item in 0...collectionView!.numberOfItems(inSection: section)-1 {
                                
                                // Build indexPath to get attributes from dictionary.
                                let indexPath = IndexPath(item: item, section: section)
                                
                                // Update y-position to follow user.
                                if let attrs = cellAttrsDictionary[indexPath] {
                                    var frame = attrs.frame
                                    
                                    // Also update x-position for corner cell.
                                    if item == 0 {
                                        frame.origin.x = xOffset
                                    }
                                    
                                    frame.origin.y = yOffset
                                    attrs.frame = frame
                                }
                                
                            }
                            
                            // For all other sections, we only need to update
                            // the x-position for the fist item.
                        } else {
                            
                            // Build indexPath to get attributes from dictionary.
                            let indexPath = IndexPath(item: 0, section: section)
                            
                            // Update y-position to follow user.
                            if let attrs = cellAttrsDictionary[indexPath] {
                                var frame = attrs.frame
                                frame.origin.x = xOffset
                                attrs.frame = frame
                            }
                            
                        }
                    }
                }
            }
            
            
            // Do not run attribute generation code
            // unless data source has been updated.
            return
        }
        
        // Acknowledge data source change, and disable for next time.
        dataSourceDidUpdate = false
        
        
        // Cycle through each section of the data source.
        if collectionView!.numberOfSections > 0 {
            for section in 0...collectionView!.numberOfSections-1 {
                
                // Cycle through each item in the section.
                if collectionView!.numberOfItems(inSection: section) > 0 {
                    for item in 0...collectionView!.numberOfItems(inSection: section)-1 {
                        
                        
                        // Build the UICollectionVieLayoutAttributes for the cell.
                        let cellIndex = IndexPath(item: item, section: section)
                        var cellWidth: Double = CELL_WIDTH
                        var xPos: Double = 0
                        var yPos = Double(section) * CELL_HEIGHT
                        
                        if section == collectionView!.numberOfSections - 1 {
                            //custom event items
                            let origin = getCustomEventOrigin(item: item)
                            xPos = Double(origin.x)
                            yPos = Double(origin.y)
                        } else if item == 0 {
                            //the y axis cells
                            cellWidth = yAxisCellWidth
                        } else {
                            //all other cells
                            xPos = Double(item) * CELL_WIDTH - yAxisCellWidth
                        }
        
                        
                        
                        let cellAttributes = UICollectionViewLayoutAttributes(forCellWith: cellIndex)
                        cellAttributes.frame = CGRect(x: xPos, y: yPos, width: cellWidth, height: CELL_HEIGHT)
                        
                        // Determine zIndex based on cell type.
                        if section == 0 && item == 0 {
                            //top left corner cell
                            cellAttributes.zIndex = 5
                        } else if section == 0 {
                            //y axis cells
                            cellAttributes.zIndex = 4
                        } else if item == 0 {
                            //top x axis cells
                            cellAttributes.zIndex = 3
                        } else if section == collectionView!.numberOfSections - 1 {
                            //custom event cells
                            cellAttributes.zIndex = 2
                        } else {
                            //all background schedule cells
                            cellAttributes.zIndex = 1
                        }
                        
                        // Save the attributes.
                        cellAttrsDictionary[cellIndex] = cellAttributes
                        
                    }
                }
            }
        }
        
        // Update content size.
        let contentWidth = Double(collectionView!.numberOfItems(inSection: 0) - 1) * CELL_WIDTH + yAxisCellWidth
        //sections - 1 because the custom event cells are not factored into the height, they go on top of the current grid system
        let contentHeight = Double(collectionView!.numberOfSections - 1) * CELL_HEIGHT
        self.contentSize = CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attribute = cellAttrsDictionary[indexPath]
        return attribute
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        // Create an array to hold all elements found in our current view.
        var attributesInRect = [UICollectionViewLayoutAttributes]()
        
        // Check each element to see if it should be returned.
        for cellAttributes in cellAttrsDictionary.values {
            if rect.intersects(cellAttributes.frame) {
                attributesInRect.append(cellAttributes)
            }
        }
        
        // Return list of elements.
        return attributesInRect
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}

extension ScheduleCollectionViewLayout {
    fileprivate func getCustomEventOrigin(item: Int) -> CGPoint {
        return CGPoint(x: 100, y: item * 100)
    }
}
