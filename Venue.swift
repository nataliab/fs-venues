//
//  Venue.swift
//  FSVenues
//
//  Created by Natalia Bartol on 16/11/2015.
//  Copyright © 2015 Natalia Bartol. All rights reserved.
//

import Foundation

struct Venue {
    var name: String
    var url: String?
    var id: String
    let bestPhoto: FourSquarePhoto?
    
    init?(data: NSObject) {
        if let d = data as? NSDictionary{
            name = d["name"] as? String ?? ""
            url = d["url"] as? String
            id = d["id"]as? String ?? ""
            bestPhoto = FourSquarePhoto(data: d["bestPhoto"] as? NSDictionary)
        } else {
            return nil
        }
        
    }
    
}