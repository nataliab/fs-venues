//
//  UIViewControllerProgressIndicator.swift
//  FSVenues
//
//  Created by Natalia Bartol on 20/11/2015.
//  Copyright © 2015 Natalia Bartol. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func createProgressIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        return activityIndicator
    }
    
    func showProgressIndicator(indicator: UIActivityIndicatorView) {
        dispatch_async(dispatch_get_main_queue(), {
            self.view.addSubview(indicator)
        })
    }
    
    func hideProgressIndicator(indicator: UIActivityIndicatorView) {
        dispatch_async(dispatch_get_main_queue(), {
           indicator.removeFromSuperview()
        })
    }
    
    func displayError(message: String) {
        let alertController = UIAlertController(title: "Error", message:
            message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
}

