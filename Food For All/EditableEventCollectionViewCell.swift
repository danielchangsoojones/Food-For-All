//
//  EditableEventCollectionViewCell.swift
//  Food For All
//
//  Created by Daniel Jones on 3/8/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

enum DragDirection: Int {
    case up
    case down
}

class EditableEventCollectionViewCell: EventCollectionViewCell {
    override var reuseIdentifier: String? {
        return EditableEventCollectionViewCell.editIdentifier
    }
    
    var theUpDragHandle: UIImageView!
    var theDownDragHandle: UIImageView!
    var theUpPan: UIPanGestureRecognizer!
    var theDownPan: UIPanGestureRecognizer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        theLabel.isHidden = true
//        theLabel.alpha = 0
        setUpDragHandle()
        setDownDragHandle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func toggleHandles(hide: Bool, duration: CGFloat = 0.5) {
        theUpDragHandle.isHidden = false
        theDownDragHandle.isHidden = false
        theLabel.isHidden = false
        UIView.animate(withDuration: TimeInterval(duration), animations: {
            self.theUpDragHandle.alpha = hide ? 0 : 1
            self.theDownDragHandle.alpha = hide ? 0 : 1
            self.theLabel.alpha = hide ? 1 : 0
        }, completion: { _ in
            self.theUpDragHandle.isHidden = hide
            self.theDownDragHandle.isHidden = hide
            self.theLabel.isHidden = !hide
        })
    }
    
    fileprivate func setUpDragHandle() {
        theUpDragHandle = createDragHandle()
        setPosition(handle: theUpDragHandle, rotation: -CGFloat.pi / 2)
        let pan = UIPanGestureRecognizer()
        theUpDragHandle.addGestureRecognizer(pan)
        theUpPan = pan
        theUpDragHandle.tag = DragDirection.up.rawValue
        theUpDragHandle.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().inset(Constants.inset)
        }
    }
    
    fileprivate func setDownDragHandle() {
        theDownDragHandle = createDragHandle()
        setPosition(handle: theDownDragHandle, rotation: CGFloat.pi / 2)
        let pan = UIPanGestureRecognizer()
        theDownDragHandle.addGestureRecognizer(pan)
        theDownPan = pan
        theDownDragHandle.tag = DragDirection.down.rawValue
        theDownDragHandle.snp.makeConstraints { (make) in
            make.bottom.trailing.equalToSuperview().inset(Constants.inset)
        }
    }
    
    fileprivate func setPosition(handle: UIImageView, rotation: CGFloat) {
        handle.transform = handle.transform.rotated(by: rotation)
        self.addSubview(handle)
        handle.snp.makeConstraints { (make) in
            make.height.width.equalTo(10)
        }
    }
    
    fileprivate func createDragHandle() -> UIImageView {
        let image = #imageLiteral(resourceName: "ArrowHead").withRenderingMode(.alwaysTemplate)
        let handle = UIImageView(image: image)
        handle.contentMode = .scaleAspectFit
        handle.image = image
        handle.tintColor = UIColor.white
        handle.isUserInteractionEnabled = true
        handle.isHidden = true
        handle.alpha = 0 //so we can animate it's appearance
        return handle
    }
}

extension EditableEventCollectionViewCell {
    static let editIdentifier: String = "editableEventCollectionCell"
}
