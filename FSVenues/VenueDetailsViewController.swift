//
//  VenueDetailsViewController.swift
//  FSVenues
//
//  Created by Natalia Bartol on 19/11/2015.
//  Copyright © 2015 Natalia Bartol. All rights reserved.
//

import UIKit

class VenueDetailsViewController: UIViewController {
    
    let venueId: String
    var activityIndicator: UIActivityIndicatorView?
    var venue: Venue?
    
    init(venueId: String)
    {
        self.venueId = venueId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator = createProgressIndicator()
        let leftButton =  UIBarButtonItem(title: "Back", style:   UIBarButtonItemStyle.Plain, target: self, action: "back:")
        navigationItem.setLeftBarButtonItem(leftButton, animated: false)
        showProgressIndicator(activityIndicator!)
        FourSquareApi.getVenue(
            APIConstants.CLIENT_ID,
            clientSecret: APIConstants.CLIENT_SECRET,
            version: APIConstants.VERSION_DATE,
            id: venueId,
            completionHandler: processResponse)
    }
    
    func processResponse(data: NSData?, response: NSURLResponse?, error: NSError?) -> Void {
        if let e = error {
            print("got an error: \(e)")
        } else if let resp = response as? NSHTTPURLResponse {
            if resp.statusCode < 300 {
                if let d = data {
                    venue = getJSON(d).flatMap { resp in
                        VenueDetailsResponse(data: resp)?.venue}
                    if let v = venue {
                        title = v.name
                        let photoUrl:NSURL? = v.bestPhoto?.url().flatMap { url in NSURL(string: url)}
                        if let u = photoUrl {
                            getDataFromUrl(u, completion: displayPhoto)
                            return
                        }
                    }
                }
            }
            else {
                print("got an error: \(resp.statusCode)")
            }
            hideProgressIndicator(activityIndicator!)
        }
    }
    
    func displayPhoto(data: NSData?) -> Void {
        guard let d = data else { return }
        dispatch_async(dispatch_get_main_queue()) {
            let image = UIImage(data: d)
            let imageView = UIImageView()
            imageView.frame = self.view.frame
            imageView.image = image
            imageView.clipsToBounds = true
            imageView.contentMode = .ScaleAspectFit
            self.view.addSubview(imageView)
            self.hideProgressIndicator(self.activityIndicator!)
        }
    }
    
    func getDataFromUrl(urL:NSURL, completion: ((data: NSData?) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(urL) { (data, response, error) in
            completion(data: data)
            }.resume()
    }
    
    func back(sender: UIButton){
        navigationController!.popViewControllerAnimated(true)
    }
}
