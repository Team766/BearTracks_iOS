//
//  AccountabilityTableViewController.swift
//  BearTracks
//
//  Created by Tommy Yu on 12/24/15.
//  Copyright © 2015 Team766. All rights reserved.
//

import UIKit
import Firebase

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
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(descriptions.count != 0){
            return descriptions.count
        }else{
            return 1
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "BasicTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! BasicTableViewCell
        
        if(descriptions.count != 0){
            let name = descriptions[indexPath.row]
            cell.nameLabel.text = name
            self.tableView.userInteractionEnabled = true
        }else{
            self.tableView.userInteractionEnabled = false
            cell.nameLabel.text = "There are no accounabilities for this role"
        }

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
