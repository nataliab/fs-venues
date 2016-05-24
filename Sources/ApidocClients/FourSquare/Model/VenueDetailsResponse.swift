//
//  VenueDetailsResponse.swift
//
//  Foursquare
//
//  Contains:
//  struct VenueDetailsResponse
//
//  Generated by SwiftPoet on 24/05/2016
//
//

import CleanroomDataTransactions
import Foundation

/**
    Venue details response
*/
public struct VenueDetailsResponse: JSONDataModel, BinaryDataModel {
    public let venue : Venue

    public func toJSON () -> ApidocJSONEncoderResult<AnyObject> {
        
        var resultJSON = [String : AnyObject]()
        switch venue.toJSON() {
            case .Succeeded(let json) :
            
                resultJSON["venue"] = json
            case .Failed :
            
                return .Failed(DataTransactionError.DataFormatError("Invalid Venue data"))
        }
        return .Succeeded(resultJSON)
    }

    /**
        :param:    payload
    */
    public init (payload : NSDictionary) throws {
        
        let venueJson = try payload.requiredDictionary("venue")
        let venue = try Venue(payload: venueJson)

        self.init( venue : venue )
    }

    /**
        :param:    venue
    */
    public init (venue : Venue) {
        
        self.venue = venue
    }

}