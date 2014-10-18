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
    
    var firstNameAlertView : UIAlertView?
    var lastNameAlertView : UIAlertView?
    var emailAlertView : UIAlertView?
    var passwordAlertView : UIAlertView?
    
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
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if (alertView == firstNameAlertView) {
            firstNameField.becomeFirstResponder()
        } else if (alertView == lastNameAlertView) {
            lastNameField.becomeFirstResponder()
        } else if (alertView == emailAlertView) {
            emailField.becomeFirstResponder()
        } else if (alertView == passwordAlertView) {
            passwordField.becomeFirstResponder()
        }
    }
    
    func checkFields() {
        if (firstNameField.text == "") {
            firstNameAlertView = UIAlertView(title: kFirstNameRequiredTtl, message: kFirstNameRequiredMsg, delegate: self, cancelButtonTitle: kOkButtonTxt)
            firstNameAlertView!.show()
            return
        }
        if (lastNameField.text == "") {
            lastNameAlertView = UIAlertView(title: kLastNameRequiredTtl, message: kLastNameRequiredMsg, delegate: self, cancelButtonTitle: kOkButtonTxt)
            lastNameAlertView!.show()
            return
        }
        if (emailField.text == "") {
            emailAlertView = UIAlertView(title: kEmailRequiredTtl, message: kEmailRequiredMsg, delegate: self, cancelButtonTitle: kOkButtonTxt)
            emailAlertView!.show()
            return
        }
        if (passwordField.text == "") {
            passwordAlertView = UIAlertView(title: kPassRequiredTtl, message: kPassRequiredMsg, delegate: self, cancelButtonTitle: kOkButtonTxt)
            passwordAlertView!.show()
            return
        }
        if (!agreeToTermsButton.selected) {
            var agreeToTermsAlertView = UIAlertView(title: kTermsRequiredTtl, message: kTermsRequiredMsg, delegate: nil, cancelButtonTitle: kOkButtonTxt)
            agreeToTermsAlertView.show()
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
            break
        case lastNameField:
            emailField.becomeFirstResponder()
            break
        case emailField:
            passwordField.becomeFirstResponder()
            break
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
