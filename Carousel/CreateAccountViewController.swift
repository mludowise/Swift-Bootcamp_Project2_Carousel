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
    
    @IBOutlet weak var agreeToTermsLabel: UILabel!
    @IBOutlet weak var agreeToTermsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Don't readjust the help text
        automaticallyAdjustsScrollViewInsets = false
        
        // To detect return key
        firstNameField.delegate = self
        lastNameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        
        setupKeyboardMovement(inputsView, buttonsView: buttonsView, helpText: helpText, navigationBar: navigationBar)
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
        if (!agreeToTermsButton.selected) {
            var alertView = UIAlertView(title: kTermsRequiredTtl, message: kTermsRequiredMsg, delegate: self, cancelButtonTitle: kOkButtonTxt)
            alertView.show()
            return
        }
        
        var alertView = UIAlertView(title: kCreatingAccountTtl, message: nil, delegate: self, cancelButtonTitle: nil)
        alertView.show()
        delay(2, { () -> () in
            alertView.dismissWithClickedButtonIndex(0, animated: true)
            var welcomeViewControler = self.storyboard?.instantiateViewControllerWithIdentifier(kWelcomeViewControllerId) as UIViewController
            self.presentViewController(welcomeViewControler, animated: true, completion: nil)
        })
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch(textField) {
        case firstNameField:
            lastNameField.becomeFirstResponder()
        case lastNameField:
            emailField.becomeFirstResponder()
        case emailField:
            passwordField.becomeFirstResponder()
        default: // passwordField
            dismissKeyboard()
            checkFields()
        }
        return true
    }
    
    @IBAction func onCreateButton(sender: AnyObject) {
        dismissKeyboard()
        checkFields()
    }
    
    @IBAction func onBackButton(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
        
        var introViewController = navigationController?.viewControllers[0] as IntroViewController
        
        // Make sure view is scrolled to the bottom
        introViewController.scrollToBottom()
    }
    
    @IBAction func onSwipeGesture(sender: AnyObject) {
        dismissKeyboard()
    }
    
    @IBAction func onAgreeToTermsButton(sender: AnyObject) {
        agreeToTermsButton.selected = !agreeToTermsButton.selected
    }
}
