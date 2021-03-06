//
//  WelcomeViewController.swift
//  Carousel
//
//  Created by Mel Ludowise on 10/15/14.
//  Copyright (c) 2014 Mel Ludowise. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var welcomeView1: UIView!
    @IBOutlet weak var welcomeView2: UIView!
    @IBOutlet weak var welcomeView3: UIView!
    @IBOutlet weak var welcomeView4: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var buttonControlView: UIView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var screenSize : CGRect!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self

        // Cache screen size
        screenSize = UIScreen.mainScreen().bounds
        
        scrollView.contentSize = CGSize(width: screenSize.width * 4, height: screenSize.height)
        welcomeView1.frame.size.width = screenSize.width
        welcomeView2.frame.size.width = screenSize.width
        welcomeView3.frame.size.width = screenSize.width
        welcomeView4.frame.size.width = screenSize.width
    }
    
    override func viewDidDisappear(animated: Bool) {
        activityIndicator.stopAnimating()
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView!) {
        // Get the current page based on the scroll offset
        var page : Int = Int(round(scrollView.contentOffset.x / screenSize.width))
        
        // Set the current page, so the dots will update
        pageControl.currentPage = page
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // Fade In Button Controls
        var alpha = max(0, scrollView.contentOffset.x - screenSize.width * 2) / screenSize.width
        buttonControlView.alpha = alpha
        pageControl.alpha = 1-alpha
    }
    
    @IBAction func onTakeForASpinButton(sender: AnyObject) {
        activityIndicator.startAnimating()
    }
}
