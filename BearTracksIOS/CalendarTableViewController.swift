//
//  CalendarTableViewController.swift
//  BearTracks
//
//  Created by Tommy Yu on 12/25/15.
//  Copyright © 2015 Team766. All rights reserved.
//

import UIKit

class CalendarTableViewController: UITableViewController {
    
    var events = [CalendarEvent]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return events.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CalendarTableViewCell", forIndexPath: indexPath) as! CalendarTableViewCell
        let event = events[indexPath.row]
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = .LongStyle
        let startString = dateFormatter.stringFromDate(event.startDate)
        let endString = dateFormatter.stringFromDate(event.endDate)
        
        cell.titleLabel.text = event.title + " located at " + event.location
        cell.timeLabel.text = startString + " - " + endString
        
        return cell
    }
    
}
