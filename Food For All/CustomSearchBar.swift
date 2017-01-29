//
//  CustomSearchBar.swift
//  Food For All
//
//  Created by Daniel Jones on 1/28/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class CustomSearchBar: UISearchBar {
    override var placeholder: String? {
        didSet {
            changePlaceholderColor(str: placeholder ?? "")
        }
    }
    
    var searchBarView: UIView {
        return subviews[0]
    }
    
    init() {
        super.init(frame: CGRect.zero)
        changeTextField()
        makeTransparent()
        hideMagnifyingGlass()
        tintColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func changeTextField() {
        if let textField = getSearchTextField() {
            textField.textColor = UIColor.white
            textField.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightBold)
        }
    }
    
    fileprivate func changePlaceholderColor(str: String) {
        if let textField = getSearchTextField() {
            let leftAlignedPlaceholder = alignPlaceholderToLeft(placeholder: str)
            textField.attributedPlaceholder = NSAttributedString(string: leftAlignedPlaceholder, attributes: [NSForegroundColorAttributeName : UIColor.white.withAlphaComponent(0.5)])
        }
    }
    
    fileprivate func hideMagnifyingGlass() {
        if let textField = getSearchTextField() {
           textField.leftViewMode = .never
        }
    }
    
    fileprivate func makeTransparent() {
        if let textField = getSearchTextField() {
            textField.backgroundColor = UIColor.clear
        }
        if let index = indexOfBackgroundViewInSubviews() {
            let backgroundView = searchBarView.subviews[index]
            backgroundView.alpha = 0
        }
    }
    
    //Purpose: returns the index for the textFieldView of the searchBar
    func getSearchTextField() -> UITextField? {
        //This is very hacky and could break whenever apple changes their code
        if let textFieldInsideSearchBar = value(forKey: "searchField") as? UITextField {
            return textFieldInsideSearchBar
        }
        return nil
    }
    
    //Purpose: returns the index for the textFieldView of the searchBar
    func indexOfBackgroundViewInSubviews() -> Int? {
        var index: Int?
        
        for i in 0 ..< searchBarView.subviews.count {
            if searchBarView.subviews[i].isKind(of: UIView.self) {
                //this should find the background view, but if apple changes UISearchBar class, then this code could break
                index = i
                break
            }
        }
        return index
    }
    
    func alignPlaceholderToLeft(placeholder: String) -> String {
        //As hacky as it is, using spaces to align the placeholder to the left is the best way I could find.
        var spaceString: String = " "
        for _ in 1...100 {
            spaceString += " "
        }
        return placeholder + spaceString
    }
}
