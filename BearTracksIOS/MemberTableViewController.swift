//
//  MemberTableViewController.swift
//  BearTracksIOS
//
//  Created by Tommy Yu on 12/19/15.
//  Copyright © 2015 Team766. All rights reserved.
//

import UIKit

class MemberTableViewController: UITableViewController {
    
    //MARK: Properties
    var members = [Member]()
    var ref = Firebase(url: "https://beartracks.firebaseio.com/people/")

    override func viewDidLoad() {
        super.viewDidLoad()

        //Load members
        loadPeople()
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
        return members.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "MemberTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MemberTableViewCell
        let member = members[indexPath.row]
        
        let url = NSURL(string: member.photo)!
        let data = NSData(contentsOfURL: url)

        cell.memberNameLabel.text = member.name
        cell.memerPhotoView.image = UIImage(data: data!)

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func loadPeople(){
        ref.observeEventType(.ChildAdded, withBlock: { snapshot in
            let name = snapshot.value["name"] as? String
            let photo = snapshot.value["photo"] as? String
            let member = Member(name: name!, photo: photo!)
            self.members.append(member)
            self.tableView.reloadData()
        })
    }

}
