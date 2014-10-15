//
//  IntroViewController.swift
//  Carousel
//
//  Created by Mel Ludowise on 10/14/14.
//  Copyright (c) 2014 Mel Ludowise. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var signInButton: UIButton!
    
    private let buttonColor = UIColor(red: 28.0/255, green: 172.0/255, blue: 255.0/255, alpha: 1).CGColor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the signIn button border programatically because you can't do it in storyboard
        signInButton.layer.borderWidth = 2
        signInButton.layer.borderColor = buttonColor

        scrollView.contentSize = CGSizeMake(mainView.frame.width, mainView.frame.height)
        scrollView.delegate = self
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView!) {
        println(scrollView.contentOffset)
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView!) {
        
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView!,
        willDecelerate decelerate: Bool) {
            // This method is called right as the user lifts their finger
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView!) {
        // This method is called when the scrollview finally stops scrolling.
    }

}
