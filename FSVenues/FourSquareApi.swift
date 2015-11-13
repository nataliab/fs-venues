//
//  FourSquareApi.swift
//  FSVenues
//
//  Created by Natalia Bartol on 19/11/2015.
//  Copyright © 2015 Natalia Bartol. All rights reserved.
//
import Foundation

class FourSquareApi {
    
    static let baseUrl = "https://api.foursquare.com/v2/"
    
    static func getVenues(clientId: String, clientSecret: String, version: String, what: String, near: String, completionHandler:((data: NSData?, response: NSURLResponse?, error: NSError?) -> Void)) -> Void {
        do {
            let query =  [
                "client_id": clientId,
                "client_secret":clientSecret,
                "v": version,
                "query": what,
                "near": near
                ].urlEncodedQueryString()
            
            let urlString =  baseUrl + "venues/explore?\(query)"
            
            if let url = NSURL(string: urlString) {
                let task = NSURLSession.sharedSession().dataTaskWithURL(url) {(data, response, error) in
                    completionHandler(data: data, response: response, error: error)
                }
                task.resume()
            } else {
                print("Got an error building request.")
            }
        }
    }
    
    static func getVenue(clientId: String, clientSecret: String, version: String, id: String, completionHandler:((data: NSData?, response: NSURLResponse?, error: NSError?) -> Void)) -> Void {
        let query =  [
            "client_id": clientId,
            "client_secret":clientSecret,
            "v": version
            ].urlEncodedQueryString()
        
        let urlString =  baseUrl + "venues/\(id)?\(query)"
        
        if let url = NSURL(string: urlString) {
            let task = NSURLSession.sharedSession().dataTaskWithURL(url) {(data, response, error) in
                completionHandler(data: data, response: response, error: error)
            }
            task.resume()
        } else {
            print("Got an error building request.")
        }
    }
    
    private static func processResponse(data: NSData?, response: NSURLResponse?, error: NSError?, completionHandler:((NSData) -> Void)){
        if let e = error {
            print("got an error: \(e)")
        } else if let resp = response as? NSHTTPURLResponse {
            if resp.statusCode < 300 {
                if let d = data {
                    completionHandler(d)
                }
            } else {
                print("got an error: \(resp.statusCode)")
            }
        }
    }
    
}