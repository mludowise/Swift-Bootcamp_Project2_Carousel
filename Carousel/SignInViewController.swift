//
//  SignInViewController.swift
//  Carousel
//
//  Created by Mel Ludowise on 10/14/14.
//  Copyright (c) 2014 Mel Ludowise. All rights reserved.
//

import UIKit

// Default email & password
internal var userEmail = "mel@melludowise.com"
internal var userPassword = "password"

class SignInViewController: MoveWithKeyboardViewController, UITextFieldDelegate, UIAlertViewDelegate {

    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var inputsView: UIView!
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var helpText: UITextView!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var emailAlertView : UIAlertView?
    var passwordAlertView : UIAlertView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // To detect return key
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        // Don't readjust the help text
        automaticallyAdjustsScrollViewInsets = false
        
        setupKeyboardMovement(inputsView, buttonsView: buttonsView, helpText: helpText, navigationBar: navigationBar)
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if (alertView == emailAlertView) {
            emailTextField.becomeFirstResponder()
        } else if (alertView == passwordAlertView) {
            passwordTextField.becomeFirstResponder()
        }
    }
    
    func checkPassword() {
        if (emailTextField.text == "") {
            emailAlertView = UIAlertView(title: kEmailRequiredTtl, message: kEmailRequiredMsg, delegate: self, cancelButtonTitle: kOkButtonTxt)
            emailAlertView!.show()
            return
        }
        if (passwordTextField.text == "") {
            passwordAlertView = UIAlertView(title: kPassRequiredTtl, message: kPassRequiredMsg, delegate: self, cancelButtonTitle: kOkButtonTxt)
            passwordAlertView!.show()
            return
        }
        
        var alertView = UIAlertView(title: kSigningInTtl, message: nil, delegate: self, cancelButtonTitle: nil)
        alertView.show()
        delay(2, { () -> () in
            alertView.dismissWithClickedButtonIndex(0, animated: true)
            if (self.emailTextField.text == userEmail && self.passwordTextField.text == userPassword) {
                var imageFeedViewController = self.storyboard?.instantiateViewControllerWithIdentifier(kImageFeedNavigationControllerID) as UINavigationController
                self.presentViewController(imageFeedViewController, animated: true, completion: nil)
            } else {
                alertView = UIAlertView(title: kSignInFailTtl, message: kSignInFailMsg, delegate: self, cancelButtonTitle: kOkButtonTxt)
                alertView.show()
            }
        })
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if (textField == emailTextField) {
            passwordTextField.becomeFirstResponder()
        } else { // passwordTextField
            checkPassword()
            dismissKeyboard()
        }
        return true
    }
    
    @IBAction func onTapGesture(sender: AnyObject) {
        dismissKeyboard()
    }
    
    @IBAction func onSwipeGesture(sender: AnyObject) {
        dismissKeyboard()
    }
    
    @IBAction func onSignInButton(sender: AnyObject) {
        checkPassword()
    }
    
    @IBAction func onBackButton(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
        
        var introViewController = navigationController?.viewControllers[0] as IntroViewController
        
        // Make sure view is scrolled to the bottom
        introViewController.scrollToBottom()
    }
}
