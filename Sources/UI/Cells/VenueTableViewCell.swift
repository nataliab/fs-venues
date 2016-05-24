//
//  VenueTableViewCell.swift
//  FSVenues
//
//  Created by Natalia Bartol on 16/11/2015.
//  Copyright © 2015 Natalia Bartol. All rights reserved.
//

import UIKit

class VenueTableViewCell: UITableViewCell {
    
    let name: UILabel
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        name = UILabel()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(name)
        name.translatesAutoresizingMaskIntoConstraints = false
        name.leadingAnchor.constraintEqualToAnchor(self.contentView.leadingAnchor, constant: 10.0).active = true
        name.centerYAnchor.constraintEqualToAnchor(self.contentView.centerYAnchor).active = true
    }
    
    required init(coder aDecoder: NSCoder) { fatalError() }
    
}
