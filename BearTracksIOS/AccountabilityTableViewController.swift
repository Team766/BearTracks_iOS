//
//  AccountabilityTableViewController.swift
//  BearTracks
//
//  Created by Tommy Yu on 12/24/15.
//  Copyright © 2015 Team766. All rights reserved.
//

import UIKit

class AccountabilityTableViewController: UITableViewController {
    
    var refURL = ""
    var descriptions = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        var ref: Firebase
        ref = Firebase(url: refURL)
        populateCells(ref)
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
        return descriptions.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "BasicTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! BasicTableViewCell
        let name = descriptions[indexPath.row]
        
        cell.nameLabel.text = name

        return cell
    }

    
    func populateCells(ref: Firebase){
        ref.observeEventType(.ChildAdded, withBlock: {snapshot in
            let description = snapshot.value["description"] as? String
            self.descriptions.append(description!)
            self.tableView.reloadData()
        })
    }
}
