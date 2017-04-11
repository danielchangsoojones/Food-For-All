//
//  EmptyState.swift
//  Food For All
//
//  Created by Daniel Jones on 4/8/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import UIKit

struct EmptyState {
    static func showEmptyGigsView(tableView: UITableView, currentVC: UIViewController, action: Selector) {
        let emptyView = EmptyGigsView(frame: tableView.frame)
        emptyView.theCreateButton.addTarget(currentVC, action: action, for: .touchUpInside)
        tableView.backgroundView = emptyView
    }
}
