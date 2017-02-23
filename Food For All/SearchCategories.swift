//
//  SearchCategories.swift
//  Food For All
//
//  Created by Daniel Jones on 2/21/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation

enum SearchCategory: String {
    case tutoring = "Tutoring"
    case laundry = "Laundry"
    case haircuts = "Haircuts"
    case photography = "Photography"
    case other = "Other"
    
    static let all: [SearchCategory] = [.tutoring, .laundry, .haircuts, .photography, .other]
    static let allStrings: [String] = SearchCategory.all.map { (category: SearchCategory) -> String in
        return category.rawValue
    }
    
    var searchTips: [String] {
        switch self {
        case .tutoring:
            let subjects = ["M119", "K201", "M118", "A100", "Spanish", "K303", "S301", "A201", "K303", "C104", "G202"]
            return subjects.sorted { $0 < $1 } //alphabetize
        default:
            let arr = ["barber", "laundry", "headshots", "tutoring"]
            return arr.sorted { $0 < $1 }
        }
    }
}
