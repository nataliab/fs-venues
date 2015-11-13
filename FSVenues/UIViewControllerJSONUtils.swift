//
//  UIViewControllerJSONUtils.swift
//  FSVenues
//
//  Created by Natalia Bartol on 24/11/2015.
//  Copyright © 2015 Natalia Bartol. All rights reserved.
//

import UIKit

extension UIViewController {

    func getJSON(data: NSData) -> NSObject? {
        var response: AnyObject?
        do {
            try response = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions())
            return response as? NSObject
        }
        catch let error as NSError {
            print("JSON serialization error: \(error)")
            return nil
        }
    }

}
