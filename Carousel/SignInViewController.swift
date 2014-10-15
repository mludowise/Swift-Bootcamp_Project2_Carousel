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

class SignInViewController: UIViewController, UITextFieldDelegate, UIAlertViewDelegate, UIScrollViewDelegate {

    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var inputsView: UIView!
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var helpText: UITextView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private var inputsViewOrigin : CGPoint?
    private var buttonsViewOrigin : CGPoint?
    private var screenSize : CGRect?
    
    private var initialScrollPos : CGPoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordTextField.delegate = self
        
        // Removes bottom shadow on nav bar
        // TODO: fix navigation bar shadow
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
    
    func checkPassword() {
        if (emailTextField.text == "") {
            var alertView = UIAlertView(title: "Email Required", message: "Please enter your email address.", delegate: self, cancelButtonTitle: "OK")
            alertView.show()
            return
        }
        if (passwordTextField.text == "") {
            var alertView = UIAlertView(title: "Password Required", message: "Please enter your password.", delegate: self, cancelButtonTitle: "OK")
            alertView.show()
            return
        }
        
        var alertView = UIAlertView(title: "Signing in...", message: nil, delegate: self, cancelButtonTitle: nil)
        alertView.show()
        delay(2, closure: { () -> () in
            alertView.dismissWithClickedButtonIndex(0, animated: true)
            if (self.emailTextField.text == kEmail && self.passwordTextField.text == kPassword) {
                println("Authentication Success!")
                var welcomeViewControler = self.storyboard?.instantiateViewControllerWithIdentifier("welcomeViewControler1") as UIViewController
                self.presentViewController(welcomeViewControler, animated: true, completion: nil)
            } else {
                alertView = UIAlertView(title: "Sign In Failed", message: "Incorrect Email or Password.", delegate: self, cancelButtonTitle: "OK")
                alertView.show()
            }
        })
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
