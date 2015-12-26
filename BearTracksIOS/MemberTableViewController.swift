//
//  MemberTableViewController.swift
//  BearTracksIOS
//
//  Created by Tommy Yu on 12/19/15.
//  Copyright © 2015 Team766. All rights reserved.
//

import UIKit
import Firebase

class MemberTableViewController: UITableViewController {
    
    //MARK: Properties
    var members = [Member]()
    var ref = Firebase(url: "https://beartracks.firebaseio.com/people/")
    var indicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)

    override func viewDidLoad() {
        super.viewDidLoad()

        
        //Load members
        loadPeople()
        indicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
        indicator.center = view.center
        view.addSubview(indicator)
        indicator.bringSubviewToFront(view)
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        indicator.startAnimating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        ref.removeAllObservers()
        self.indicator.stopAnimating()
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
    

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let profileViewController = segue.destinationViewController as! ProfileViewController
        let index = self.tableView.indexPathForSelectedRow!.row
        let memberChosen = members[index]
        
        profileViewController.firebaseKey = memberChosen.key
    }
    
    func loadPeople(){
        ref.observeEventType(.ChildAdded, withBlock: { snapshot in
            let name = snapshot.value["name"] as? String
            let photo = snapshot.value["photo"] as? String
            let key = snapshot.key
            
            let url = NSURL(string: photo!)
            let data = NSData(contentsOfURL: url!)
            let image = UIImage(data: data!)
            
            let member = Member(name: name!, photo: image!, key: key)
            self.members.append(member)
            self.tableView.reloadData()
            self.indicator.stopAnimating()
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        })
    }

}
