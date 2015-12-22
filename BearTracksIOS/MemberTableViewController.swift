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
       
        cell.memberNameLabel.text = member.name
        cell.memerPhotoView.image = member.photo

        return cell
    }

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
            
            let url = NSURL(string: photo!)
            let data = NSData(contentsOfURL: url!)
            let image = UIImage(data: data!)
            
            let member = Member(name: name!, photo: image!)
            self.members.append(member)
            self.tableView.reloadData()
        })
    }

}
