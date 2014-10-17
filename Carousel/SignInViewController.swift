//
//  SignInViewController.swift
//  Carousel
//
//  Created by Mel Ludowise on 10/14/14.
//  Copyright (c) 2014 Mel Ludowise. All rights reserved.
//

import UIKit

// Corresponds to the ID given to this controller on the storyboard
private let kEmail = "mel@melludowise.com"
private let kPassword = "password"

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
        
        // Don't readjust the help text
        automaticallyAdjustsScrollViewInsets = false
        
        // Remove navigation bar shadow
        navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        navigationBar.shadowImage = UIImage()
        
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
        delay(2, { () -> () in
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
        self.navigationController?.popViewControllerAnimated(true)
    }
}
