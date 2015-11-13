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
    
    var whatLabel: UILabel?
    var nearLabel: UILabel?
    var whatTextField: UITextField?
    var nearTextField: UITextField?
    var searchButton: UIButton?
    var stackView: UIStackView?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

       
        whatLabel = UILabel()
        whatLabel!.textAlignment = NSTextAlignment.Left
        whatLabel!.text = "What"
        
        whatTextField = UITextField()
        whatTextField!.borderStyle = UITextBorderStyle.RoundedRect
        whatTextField!.text = "myString"
        
        nearLabel = UILabel()
        nearLabel!.textAlignment = NSTextAlignment.Left
        nearLabel!.text = "Near"
        
        nearTextField = UITextField()
        nearTextField!.borderStyle = UITextBorderStyle.RoundedRect
        
        searchButton = UIButton(type: UIButtonType.System) as UIButton
        searchButton!.setTitle("Search", forState: UIControlState.Normal)
            
        stackView = UIStackView()
        stackView!.axis = .Vertical
        stackView!.distribution = .Fill
        stackView!.alignment = .Fill
        stackView!.spacing = 10
        
        stackView!.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(stackView!)
        
        stackView!.addArrangedSubview(whatLabel!)
        stackView!.addArrangedSubview(whatTextField!)
        stackView!.addArrangedSubview(nearLabel!)
        stackView!.addArrangedSubview(nearTextField!)
        stackView!.addArrangedSubview(searchButton!)
        
        contentView.backgroundColor = UIColor.whiteColor()
        
        self.contentView.addSubview(stackView!)

        stackView!.trailingAnchor.constraintEqualToAnchor(self.contentView.trailingAnchor, constant: -10.0).active = true
        stackView!.leadingAnchor.constraintEqualToAnchor(self.contentView.leadingAnchor, constant: 10.0).active = true
        stackView!.topAnchor.constraintEqualToAnchor(self.contentView.topAnchor, constant: 10).active = true
        
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
