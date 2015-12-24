//
//  RoleDetailViewController.swift
//  BearTracks
//
//  Created by Tommy Yu on 12/24/15.
//  Copyright © 2015 Team766. All rights reserved.
//

import UIKit

class RoleDetailViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var roleTitle: UILabel!
    @IBOutlet weak var creatorLabel: UILabel!
    @IBOutlet weak var ownerLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    let peopleRef = Firebase(url: "https://beartracks.firebaseio.com/people")
    var firebaseKey = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        var roleRef: Firebase
        roleRef = Firebase(url: "https://beartracks.firebaseio.com/roles").childByAppendingPath(firebaseKey)
        loadRoleDetails(roleRef)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadRoleDetails(ref: Firebase){
        ref.observeEventType(.Value, withBlock: { snapshot in
            self.roleTitle.text = snapshot.value["name"] as? String
            let creatorKey = snapshot.value["creator"] as? String
            self.findCreator(creatorKey!)
            let ownerKey = snapshot.value["owner"] as? String
            if(ownerKey != nil){
                self.findOwner(ownerKey!)
            }else{
                self.ownerLabel.text = "No owner"
            }
            let status = snapshot.value["status"] as? String
            self.statusLabel.text = "Status:  " + status!
        })
    }
    
    func findCreator(key: String){
        let creatorRef = peopleRef.childByAppendingPath(key)
        var personName = "Team766 Member"
        creatorRef.observeEventType(.Value, withBlock: {snapshot in
            personName = (snapshot.value["name"] as? String)!
            self.creatorLabel.text = "Creator:  " + personName
        })
    }
    
    func findOwner(key: String){
        let ownerRef = peopleRef.childByAppendingPath(key)
        var ownerName = "Team 766 Member"
        ownerRef.observeEventType(.Value, withBlock: {snapshot in
            ownerName = (snapshot.value["name"] as? String)!
            self.ownerLabel.text = "Owner:  " + ownerName
        })
    }
    
}
