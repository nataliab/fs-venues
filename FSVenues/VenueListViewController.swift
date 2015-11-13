//
//  ViewController.swift
//  FSVenues
//
//  Created by Natalia Bartol on 13/11/2015.
//  Copyright © 2015 Natalia Bartol. All rights reserved.
//

import UIKit
import CoreLocation

class VenueListViewController: UITableViewController, UITextFieldDelegate{
    
    // MARK: Properties
    var venues = [Venue]()
    var what: String = "beer"
    var near: String = ""
    let cellIdentifier = "venueCell"
    let headerCellIdentifier = "headerCell"
    var whatTextField: UITextField?
    var nearTextField: UITextField?
    var activityIndicator: UIActivityIndicatorView?
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Find Venues!"
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        tableView = UITableView(frame: self.view.frame)
        tableView!.dataSource = self
        tableView!.delegate = self
        tableView!.registerClass(VenueTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView!.registerClass(VenueTableHeaderViewCell.self, forCellReuseIdentifier: headerCellIdentifier)
        tableView!.tableFooterView = UIView()
        activityIndicator = createProgressIndicator()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venues.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let venue = venues[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! VenueTableViewCell
        cell.name!.text = venue.name
        return cell
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCellWithIdentifier(headerCellIdentifier) as! VenueTableHeaderViewCell
        //headerCell.contentView.backgroundColor = UIColor.whiteColor()
        whatTextField = headerCell.whatTextField
        nearTextField = headerCell.nearTextField
        nearTextField!.text = near
        whatTextField!.text = what
        nearTextField!.addTarget(self, action: "editingChanged:", forControlEvents:.EditingChanged)
        whatTextField!.addTarget(self, action: "editingChanged:", forControlEvents:.EditingChanged)
        headerCell.searchButton!.addTarget(self, action: "search:", forControlEvents: UIControlEvents.TouchUpInside)
        return headerCell.contentView
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let v = venues[indexPath.row]
        let venueDetailsController = VenueDetailsViewController(venueId: v.id)
        navigationController!.pushViewController(venueDetailsController, animated: true)
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldDidEndEditing(textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: Actions
    
    func search(sender: UIButton) {
        tableView.becomeFirstResponder()
        search(what, near: near)
    }
    
    func search(what: String, near: String){
        venues = [Venue]()
        reloadData()
        showProgressIndicator(self.activityIndicator!)
        print("Searching for \(what) near \(near)...")
        FourSquareApi.getVenues(
            APIConstants.CLIENT_ID,
            clientSecret: APIConstants.CLIENT_SECRET,
            version: APIConstants.VERSION_DATE,
            what: what,
            near: near,
            completionHandler: processResponse)
    }
    
    func processResponse(data: NSData?, response: NSURLResponse?, error: NSError?) -> Void {
        if let e = error {
            print("got an error: \(e)")
        } else if let resp = response as? NSHTTPURLResponse {
            if resp.statusCode < 300 {
                if let d = data {
                    if let resp = getJSON(d){
                        let venuesResponse = VenueListResponse(data: resp)
                        if let v = venuesResponse {
                            self.venues = v.venues
                            self.reloadData()
                        }
                    }
                }
            } else {
                print("got an error: \(resp.statusCode)")
            }
        }
        self.hideProgressIndicator(self.activityIndicator!)
    }
    
    func editingChanged(textField: UITextField){
        if let text = textField.text {
            if textField === nearTextField! {
                near = text
            } else if textField === whatTextField! {
                what = text
            }
        }
    }
    
    func reloadData(){
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
        })
    }
    
}

