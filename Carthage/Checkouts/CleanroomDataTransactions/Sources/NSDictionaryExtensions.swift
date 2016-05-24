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
    public func required(key: String)
        throws
        -> Any
    {
        guard let val = self[key] else {
            throw DataTransactionError.DataFormatError("Expected to find key named \"\(key)\" containing a String value")
        }
        return val
    }

    public func requiredGUID(key: String)
        throws
        -> NSUUID
    {
        let guidStr = try self.requiredString(key)

        guard let val = NSUUID(UUIDString: guidStr) else {
            throw DataTransactionError.DataFormatError("Expected to find key named \(key) containing a GUID value")
        }
        return val
    }

    public func requiredBool(key: String)
        throws
        -> Bool
    {
        if let boolInt = self[key] as? Int {
            return boolInt != 0
        } else if let boolStr = self[key] as? String {
            return boolStr == "true"
        } else if let bool = self[key] as? Bool {
            return bool
        }

        throw DataTransactionError.DataFormatError("Expected to find key named \"\(key)\" containing a numberis, string, or boolean Bool value")
    }

    public func optionalBool(key: String)
        -> Bool?
    {
        if let boolStr = self[key] as? String {
            return boolStr == "true"
        } else if let boolInt = self[key] as? Int {
            return boolInt != 0
        } else if let bool = self[key] as? Bool {
            return bool
        }
        return nil
    }

    public func requiredInt(key: String)
        throws
        -> Int
    {
        guard let val = self[key] as? Int else {
            throw DataTransactionError.DataFormatError("Expected to find key named \"\(key)\" containing an Int value")
        }
        return val
    }

    public func requiredDouble(key: String)
        throws
        -> Double
    {
        guard let val = self[key] as? Double else {
            throw DataTransactionError.DataFormatError("Expected to find key named \"\(key)\" containing a Double value")
        }
        return val
    }

    public func requiredArray(key: String)
        throws
        -> NSArray
    {
        guard let val = self[key] as? NSArray else {
            throw DataTransactionError.DataFormatError("Expected to find key named \"\(key)\" containing an NSArray")
        }
        return val
    }

    public func requiredArrayWithType<T, A: AnyObject>(key: String, transform: (A) throws -> T)
        throws
        -> [T]
    {
        let extractedArray = try self.requiredArray(key) as! [A]
        var resultArray = [T]()

        for item in extractedArray {
            resultArray.append(try transform(item))
        }

        return resultArray
    }

    public func requiredArrayWithType<T, A: AnyObject>(key: String, optionalTransform: (A) -> T?)
        throws
        -> [T]
    {
        let extractedArray = try self.requiredArray(key) as! [A]

        return extractedArray.flatMap { item in
            return optionalTransform(item)
        }
    }

    public func optionalArrayWithType<T, A: AnyObject>(key: String, transform: (A) throws -> T)
        throws
        -> [T]?
    {
        let extractedArray = self[key] as? [A]

        if let array = extractedArray {
            var resultArray = [T]()

            for item in array {
                resultArray.append(try transform(item))
            }

            return resultArray
        }
        return nil
    }

    public func optionalArrayWithType<T, A: AnyObject>(key: String, optionalTransform: (A) -> T?)
        -> [T]?
    {
        let extractedArray = self[key] as? [A]
        
        return extractedArray?.flatMap { item in
            return optionalTransform(item)
        }
    }

    public func requiredStringArray(key: String)
        throws
        -> [String]
    {
        guard let val = self[key] as? NSArray else {
            throw DataTransactionError.DataFormatError("Expected to find key named \"\(key)\" containing an NSArray")
        }
        
        var strings = [String]()
        for item in val {
            guard let str = item as? String else {
                throw DataTransactionError.DataFormatError("Expected to find string values in the array for the key named \"\(key)\".")
            }
            strings += [str]
        }
        return strings
    }
    
    public func requiredDictionary(key: String)
        throws
        -> NSDictionary
    {
        guard let val = self[key] as? NSDictionary else {
            throw DataTransactionError.DataFormatError("Expected to find key named \"\(key)\" containing an NSDictionary")
        }
        return val
    }

    public func requiredString(key: String)
        throws
        -> String
    {
        guard let val = self[key] as? String else {
            throw DataTransactionError.DataFormatError("Expected to find key named \"\(key)\" containing a String value")
        }
        return val
    }

    public func requiredURL(key: String)
        throws
        -> NSURL
    {
        guard let url = NSURL(string: try requiredString(key)) else {
            throw DataTransactionError.DataFormatError("Expected the key named \"\(key)\" to contain a valid URL value")
        }
        return url
    }

}
