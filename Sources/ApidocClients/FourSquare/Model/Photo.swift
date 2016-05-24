//
//  Photo.swift
//
//  Foursquare
//
//  Contains:
//  struct Photo
//
//  Generated by SwiftPoet on 24/05/2016
//
//

import CleanroomDataTransactions
import Foundation

/**
    Photo of venues
*/
public struct Photo: JSONDataModel, BinaryDataModel {
    public let _prefix : String
    public let suffix : String
    public let width : Int
    public let height : Int

    public func toJSON () -> ApidocJSONEncoderResult<AnyObject> {
        
        var resultJSON = [String : AnyObject]()
        resultJSON["prefix"] = _prefix
        resultJSON["suffix"] = suffix
        resultJSON["width"] = width
        resultJSON["height"] = height
        return .Succeeded(resultJSON)
    }

    /**
        :param:    payload
    */
    public init (payload : NSDictionary) throws {
        
        let _prefix = try payload.requiredString("prefix")
        let suffix = try payload.requiredString("suffix")
        let width = try payload.requiredInt("width")
        let height = try payload.requiredInt("height")

        self.init( _prefix : _prefix, suffix : suffix, width : width, height : height )
    }

    /**
        :param:    _prefix

        :param:    suffix

        :param:    width

        :param:    height
    */
    public init (_prefix : String, suffix : String, width : Int, height : Int) {
        
        self._prefix = _prefix
        self.suffix = suffix
        self.width = width
        self.height = height
    }

}