//
//  File.swift
//  FSVenues
//
//  Created by Natalia Bartol on 20/11/2015.
//  Copyright © 2015 Natalia Bartol. All rights reserved.
//

import UIKit
import CoreLocation

extension VenueListViewController: CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error)->Void in
            if (error != nil) {
                print("Reverse geocoder failed with error" + error!.localizedDescription)
                return
            }
            if placemarks!.count > 0 {
                let pm = placemarks![0] as CLPlacemark
                self.displayLocationInfo(pm)
            } else {
                print("Problem with the data received from geocoder")
            }
        })
    }
    func displayLocationInfo(placemark: CLPlacemark) {
        //stop updating location to save battery life
        locationManager.stopUpdatingLocation()
        var location = placemark.locality ?? ""
        if let l = placemark.postalCode {
            if !location.containsString(l) && !l.containsString(location){
                location += ", \(l)"
            }
        }
        if let l = placemark.country {
            location += ", \(l)"
        }
        if near.isEmpty {
            near = location
            nearTextField!.text = near
            search(what, near: near)
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error while updating location " + error.localizedDescription)
    }

}
