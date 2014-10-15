//
//  IntroViewController.swift
//  Carousel
//
//  Created by Mel Ludowise on 10/14/14.
//  Copyright (c) 2014 Mel Ludowise. All rights reserved.
//

import UIKit

private let kButtonColor = UIColor(red: 28.0/255, green: 172.0/255, blue: 255.0/255, alpha: 1).CGColor

class IntroViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView?
    @IBOutlet weak var mainView: UIView?
    
    @IBOutlet weak var signInButton: UIButton?
    
    @IBOutlet weak var tileImage1: UIImageView?
    @IBOutlet weak var tileImage2: UIImageView?
    @IBOutlet weak var tileImage3: UIImageView?
    @IBOutlet weak var tileImage4: UIImageView?
    @IBOutlet weak var tileImage5: UIImageView?
    @IBOutlet weak var tileImage6: UIImageView?
    
//    private var imageViews : [UIImageView]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the signIn button border programatically because you can't do it in storyboard
        signInButton!.layer.borderWidth = 2
        signInButton!.layer.borderColor = kButtonColor
        
        // Set the main view to be below the fold
        var screenHeight = UIScreen.mainScreen().bounds.height
        mainView!.frame.origin.y = screenHeight
        
        // The scrollview should be double the screen height
        scrollView!.contentSize = CGSizeMake(mainView!.frame.width, screenHeight * 2)
        
        // Set the scrollview delegate
        scrollView!.delegate = self
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView!) {
        // Will scroll between -20 and the height of the phone
        
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
