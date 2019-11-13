//
//  ItemUser.swift
//  PrimeMarathiNews
//
//  Created by Shree Bhagwat on 31/10/19.
//  Copyright © 2019 Shree Bhagwat. All rights reserved.
//

import Foundation

class ItemUser {
    var id : String?
    var name : String?
    var email : String?
    var mobile : String?
    var dp : String?

    
    init(dictionary: [String: AnyObject]) {
        id = dictionary[kUSER_ID] as? String
        name = dictionary[kUSER_NAME] as? String
        email = dictionary[kUSER_EMAIL] as? String
        mobile = dictionary[kUSER_MOBILE] as? String
        dp = dictionary[kUSER_PROFILE] as? String
    }
}
