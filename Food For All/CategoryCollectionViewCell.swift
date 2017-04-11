//
//  CategoryCollectionViewCell.swift
//  Food For All
//
//  Created by Daniel Jones on 4/10/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import TagListView

class CategoryCollectionViewCell: UICollectionViewCell {
    struct TagProperties {
        static let tagFont: UIFont = UIFont.systemFont(ofSize: 16)
        static let paddingX: CGFloat = 14
    }
    
    override var reuseIdentifier: String? {
        return CategoryCollectionViewCell.identifier
    }
    
    var theTagListView: TagListView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        tagListViewSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCategory(title: String) {
        //TODO: Want to be able to just use a tagView and change its title, but it's not updating the size/title correctly, so this is the best hack to make it work.
        theTagListView.removeAllTags()
        theTagListView.addTag(title)
    }
    
    fileprivate func tagListViewSetup() {
        theTagListView = TagListView()
        let color = UIColor.white
        theTagListView.borderColor = UIColor.white
        theTagListView.borderWidth = 1
        theTagListView.textColor = color
        theTagListView.tagBackgroundColor = UIColor.clear
        theTagListView.paddingX = TagProperties.paddingX //adds horizontal padding on each side of text, so extends width of TagView, but keeps the text centered.
        theTagListView.paddingY = 10 //adds vertical padding on each side of text, so extends width of TagView, but keeps the text centered.
        theTagListView.textFont = TagProperties.tagFont
        theTagListView.alignment = .center
        theTagListView.cornerRadius = (TagProperties.tagFont.pointSize + theTagListView.paddingY * 2) / 2
        positionTagListView()
    }
    
    fileprivate func positionTagListView() {
        self.addSubview(theTagListView)
        theTagListView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
}

extension CategoryCollectionViewCell {
    static let identifier = "categoryCollectionCell"
}
