//
//  ProfileViewController.swift
//  BearTracksIOS
//
//  Created by Tommy Yu on 12/13/15.
//  Copyright © 2015 Team766. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var picImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    var firebaseKey = ""
    @IBOutlet weak var emailTextView: UITextView!
    
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
            self.nameLabel.text = snapshot.value["name"] as? String
            self.emailTextView.text = snapshot.value["email"] as? String
            self.emailTextView.dataDetectorTypes = .Link
            self.emailTextView.editable = false
            self.emailTextView.selectable = true
            
            let photo = snapshot.value["photo"] as? String
            let url = NSURL(string: photo!)
            let data = NSData(contentsOfURL: url!)
            let image = UIImage(data: data!)
            
            self.picImageView.image = image
        }, withCancelBlock: { error in
            print(error.description)
        })
    }

}

