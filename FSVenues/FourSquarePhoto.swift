//
//  FourSquarePhoto.swift
//  FSVenues
//
//  Created by Natalia Bartol on 19/11/2015.
//  Copyright © 2015 Natalia Bartol. All rights reserved.
//

import Foundation

struct FourSquarePhoto {
    var prefix: String?
    var suffix: String?
    var width: Int?
    var height: Int?
    
    init?(data: NSDictionary?) {
        if let d = data {
            prefix = d["prefix"] as? String
            suffix = d["suffix"] as? String
            width = d["width"] as? Int
            height = d["height"]as? Int
        } else {
            return nil
        }
    }
    
    func url() -> String? {
        if let p = prefix, s = suffix, w = width where width > 0{
            return "\(p)\(w)\(s)"
        } else {
            return nil
        }
    }
    
}
