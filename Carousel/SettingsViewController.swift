//
//  SettingsViewController.swift
//  Carousel
//
//  Created by Mel Ludowise on 10/15/14.
//  Copyright (c) 2014 Mel Ludowise. All rights reserved.
//

import UIKit

private let kSignInViewControllerID = "signInViewController"
private let kIntroNavigationControllerID = "introNavigationController"
private let kIntroViewControllerID = "introViewController"

class SettingsViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onCloseButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onSignOutButton(sender: AnyObject) {
        var navigationController = storyboard?.instantiateViewControllerWithIdentifier(kIntroNavigationControllerID) as UINavigationController
        presentViewController(navigationController, animated: true) { () -> Void in
            var signInViewController = self.storyboard?.instantiateViewControllerWithIdentifier(kSignInViewControllerID) as UIViewController
            navigationController.pushViewController(signInViewController, animated: true)
        }
    }
}
