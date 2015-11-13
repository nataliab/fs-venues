//
//  VenueDetailsResponse.swift
//  FSVenues
//
//  Created by Natalia Bartol on 19/11/2015.
//  Copyright © 2015 Natalia Bartol. All rights reserved.
//
import Foundation

struct VenueDetailsResponse {
    let venue: Venue
    init?(data: NSObject) {
        if let v = ((data as? NSDictionary)?["response"] as? NSDictionary)!["venue"] as? NSObject {
            if let venue = Venue(data: v){
                self.venue = venue
            } else {
                return nil
            }
        } else {
            if let dict = data as? NSDictionary {
                print("Error in VenueDetailResponse:\(dict))")
            }
            return nil
        }
    }
}
