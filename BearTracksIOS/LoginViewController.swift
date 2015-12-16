//
//  LoginViewController.swift
//  BearTracksIOS
//
//  Created by Tommy Yu on 12/14/15.
//  Copyright © 2015 Team766. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var ref = Firebase(url: "https://beartracks.firebaseio.com/")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Actions
    @IBAction func loginAction(sender: UIButton) {
        
    }
}
