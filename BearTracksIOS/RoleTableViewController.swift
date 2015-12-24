//
//  MealTableViewController.swift
//  BearTracks
//
//  Created by Tommy Yu on 12/21/15.
//  Copyright © 2015 Team766. All rights reserved.
//

import UIKit

class RoleTableViewController: UITableViewController {
    
    var ref = Firebase(url: "https://beartracks.firebaseio.com/roles")
    var roles = [Role]()

    override func viewDidLoad() {
        super.viewDidLoad()

        loadRoles()
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
        return roles.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "RoleTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! RoleTableViewCell
        let role = roles[indexPath.row]

        // Configure the cell...
        cell.roleNameLabel.text = role.name

        return cell
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let roleDetail = segue.destinationViewController as! RoleDetailViewController
        let index = self.tableView.indexPathForSelectedRow!.row
        let role = roles[index]
        
        roleDetail.firebaseKey = role.key
    }
    
    func loadRoles(){
        ref.observeEventType(.ChildAdded, withBlock: { snapshot in
            let name = snapshot.value["name"] as? String
            let key = snapshot.key
            
            let role = Role(name: name!, key: key!)
            self.roles.append(role)
            self.tableView.reloadData()
        })
    }

}
