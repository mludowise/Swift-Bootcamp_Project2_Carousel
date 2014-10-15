//
//  SignInViewController.swift
//  Carousel
//
//  Created by Mel Ludowise on 10/14/14.
//  Copyright (c) 2014 Mel Ludowise. All rights reserved.
//

import UIKit

private let kEmail = "mludowise@gmail.com"
private let kPassword = "password"

class SignInViewController: UIViewController {

    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var inputsView: UIView!
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var helpText: UITextView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private var inputsViewOrigin : CGPoint?
    private var buttonsViewOrigin : CGPoint?
    private var screenSize : CGRect?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Removes bottom shadow on nav bar
//        navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        
        // Don't readjust the help text
        automaticallyAdjustsScrollViewInsets = false
        
        // Get the original positions of the button and input views
        buttonsViewOrigin = buttonsView.frame.origin
        inputsViewOrigin = inputsView.frame.origin
        
        // Setup listeners for keyboard
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
        // Cache screen size
        screenSize = UIScreen.mainScreen().bounds
    }
    
    func signIn() {
        
        if (emailTextField.text == kEmail && passwordTextField.text == kPassword) {
            // We're good to go
        } else {
            // Show error
        }
    }

    func keyboardWillShow(notification: NSNotification!) {
        var userInfo = notification.userInfo!
        
        // Get the keyboard height and width from the notification
        // Size varies depending on OS, language, orientation
        var kbSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as NSValue).CGRectValue().size
        
        var durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey] as NSNumber
        var animationDuration = durationValue.doubleValue
        var curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey] as NSNumber
        var animationCurve = curveValue.integerValue
        
        UIView.animateWithDuration(animationDuration, delay: 0.0, options: UIViewAnimationOptions.fromRaw(UInt(animationCurve << 16))!, animations: {
            // We want the bottom of the buttons to align with the top of the keyboard
            var buttonsViewHeight = self.buttonsView.frame.height
            self.buttonsView.frame.origin.y = self.screenSize!.height - kbSize.height - buttonsViewHeight
            
            // We also want the inputs to move up such that the help text is hidden behind the nav (the bottom of the sign in message should be the same as the bottom of the nav)
            var helpTextY = self.helpText.frame.origin.y
            var helpTextHeight = self.helpText.frame.height
            var navBarHeight = self.navigationBar.frame.height
            self.inputsView.frame.origin.y = navBarHeight - helpTextY - helpTextHeight
            
            }, completion: nil)
    }
    
    func keyboardWillHide(notification: NSNotification!) {
        var userInfo = notification.userInfo!
        
        // Get the keyboard height and width from the notification
        // Size varies depending on OS, language, orientation
        var kbSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as NSValue).CGRectValue().size
        var durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey] as NSNumber
        var animationDuration = durationValue.doubleValue
        var curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey] as NSNumber
        var animationCurve = curveValue.integerValue
        
        UIView.animateWithDuration(animationDuration, delay: 0.0, options: UIViewAnimationOptions.fromRaw(UInt(animationCurve << 16))!, animations: {
            // Reset the y positions back to where they were before
            self.buttonsView.frame.origin = self.buttonsViewOrigin!
            self.inputsView.frame.origin = self.inputsViewOrigin!
            }, completion: nil)
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
}
