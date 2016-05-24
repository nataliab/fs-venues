//
//  NSDictionaryExtensions.swift
//  AppleTart
//
//  Created by Evan Maloney on 7/28/15.
//  Copyright © 2015 Gilt Groupe. All rights reserved.
//

import Foundation

public extension NSDictionary
{
    
    private func requiredString(key: String)
        throws
        -> String
    {
        guard let val = self[key] as? String else {
            throw DateError.DataFormatError("Expected to find key named \"\(key)\" containing a String value")
        }
        return val
    }

    public func requiredRFC1123Date(key: String)
        throws
        -> NSDate
    {
        let dateStr = try requiredString(key)
        
        guard let date = dateStr.asDateRFC1123() else {
            throw DateError.DataFormatError("Expected to key named \"\(key)\" to contain a date in RFC 1123 format")
        }
        
        return date
    }

    public func requiredISO8601Date(key: String)
        throws
        -> NSDate
    {
        let dateStr = try requiredString(key)

        guard let date = dateStr.asDateISO8601() else {
            throw DateError.DataFormatError("Expected to key named \"\(key)\" to contain a date in ISO 8601 format")
        }

        return date
    }
}


public enum DateError: ErrorType
{
    /** A `DataTransactionError` that wraps a generic `ErrorType`. */
    case DataFormatError(String)
}
