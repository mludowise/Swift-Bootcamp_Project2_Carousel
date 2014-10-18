//
//  ForgotPasswordViewController.swift
//  Carousel
//
//  Created by Mel Ludowise on 10/17/14.
//  Copyright (c) 2014 Mel Ludowise. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // To detect return key
        emailTextField.delegate = self

        // Remove navigation bar shadow
        navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        navigationBar.shadowImage = UIImage()
    }
    
    override func viewDidAppear(animated: Bool) {
        // Focus email input
        emailTextField.becomeFirstResponder()
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
            view.endEditing(true)
            submit()
        return true
    }
    
    func submit() {
        if (emailTextField.text == "") {
            var alertView = UIAlertView(title: kEmailRequiredTtl, message: kEmailRequiredMsg, delegate: self, cancelButtonTitle: kOkButtonTxt)
            alertView.show()
            return
        }
        var alertView = UIAlertView(title: kForgotPassTtl, message: nil, delegate: self, cancelButtonTitle: nil)
        alertView.show()
        delay(1, { () -> () in
            alertView.dismissWithClickedButtonIndex(0, animated: true)
            self.navigationController?.popViewControllerAnimated(true)
        })
    }
    
    @IBAction func onSendButton(sender: AnyObject) {
        submit()
    }
    
    @IBAction func onBackButton(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
}
