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

    @IBOutlet weak var emailTextView: UITextView!
    @IBOutlet weak var phoneTextView: UITextView!
    
    var firebaseKey = ""
    var indicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var ref: Firebase
        ref = Firebase(url: "https://beartracks.firebaseio.com/people").childByAppendingPath(firebaseKey)
        loadPersonDetails(ref)
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

    func loadPersonDetails(ref: Firebase){
        ref.observeEventType(.Value, withBlock: { snapshot in
            self.nameLabel.text = snapshot.value["name"] as? String
            self.emailTextView.text = snapshot.value["email"] as? String
            self.emailTextView.dataDetectorTypes = .Link
            self.emailTextView.editable = false
            self.emailTextView.selectable = true
            
            let phoneNumber = snapshot.value["phone"] as? String
            if((phoneNumber?.isEmpty) != nil){
                self.phoneTextView.text = phoneNumber
                self.phoneTextView.dataDetectorTypes = .PhoneNumber
                self.phoneTextView.editable = false
                self.phoneTextView.selectable = true
            }else{
                self.phoneTextView.text = ""
                self.phoneTextView.editable = false
                self.phoneTextView.selectable = false
            }
            
            let photo = snapshot.value["photo"] as? String
            let url = NSURL(string: photo!)
            let data = NSData(contentsOfURL: url!)
            let image = UIImage(data: data!)
            
            self.picImageView.image = image
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            self.indicator.stopAnimating()
        }, withCancelBlock: { error in
            print(error.description)
        })
    }

}

