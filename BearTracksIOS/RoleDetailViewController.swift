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
        })
    }
    
}
