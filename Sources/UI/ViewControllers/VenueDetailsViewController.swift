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
    var activityIndicator: UIActivityIndicatorView!
    var venue: Venue?
    
    init(venueId: String)
    {
        self.venueId = venueId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator = createProgressIndicator()
        let leftButton =  UIBarButtonItem(title: "Back", style:   UIBarButtonItemStyle.Plain, target: self, action: #selector(VenueDetailsViewController.back(_:)))
        navigationItem.setLeftBarButtonItem(leftButton, animated: false)
        loadVenueDetails()
    }
    
    func loadVenueDetails() {
        do {
            showProgressIndicator(activityIndicator)
            let venueDetailsTransaction = try VenueGetVenuesByVenueId(venueId: venueId, clientId: FourSquareAPIConstants.CLIENT_ID, clientSecret: FourSquareAPIConstants.CLIENT_SECRET, v: FourSquareAPIConstants.VERSION_DATE)
            
            venueDetailsTransaction.executeTransaction() { result in
                switch result {
                case .Succeeded(let response, _):
                    let v = response.response.venue
                    self.venue = v
                    self.title = v.name
                    if let photo = v.bestPhoto where photo.width > 0 {
                        self.getDataFromUrl(NSURL(string: "\(photo._prefix)\(photo.width)\(photo.suffix)"), completion: self.displayPhoto)
                    }
                case .Failed(let err):
                    self.displayError("Failed to load venue details: \(err)")
                }
            }
        } catch (let err) {
             hideProgressIndicator(activityIndicator)
             displayError("Failed to load venue details: \(err)")
        }
    }
    
    func displayPhoto(data: NSData?) -> Void {
        guard let d = data else { return }
        dispatch_async(dispatch_get_main_queue()) {
            let imageView = UIImageView()
            imageView.frame = self.view.frame
            imageView.image = UIImage(data: d)
            imageView.clipsToBounds = true
            imageView.contentMode = .ScaleAspectFit
            self.view.addSubview(imageView)
            self.hideProgressIndicator(self.activityIndicator)
        }
    }
    
    func getDataFromUrl(url: NSURL?, completion: ((data: NSData?) -> Void)) {
        guard let url = url else { return }
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data)
            }.resume()
    }
    
    func back(sender: UIButton){
        navigationController!.popViewControllerAnimated(true)
    }
}
