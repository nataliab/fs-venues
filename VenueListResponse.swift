//
//  VenueListResponse.swift
//  FSVenues
//
//  Created by Natalia Bartol on 16/11/2015.
//  Copyright © 2015 Natalia Bartol. All rights reserved.
//

import Foundation

struct VenueListResponse  {
    let venues: Array<Venue>
    
    init?(data: NSObject) {
        let venues = ((((data as? NSDictionary)?["response"] as? NSDictionary)?["groups"] as? NSArray)?.flatMap { group in
            ((group as? NSDictionary)!["items"] as? NSArray)?.flatMap{ item in
                Venue(data: ((item as? NSDictionary)!["venue"] as? NSObject)!)
            }
            }.flatMap{$0}
        )
        if let v = venues {
            self.venues = v
        } else {
            if let dict = (data as? NSDictionary) {
                print("Error in VenueListResponse:\(dict))")
            }
            return nil
        }
    }
}