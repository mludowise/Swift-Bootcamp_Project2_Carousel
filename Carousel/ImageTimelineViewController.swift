//
//  ImageTimelineViewController.swift
//  Carousel
//
//  Created by Mel Ludowise on 10/15/14.
//  Copyright (c) 2014 Mel Ludowise. All rights reserved.
//

import UIKit

class ImageTimelineViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var banner: UIView!
    @IBOutlet weak var feedView: UIImageView!
    
    private var screenSize : CGRect!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Cache screen size
        screenSize = UIScreen.mainScreen().bounds
        scrollView.contentSize = CGSize(width: 320, height: 1608)
        
//        scrollView.contentSize = CGSize(width: screenSize.width, height: feedView.frame.height + banner.frame.height)
    }
    
    @IBAction func onBannerXButton(sender: AnyObject) {
        
    }
}
