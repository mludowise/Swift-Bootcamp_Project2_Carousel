//
//  CreateAccountViewController.swift
//  Carousel
//
//  Created by Mel Ludowise on 10/15/14.
//  Copyright (c) 2014 Mel Ludowise. All rights reserved.
//

import UIKit

class CreateAccountViewController: MoveWithKeyboardViewController, UITextFieldDelegate, UIAlertViewDelegate {

    @IBOutlet weak var helpText: UITextView!
    @IBOutlet weak var inputsView: UIView!
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Don't readjust the help text
        automaticallyAdjustsScrollViewInsets = false
        
        passwordField.delegate = self
                
        setupKeyboardMovement(inputsView, buttonsView: buttonsView, helpText: helpText, navigationBar: navigationBar)
    }
    
    func alertView(alertView: UIAlertView!, clickedButtonAtIndex buttonIndex: Int) {
        if (buttonIndex == 0) { // I Agree
            var alertView = UIAlertView(title: kCreatingAccountTtl, message: nil, delegate: self, cancelButtonTitle: nil)
            alertView.show()
            delay(2, { () -> () in
                alertView.dismissWithClickedButtonIndex(0, animated: true)
                var welcomeViewControler = self.storyboard?.instantiateViewControllerWithIdentifier(kWelcomeViewControllerId) as UIViewController
                self.presentViewController(welcomeViewControler, animated: true, completion: nil)
            })
        } else { // View Terms
            var termsOfServiceController = storyboard?.instantiateViewControllerWithIdentifier(termsOfServiceViewControllerID) as UIViewController
            presentViewController(termsOfServiceController, animated: true, completion: nil)
        }
    }
    
    func checkFields() {
        if (firstNameField.text == "") {
            var alertView = UIAlertView(title: kFirstNameRequiredTtl, message: kFirstNameRequiredMsg, delegate: nil, cancelButtonTitle: kOkButtonTxt)
            alertView.show()
            return
        }
        if (lastNameField.text == "") {
            var alertView = UIAlertView(title: kLastNameRequiredTtl, message: kLastNameRequiredMsg, delegate: nil, cancelButtonTitle: kOkButtonTxt)
            alertView.show()
            return
        }
        if (emailField.text == "") {
            var alertView = UIAlertView(title: kEmailRequiredTtl, message: kEmailRequiredMsg, delegate: nil, cancelButtonTitle: kOkButtonTxt)
            alertView.show()
            return
        }
        if (passwordField.text == "") {
            var alertView = UIAlertView(title: kPassRequiredTtl, message: kPassRequiredMsg, delegate: nil, cancelButtonTitle: kOkButtonTxt)
            alertView.show()
            return
        }
        
        var alertView = UIAlertView(title: "", message: kTermsMsg, delegate: self, cancelButtonTitle: kAgreeButtonTxt, otherButtonTitles: kViewTermsButtonTxt)
        alertView.show()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        dismissKeyboard()
        checkFields()
        return true
    }
    
    @IBAction func onCreateButton(sender: AnyObject) {
        dismissKeyboard()
        checkFields()
    }
    
    @IBAction func onBackButton(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func onSwipeGesture(sender: AnyObject) {
        dismissKeyboard()
    }
}
