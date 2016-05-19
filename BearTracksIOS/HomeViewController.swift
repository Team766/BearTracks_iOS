//
//  FirstViewController.swift
//  BearTracksIOS
//
//  Created by Tommy Yu on 12/13/15.
//  Copyright © 2015 Team766. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet var homeImage: UIImageView!
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(FirstViewController.imageTapped(_:)))
        homeImage.userInteractionEnabled = true
        homeImage.addGestureRecognizer(tapGestureRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Actions
    func imageTapped(gesture: UIGestureRecognizer){
        UIApplication.sharedApplication().openURL(NSURL(string: "http://www.team766.com")!)
    }

    @IBAction func logoutAction(sender: UIBarButtonItem) {
        let confirmAlert = UIAlertController(title: "Confirm", message: "Are you sure you want to logout?", preferredStyle: UIAlertControllerStyle.Alert)
        confirmAlert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: {action in
            confirmAlert.dismissViewControllerAnimated(false, completion: nil)
        }))
        confirmAlert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler: {action in
            NSUserDefaults.standardUserDefaults().setBool(false, forKey: "didLogin")
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        self.presentViewController(confirmAlert, animated: true, completion: nil)
    }
}

