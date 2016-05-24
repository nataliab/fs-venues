//
//  VenueDetailsViewController.swift
//  FSVenues
//
//  Created by Natalia Bartol on 19/11/2015.
//  Copyright © 2015 Natalia Bartol. All rights reserved.
//

import UIKit

class VenueDetailsViewController: UIViewController {
    
    var activityIndicator: UIActivityIndicatorView!
    let venue: Venue
    
    init(venue: Venue)
    {
        self.venue = venue
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator = createProgressIndicator()
        let leftButton =  UIBarButtonItem(title: "Back", style:   UIBarButtonItemStyle.Plain, target: self, action: #selector(VenueDetailsViewController.back(_:)))
        navigationItem.setLeftBarButtonItem(leftButton, animated: false)
        title = venue.name
        if let photo = venue.bestPhoto where photo.width > 0 {
            showProgressIndicator(activityIndicator)
            getDataFromUrl(NSURL(string: "\(photo._prefix)\(photo.width)\(photo.suffix)"), completion: displayPhoto)
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
    
    func back(sender: UIButton){
        navigationController!.popViewControllerAnimated(true)
    }
}
