//
//  ImageUtlis.swift
//  FSVenues
//
//  Created by Natalia Bartol on 24/05/2016.
//  Copyright © 2016 Natalia Bartol. All rights reserved.
//

import Foundation

func getDataFromUrl(url: NSURL?, completion: ((data: NSData?) -> Void)) {
    guard let url = url else { return }
    NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
        completion(data: data)
        }.resume()
}
