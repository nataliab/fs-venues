//
//  VenueTableViewCell.swift
//  FSVenues
//
//  Created by Natalia Bartol on 16/11/2015.
//  Copyright © 2015 Natalia Bartol. All rights reserved.
//

import UIKit

class VenueTableViewCell: UITableViewCell {
    
    var name: UILabel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        name = UILabel()
        name!.textAlignment = NSTextAlignment.Left
        self.contentView.addSubview(name!)
        name!.translatesAutoresizingMaskIntoConstraints = false
        name!.leadingAnchor.constraintEqualToAnchor(self.contentView.leadingAnchor, constant: 10.0).active = true
        name!.centerYAnchor.constraintEqualToAnchor(self.contentView.centerYAnchor).active = true
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
