//
//  ProfileViewController.swift
//  BearTracksIOS
//
//  Created by Tommy Yu on 12/13/15.
//  Copyright © 2015 Team766. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var picImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    var firebaseKey = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var ref: Firebase
        ref = Firebase(url: "https://beartracks.firebaseio.com/people").childByAppendingPath(firebaseKey)
        loadPersonDetails(ref)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadPersonDetails(ref: Firebase){
        ref.observeEventType(.Value, withBlock: { snapshot in
            let photo = snapshot.value["photo"] as? String
            let url = NSURL(string: photo!)
            let data = NSData(contentsOfURL: url!)
            let image = UIImage(data: data!)
            
            self.picImageView.image = image
            self.nameLabel.text = snapshot.value["name"] as? String
        }, withCancelBlock: { error in
            print(error.description)
        })
    }

}

