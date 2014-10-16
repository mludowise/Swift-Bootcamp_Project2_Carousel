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
    @IBOutlet weak var ButtonsView: UIView!
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
        
        setupKeyboardMovement(inputsView, buttonsView: ButtonsView, helpText: helpText, navigationBar: navigationBar)
    }
    
    func showTerms() {
        var alertView = UIAlertView(title: "", message: kTermsMsg, delegate: self, cancelButtonTitle: kAgreeButtonTxt, otherButtonTitles: kViewTermsButtonTxt)
        alertView.show()
    }
    
    func alertView(alertView: UIAlertView!, clickedButtonAtIndex buttonIndex: Int) {
        // buttonIndex is 0 for Cancel
        // buttonIndex ranges from 1-n for the other buttons.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        showTerms()
        dismissKeyboard()
        return true
    }
    
    @IBAction func onCreateButton(sender: AnyObject) {
        showTerms()
    }
    
    @IBAction func onBackButton(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
}
