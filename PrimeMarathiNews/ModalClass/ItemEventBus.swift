//
//  ItemEventBus.swift
//  PrimeMarathiNews
//
//  Created by Shree Bhagwat on 31/10/19.
//  Copyright © 2019 Shree Bhagwat. All rights reserved.
//

import Foundation

class ItemEventBus {
    var message : String?
    var pos : Int?
    var itemComment : ItemComment?
    
    init(dictionary: [String: AnyObject]) {
        message = dictionary["message"] as? String
        pos = dictionary["pos"] as? Int
        itemComment = dictionary["itemComment"] as? ItemComment
    }
}
