//
//  AuthorityTableViewController.swift
//  BearTracks
//
//  Created by Tommy Yu on 12/24/15.
//  Copyright © 2015 Team766. All rights reserved.
//

import UIKit
import Firebase

class AuthorityTableViewController: UITableViewController {
    
    var refURL = ""
    var descriptions = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        var ref: Firebase
        ref = Firebase(url: refURL)
        self.populateCells(ref)
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
        if(descriptions.count != 0){
            return descriptions.count
        }else{
            return 1
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "AuthorityTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! AuthorityTableViewCell
        if(descriptions.count != 0){
            let name = descriptions[indexPath.row]
            cell.nameLabel.text = name
        }else{
            cell.nameLabel.text = "There are no authorities for this role"
        }

        return cell
    }

    func populateCells(ref: Firebase){
        ref.observeEventType(.ChildAdded, withBlock: {snapshot in
            self.descriptions.append((snapshot.value["description"] as? String)!)
            self.tableView.reloadData()
        })
    }
}
