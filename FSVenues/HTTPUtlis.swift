//
//  HTTPString.swift
//  FSVenues
//
//  Created by Natalia Bartol on 24/11/2015.
//  Copyright © 2015 Natalia Bartol. All rights reserved.
//

import Foundation


extension String {
    var escaped: String? {
        let set = NSMutableCharacterSet()
        set.formUnionWithCharacterSet(NSCharacterSet.URLQueryAllowedCharacterSet())
        set.removeCharactersInString("[].:/?&=;+!@#$()',*\"") // remove the HTTP ones from the set.
        return self.stringByAddingPercentEncodingWithAllowedCharacters(set)
    }
}


extension Dictionary {
    func urlEncodedQueryString() -> String {
        var parts = [String]()
        for (key, value) in self {
            if let k = "\(key)".escaped, v = "\(value)".escaped {
                let query: String = "\(k)=\(v)"
                parts.append(query)
            }
        }
        return parts.joinWithSeparator("&")
    }
}