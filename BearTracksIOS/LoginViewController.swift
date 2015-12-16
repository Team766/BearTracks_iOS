//
//  LoginViewController.swift
//  BearTracksIOS
//
//  Created by Tommy Yu on 12/14/15.
//  Copyright © 2015 Team766. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate{
    
    //MARK: Properties
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let ref = Firebase(url: "https://beartracks.firebaseio.com/")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //MARK: Actions
    @IBAction func loginAction(sender: UIButton) {
        let userName = usernameTextField.text
        let passWord = passwordTextField.text
        ref.authUser(userName!, password: passWord!,
            withCompletionBlock: {error, authData in
                if error != nil{
                
                }else{
                    self.performSegueWithIdentifier("loggedIn", sender: nil)
                }
        })
    }
}
