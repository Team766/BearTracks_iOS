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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:"imageTapped:")
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

}

