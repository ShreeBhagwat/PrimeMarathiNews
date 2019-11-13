//
//  ItemCat.swift
//  PrimeMarathiNews
//
//  Created by Shree Bhagwat on 31/10/19.
//  Copyright © 2019 Shree Bhagwat. All rights reserved.
//

import Foundation

class ItemCat {
    
    var id : String?
    var name : String?
    var image : String?
    var imageThumb : String?
    
    
    init(dictionary : [String: AnyObject]) {
        id =  dictionary[kCAT_ID] as? String
        name = dictionary[kCAT_NAME] as? String
        image = dictionary[kCAT_IMAGE] as? String
        imageThumb = dictionary[kCAT_IMAGE_THUMB] as? String
    }
}
