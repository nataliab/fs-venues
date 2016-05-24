//
//  VenueTableViewCell.swift
//  FSVenues
//
//  Created by Natalia Bartol on 16/11/2015.
//  Copyright © 2015 Natalia Bartol. All rights reserved.
//

import UIKit

class VenueTableViewCell: UITableViewCell {
    
    let placeholderImage = VenueTableViewCell.createPlaceholderImage()
    
    var venue: Venue? {
        didSet {
            textLabel?.text = venue!.name
            if let photo = venue!.bestPhoto where photo.width > 0 {
                getDataFromUrl(NSURL(string: "\(photo._prefix)\(photo.width)\(photo.suffix)"), completion: displayPhoto)
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        imageView?.image = placeholderImage
    }
    
    required init(coder aDecoder: NSCoder) { fatalError() }
    
    private func displayPhoto(data: NSData?) -> Void {
        guard let d = data else { return }
        dispatch_async(dispatch_get_main_queue()) {
            self.imageView?.image = UIImage(data: d)
            self.layoutSubviews()
        }
    }
    
    override func prepareForReuse() {
        self.imageView?.image = placeholderImage
        textLabel?.text = ""
        layoutSubviews()
    }
    
    private static func createPlaceholderImage() -> UIImage {
        let rect = CGRectMake(0.0, 0.0, 80, 80)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, UIColor.groupTableViewBackgroundColor().CGColor)
        CGContextFillRect(context, rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return image
    }
    
}

