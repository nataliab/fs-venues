//
//  VenueTableHeaderViewCell.swift
//  FSVenues
//
//  Created by Natalia Bartol on 17/11/2015.
//  Copyright © 2015 Natalia Bartol. All rights reserved.
//

import UIKit

@available(iOS 9.0, *)
class VenueTableHeaderViewCell: UITableViewCell {
    
    let whatTextField: UITextField
    let nearTextField: UITextField
    let searchButton: UIButton
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        let whatLabel = UILabel()
        whatLabel.text = "What"
        whatTextField = UITextField()
        whatTextField.borderStyle = UITextBorderStyle.RoundedRect
        let nearLabel = UILabel()
        nearLabel.text = "Near"
        nearTextField = UITextField()
        nearTextField.borderStyle = UITextBorderStyle.RoundedRect
        searchButton = UIButton(type: UIButtonType.System) as UIButton
        searchButton.setTitle("Search", forState: UIControlState.Normal)
        let stackView = UIStackView(arrangedSubviews:[whatLabel, whatTextField, nearLabel, nearTextField, searchButton])
        stackView.axis = .Vertical
        stackView.distribution = .Fill
        stackView.alignment = .Fill
        stackView.spacing = 10
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        stackView.trailingAnchor.constraintEqualToAnchor(self.contentView.trailingAnchor, constant: -10.0).active = true
        stackView.leadingAnchor.constraintEqualToAnchor(self.contentView.leadingAnchor, constant: 10.0).active = true
        stackView.topAnchor.constraintEqualToAnchor(self.contentView.topAnchor, constant: 10).active = true
        contentView.backgroundColor = UIColor.groupTableViewBackgroundColor()
    }
    
    required init(coder aDecoder: NSCoder) { fatalError() }
    
}
