//
//  CustomerContractDataStore.swift
//  Food For All
//
//  Created by Daniel Jones on 4/26/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation

protocol CustomerContractDataStoreDelegate {
    func received(mutualFriends: [MutualFriend], totalCount: Int)
}

class CustomerContractDataStore {
    var delegate: CustomerContractDataStoreDelegate?
    
    init(delegate: CustomerContractDataStoreDelegate) {
        self.delegate = delegate
    }
}

extension CustomerContractDataStore: DetailDataStoreDelegate {
    func loadMutualFriends(targetUser: User) {
        let dataStore = DetailDataStore()
        dataStore.delegate = self
        dataStore.getMutualFriends(creator: targetUser)
    }
    
    func received(mutualFriends: [MutualFriend], totalCount: Int) {
        self.delegate?.received(mutualFriends: mutualFriends, totalCount: totalCount)
    }
}
