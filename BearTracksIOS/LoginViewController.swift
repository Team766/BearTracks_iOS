//
//  LoginViewController.swift
//  BearTracksIOS
//
//  Created by Tommy Yu on 12/14/15.
//  Copyright © 2015 Team766. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate{
    
    //MARK: Properties
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let ref = Firebase(url: "https://beartracks.firebaseio.com/")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        usernameTextField.delegate = self
        passwordTextField.delegate = self
        
        passwordTextField.secureTextEntry = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UITextFieldDelegate:
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK: Actions
    @IBAction func loginAction(sender: UIButton) {
        login()
    }
    
    func login(){
        let userName = usernameTextField.text
        let passWord = passwordTextField.text
        ref.authUser(userName!, password: passWord!,
            withCompletionBlock: {error, authData in
                if error != nil{
                    self.view.makeToast("Please enter valid credentials")
                }else{
                    self.performSegueWithIdentifier("loggedIn", sender: nil)
                }
        })
    }
}
