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
    @IBOutlet weak var scrubberImage: UIImageView!
    
    private var screenSize : CGRect!
    
    private var startScrollPos : CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Cache screen size
        screenSize = UIScreen.mainScreen().bounds
        
        scrollView.contentSize = CGSize(width: screenSize.width, height: feedView.frame.height + banner.frame.height)
//        scrubberImage.userInteractionEnabled = true
    }
    
    func dismissBanner() {
        UIView.animateWithDuration(0.5, animations: {
            self.banner.frame.offset(dx: -self.banner.frame.width, dy: 0)
            }, completion: { (b: Bool) -> Void in
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    if (!shouldShowLearnMoreBanner()) {
                        self.hideBanner()
                    }
                })
        })
    }
    
    func hideBanner() {
        self.feedView.frame.offset(dx: 0, dy: -self.banner.frame.height)
        self.scrollView.contentSize = CGSize (width: self.screenSize.width, height: self.feedView.frame.height)
    }
    
    @IBAction func onBannerXButton(sender: AnyObject) {
        dismissBanner()
    }
    
    @IBAction func onBannerSwipe(sender: UISwipeGestureRecognizer) {
        dismissBanner()
    }
    
    @IBAction func onScrubberPanGesture(recognizer: UIPanGestureRecognizer) {
        if (recognizer.state == UIGestureRecognizerState.Began) {
            startScrollPos = scrollView.contentOffset.y
        }
        
        var translation = recognizer.translationInView(scrubberImage)
        var scrollableHeight = scrollView.contentSize.height - screenSize.height
        var ratio = translation.x / scrubberImage.frame.width
        var offset = ratio * scrollableHeight
        var newScrollPos = startScrollPos + offset
        newScrollPos = min(newScrollPos, scrollableHeight)
        newScrollPos = max(newScrollPos, 0)
        scrollView.contentOffset.y = newScrollPos
        
        // Mark that we've used the timewheel for the Get started page
        getStartedUseTimeWheel = true
    }
}
