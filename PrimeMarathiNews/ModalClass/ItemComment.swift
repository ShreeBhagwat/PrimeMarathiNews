//
//  ItemComment.swift
//  PrimeMarathiNews
//
//  Created by Shree Bhagwat on 31/10/19.
//  Copyright © 2019 Shree Bhagwat. All rights reserved.
//

import Foundation

class ItemComment {
    var id : String?
    var user_id : String?
    var user_name : String?
    var user_email : String?
    var comment_text : String?
    var dp : String?
    var date : String?
    
    
    init(dictionary: [String: AnyObject]) {
        id = dictionary[kCOMMENT_ID] as? String
        user_id = dictionary[kUSER_ID] as? String
        user_name = dictionary[kUSER_NAME] as? String
        user_email = dictionary[kUSER_EMAIL] as? String
        comment_text = dictionary[kCOMMENT_TEXT] as? String
        dp = dictionary[kUSER_PROFILE] as? String
        date = dictionary[kNEWS_DATE] as? String
    }
}
