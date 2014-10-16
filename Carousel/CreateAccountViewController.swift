//
//  CreateAccountViewController.swift
//  Carousel
//
//  Created by Mel Ludowise on 10/15/14.
//  Copyright (c) 2014 Mel Ludowise. All rights reserved.
//

import UIKit

class CreateAccountViewController: MoveWithKeyboardViewController {

    @IBOutlet weak var helpText: UITextView!
    @IBOutlet weak var inputsView: UIView!
    @IBOutlet weak var ButtonsView: UIView!
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onCreateButton(sender: AnyObject) {
    }
}
