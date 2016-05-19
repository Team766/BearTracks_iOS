//
//  LoginViewController.swift
//  BearTracksIOS
//
//  Created by Tommy Yu on 12/14/15.
//  Copyright © 2015 Team766. All rights reserved.
//

import UIKit
import Firebase
import Toast

class LoginViewController: UIViewController, UITextFieldDelegate{
    
    //MARK: Properties
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let ref = Firebase(url: "https://beartracks.firebaseio.com/")
    
    override func viewDidAppear(animated: Bool) {
        if NSUserDefaults.standardUserDefaults().boolForKey("didLogin") {
            // Terms have been accepted, proceed as normal
            self.performSegueWithIdentifier("loggedIn", sender: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        usernameTextField.delegate = self
        passwordTextField.delegate = self
        passwordTextField.secureTextEntry = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(LoginViewController.dismissKeyboard(_:)))
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func dismissKeyboard(gesture: UIGestureRecognizer){
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        ref.removeAllObservers()
    }
    
    //MARK: UITextFieldDelegate:
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if(textField == usernameTextField){
            self.passwordTextField.becomeFirstResponder()
        }else{
            textField.resignFirstResponder()
            login()
        }
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
                if error == nil{
                    self.performSegueWithIdentifier("loggedIn", sender: nil)
                    NSUserDefaults.standardUserDefaults().setBool(true, forKey: "didLogin")

                }else{
                    self.view.makeToast("Please enter valid credentials")
                }
        })
    }
}
