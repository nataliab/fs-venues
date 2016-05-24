//
//  VenueDetailsViewController.swift
//  FSVenues
//
//  Created by Natalia Bartol on 19/11/2015.
//  Copyright © 2015 Natalia Bartol. All rights reserved.
//

import UIKit

class VenueDetailsViewController: UIViewController {
    
    let imageView: UIImageView
    var activityIndicator: UIActivityIndicatorView!
    
    init(venue: String)
    {
        imageView = UIImageView()
        super.init(nibName: nil, bundle: nil)
        title = venue
        activityIndicator = createProgressIndicator()
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let leftButton =  UIBarButtonItem(title: "Back", style:   UIBarButtonItemStyle.Plain, target: self, action: #selector(VenueDetailsViewController.back(_:)))
        navigationItem.setLeftBarButtonItem(leftButton, animated: false)
        imageView.frame = self.view.frame
        imageView.clipsToBounds = true
        imageView.contentMode = .ScaleAspectFit
        imageView.image = createPlaceholderImage(CGRectMake(0.0, 0.0, view.frame.width, view.frame.height))
        view.addSubview(self.imageView)
    }
    
    func displayPhoto(data: NSData?) -> Void {
        guard let d = data else { return }
        dispatch_async(dispatch_get_main_queue()) {
            self.imageView.image = UIImage(data: d)
            self.hideProgressIndicator(self.activityIndicator)
        }
    }
    
    func back(sender: UIButton){
        navigationController!.popViewControllerAnimated(true)
    }
}
