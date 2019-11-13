//
//  ItemAbout.swift
//  PrimeMarathiNews
//
//  Created by Shree Bhagwat on 31/10/19.
//  Copyright © 2019 Shree Bhagwat. All rights reserved.
//

import Foundation

class ItemAbout {
    
    var app_name : String?
    var app_logo : String?
    var app_desc : String?
    var app_version : String?
    var author : String?
    var contact : String?
    var email : String?
    var website : String?
    var privacy : String?
    var developedBy : String?
    
    
    init(dictionary: [String: AnyObject]) {
        app_name = dictionary[kAPP_NAME] as? String
        app_logo = dictionary[kAPP_LOGO] as? String
        app_desc = dictionary[kAPP_DESC] as? String
        app_version = dictionary[kAPP_DESC] as? String
        author = dictionary[kAPP_AUTHOR] as? String
        contact = dictionary[kAPP_CONTACT] as? String
        email = dictionary[kAPP_EMAIL] as? String
        website = dictionary[kAPP_WEBSITE] as? String
        privacy = dictionary[kPRIVACY] as? String
        developedBy = dictionary[kDEVELOPED_BY] as? String
    }
}
