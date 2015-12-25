//
//  AttachmentsTableViewController.swift
//  BearTracks
//
//  Created by Tommy Yu on 12/24/15.
//  Copyright © 2015 Team766. All rights reserved.
//

import UIKit
import Firebase

class AttachmentsTableViewController: UITableViewController {
    
    var refURL = ""
    var attachments = [Attachment]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let ref = Firebase(url: refURL)
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
        if(attachments.count != 0){
            return attachments.count
        }else{
            return 1
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AttachmentTableViewCell", forIndexPath: indexPath) as! AttachmentTableViewCell
        
        if(attachments.count != 0){
            let attachment = attachments[indexPath.row]
            cell.attachmentName.text = attachment.name
        }else{
            cell.attachmentName.text = "No attachments"
        }

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(attachments.count != 0){
            let attachment = attachments[indexPath.row]
            let url = attachment.url
            UIApplication.sharedApplication().openURL(NSURL(string: url)!)
        }
    }

    func populateCells(ref: Firebase){
        ref.observeEventType(.ChildAdded, withBlock: {snapshot in
            let name = snapshot.value["name"] as? String
            let url = snapshot.value["url"] as? String
            let attachment = Attachment(name: name!, url: url!)
            self.attachments.append(attachment)
            self.tableView.reloadData()
        })
    }
    
}
