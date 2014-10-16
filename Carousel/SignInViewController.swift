//
//  SignInViewController.swift
//  Carousel
//
//  Created by Mel Ludowise on 10/14/14.
//  Copyright (c) 2014 Mel Ludowise. All rights reserved.
//

import UIKit


// Corresponds to the ID given to this controller on the storyboard
internal let kWelcomeViewControllerId = "welcomeViewControler"


private let kEmail = "mel@melludowise.com"
private let kPassword = "password"

private let kEmailRequiredTtl = "Email Required"
private let kEmailRequiredMsg = "Please enter your email address."
private let kPassRequiredTtl = "Password Required"
private let kPassRequiredMsg = "Please enter your password."
private let kSigningInTtl = "Signing in..."
private let kSignInFailTtl = "Sign In Failed"
private let kSignInFailMsg = "Incorrect Email or Password."
private let kOkButtonTxt = "OK"

class SignInViewController: MoveWithKeyboardViewController, UITextFieldDelegate, UIAlertViewDelegate {

    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var inputsView: UIView!
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var helpText: UITextView!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordTextField.delegate = self
        
        // Removes bottom shadow on nav bar
        // TODO: fix navigation bar shadow
//        navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        
        // Don't readjust the help text
        automaticallyAdjustsScrollViewInsets = false
        
        setupKeyboardMovement(inputsView, buttonsView: buttonsView, helpText: helpText, navigationBar: navigationBar)
    }
    
    func checkPassword() {
        if (emailTextField.text == "") {
            var alertView = UIAlertView(title: kEmailRequiredTtl, message: kEmailRequiredMsg, delegate: self, cancelButtonTitle: kOkButtonTxt)
            alertView.show()
            return
        }
        if (passwordTextField.text == "") {
            var alertView = UIAlertView(title: kPassRequiredTtl, message: kPassRequiredMsg, delegate: self, cancelButtonTitle: kOkButtonTxt)
            alertView.show()
            return
        }
        
        var alertView = UIAlertView(title: kSigningInTtl, message: nil, delegate: self, cancelButtonTitle: nil)
        alertView.show()
        delay(2, closure: { () -> () in
            alertView.dismissWithClickedButtonIndex(0, animated: true)
            if (self.emailTextField.text == kEmail && self.passwordTextField.text == kPassword) {
                var welcomeViewControler = self.storyboard?.instantiateViewControllerWithIdentifier(kWelcomeViewControllerId) as UIViewController
                self.presentViewController(welcomeViewControler, animated: true, completion: nil)
            } else {
                alertView = UIAlertView(title: kSignInFailTtl, message: kSignInFailMsg, delegate: self, cancelButtonTitle: kOkButtonTxt)
                alertView.show()
            }
        })
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        checkPassword()
        dismissKeyboard()
        return true
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    @IBAction func onTapGesture(sender: AnyObject) {
        dismissKeyboard()
    }
    
    @IBAction func onSwipeGesture(sender: AnyObject) {
        dismissKeyboard()
        println("down swipe")
    }
    
    @IBAction func onSignInButton(sender: AnyObject) {
        checkPassword()
    }
    
    @IBAction func onBackButton(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
}
