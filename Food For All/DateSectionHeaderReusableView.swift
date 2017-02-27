//
//  DateSectionHeaderReusableView.swift
//  Food For All
//
//  Created by Daniel Jones on 2/27/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class DateSectionHeaderReusableView: UICollectionReusableView {
    override var reuseIdentifier: String? {
        return DateSectionHeaderReusableView.identifier
    }
}

extension DateSectionHeaderReusableView {
    static let identifier: String = "dateSectionHeader"
}
