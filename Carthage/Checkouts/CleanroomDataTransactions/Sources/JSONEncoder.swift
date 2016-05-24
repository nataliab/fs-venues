//
//  JSONEncoder.swift
//  AppleTart
//
//  Created by Kyle Dorman on 8/13/15.
//  Copyright © 2015 Gilt Groupe. All rights reserved.
//

import Foundation

public enum ApidocJSONEncoderResult<T> {
    case Succeeded(T)
    case Failed(ErrorType)
}

public protocol BinaryDataModel {
    func toBinaryData () -> BinaryEncoderResult<NSData>
}

public extension BinaryDataModel where Self : JSONDataModel {
    public func toBinaryData () -> BinaryEncoderResult<NSData> {

        switch self.toJSON() {
        case .Succeeded(let json):
            if NSJSONSerialization.isValidJSONObject(json) {
                do {
                    let data = try NSJSONSerialization.dataWithJSONObject(json, options: NSJSONWritingOptions(rawValue: 0))
                    return .Succeeded(data)
                } catch {
                    return .Failed(error)
                }
            } else {
                return .Failed(EncoderErrorType.InvalidJson)
            }
        case .Failed(let error):
            return .Failed(error)
        }
    }
}

public enum BinaryEncoderResult<T> {
    case Succeeded(T)
    case Failed(ErrorType)
}

public enum EncoderErrorType: ErrorType {
    case InvalidJson
}

public protocol JSONDataModel {
    func toJSON () -> ApidocJSONEncoderResult<AnyObject>
}

public extension Array where Element:JSONDataModel {
    func toJSON () -> ApidocJSONEncoderResult<[AnyObject]> {
        var result = [AnyObject]()
        for model in self {
            switch model.toJSON() {
            case .Succeeded(let json):
                result.append(json)
            case .Failed(let error):
                return .Failed(error)
            }
        }
        return .Succeeded(result)
    }
}
public extension Array where Element:JSONDataModel {
    func toBinaryData () -> BinaryEncoderResult<NSData>
    {
        switch self.toJSON() {
        case .Succeeded(let json):
            if NSJSONSerialization.isValidJSONObject(json) {
                do {
                    let data = try NSJSONSerialization.dataWithJSONObject(json, options: NSJSONWritingOptions(rawValue: 0))
                    return .Succeeded(data)
                } catch {
                    return .Failed(error)
                }
            } else {
                return .Failed(EncoderErrorType.InvalidJson)
            }
        case .Failed(let error):
            return .Failed(error)
        }
    }
}

public extension String {
    func toBinaryData () -> BinaryEncoderResult<NSData>
    {
        if let data = ("\"" + self + "\"").dataUsingEncoding(NSUTF8StringEncoding) {
            return BinaryEncoderResult.Succeeded(data)
        } else {
            return .Failed(EncoderErrorType.InvalidJson)
        }
    }
}
