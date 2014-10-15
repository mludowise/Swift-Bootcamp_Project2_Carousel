//
//  IntroViewController.swift
//  Carousel
//
//  Created by Mel Ludowise on 10/14/14.
//  Copyright (c) 2014 Mel Ludowise. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var signInButton: UIButton!
    
    private let buttonColor = UIColor(red: 28.0/255, green: 172.0/255, blue: 255.0/255, alpha: 1).CGColor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = CGSizeMake(mainView.frame.width, mainView.frame.height)
        
        signInButton.layer.borderWidth = 2
        signInButton.layer.borderColor = buttonColor
    }
}
