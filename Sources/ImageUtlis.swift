//
//  ImageUtlis.swift
//  FSVenues
//
//  Created by Natalia Bartol on 24/05/2016.
//  Copyright © 2016 Natalia Bartol. All rights reserved.
//

import Foundation
import UIKit

func getDataFromUrl(url: NSURL?, completion: ((data: NSData?) -> Void)) {
    guard let url = url else { return }
    NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
        completion(data: data)
        }.resume()
}


func createPlaceholderImage(frame: CGRect) -> UIImage {
    let rect = frame
    UIGraphicsBeginImageContext(rect.size)
    let context = UIGraphicsGetCurrentContext()
    CGContextSetFillColorWithColor(context, UIColor.groupTableViewBackgroundColor().CGColor)
    CGContextFillRect(context, rect)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext();
    return image
}