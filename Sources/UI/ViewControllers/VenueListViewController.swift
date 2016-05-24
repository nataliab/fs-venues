//
//  ViewController.swift
//  FSVenues
//
//  Created by Natalia Bartol on 13/11/2015.
//  Copyright © 2015 Natalia Bartol. All rights reserved.
//

import UIKit
import CoreLocation
import PromiseKit

class VenueListViewController: UITableViewController, UITextFieldDelegate {
    
    var venues = ["venue1", "venue2"]
    var what: String = "beer"
    var near: String = ""
    let cellIdentifier = "venueCell"
    let headerCellIdentifier = "headerCell"
    var whatTextField: UITextField!
    var nearTextField: UITextField!
    var activityIndicator: UIActivityIndicatorView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Find Venues!"
        tableView = UITableView(frame: view.frame, style: .Plain)
        tableView!.dataSource = self
        tableView!.delegate = self
        tableView!.registerClass(VenueTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView!.registerClass(VenueTableHeaderViewCell.self, forCellReuseIdentifier: headerCellIdentifier)
        tableView!.tableFooterView = UIView()
        activityIndicator = createProgressIndicator()
        setLocationManager()
    }
    
    // MARK: Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venues.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! VenueTableViewCell
        cell.textLabel?.text = venues[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCellWithIdentifier(headerCellIdentifier) as! VenueTableHeaderViewCell
        whatTextField = headerCell.whatTextField
        nearTextField = headerCell.nearTextField
        nearTextField.text = near
        whatTextField.text = what
        nearTextField.addTarget(self, action: #selector(VenueListViewController.editingChanged(_:)), forControlEvents:.EditingChanged)
        whatTextField.addTarget(self, action: #selector(VenueListViewController.editingChanged(_:)), forControlEvents:.EditingChanged)
        headerCell.searchButton.addTarget(self, action: #selector(VenueListViewController.search(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        return headerCell.contentView
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 220
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let v = venues[indexPath.row]
        navigationController!.pushViewController(VenueDetailsViewController(venue: v), animated: true)
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldDidEndEditing(textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func editingChanged(textField: UITextField){
        if let text = textField.text {
            if textField === nearTextField {
                near = text
            } else if textField === whatTextField {
                what = text
            }
        }
    }
    
    // MARK: Actions
    
    func search(sender: UIButton) {
        tableView.becomeFirstResponder()
        search(what, near: near)
    }
    
    func search(what: String, near: String){
        showProgressIndicator(activityIndicator)
        //TODO implement me!
        hideProgressIndicator(activityIndicator)
    }
    
}

