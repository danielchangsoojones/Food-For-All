//
//  Message.swift
//  Food For All
//
//  Created by Daniel Jones on 4/22/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation

class Message {
    var otherUser: User!
    var sender: User = User.current()!
    
    var contractParse: ContractParse = ContractParse()
    
    init() {}
}
