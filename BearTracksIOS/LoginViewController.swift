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
    
    override func viewDidAppear(animated: Bool) {
        if NSUserDefaults.standardUserDefaults().boolForKey("didLogin") {
            // Terms have been accepted, proceed as normal
            self.performSegueWithIdentifier("loggedIn", sender: nil)
        } else {
            // Terms have not been accepted. Show terms (perhaps using performSegueWithIdentifier)
        }
    }
    
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
        if(textField == usernameTextField){
            self.passwordTextField.becomeFirstResponder()
        }else{
            textField.resignFirstResponder()
            login()
        }
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        animateViewMoving(true, moveValue: 100)
    }
    func textFieldDidEndEditing(textField: UITextField) {
        animateViewMoving(false, moveValue: 100)
    }
    
    func animateViewMoving (up:Bool, moveValue :CGFloat){
        let movementDuration:NSTimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame = CGRectOffset(self.view.frame, 0,  movement)
        UIView.commitAnimations()
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
                    NSUserDefaults.standardUserDefaults().setBool(true, forKey: "didLogin")
                }
        })
    }
}
