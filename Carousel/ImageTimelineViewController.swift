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
    @IBOutlet weak var feedView: UIView!
    @IBOutlet weak var scrubberImage: UIImageView!
    
    @IBOutlet weak var fullScreenImageView: UIImageView!
    @IBOutlet weak var imageBackgroundView: UIView!
    @IBOutlet var backgroundTapGestureRecognizer: UITapGestureRecognizer!
    
    private var screenSize : CGRect!
    
    private var startScrollPos : CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Cache screen size
        screenSize = UIScreen.mainScreen().bounds
        
        // Size scrollview
        scrollView.contentSize = CGSize(width: screenSize.width, height: feedView.frame.height + banner.frame.height)
    }
    
    func dismissBanner() {
        UIView.animateWithDuration(0.5, animations: {
            self.banner.frame.offset(dx: -self.banner.frame.width, dy: 0)
            }, completion: { (b: Bool) -> Void in
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    if (shouldHideLearnMoreBanner()) {
                        self.feedView.frame.offset(dx: 0, dy: -self.banner.frame.height)
                        self.scrollView.contentSize = CGSize (width: self.screenSize.width, height: self.feedView.frame.height)
                    }
                })
        })
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
        var navBar = navigationController?.navigationBar
        var navBarHeight = navBar == nil ? 0 : navBar!.frame.size.height + navBar!.frame.origin.y
        var scrollableHeight = scrollView.contentSize.height - screenSize.height + navBarHeight
        var ratio = translation.x / scrubberImage.frame.width
        var offset = ratio * scrollableHeight
        var newScrollPos = startScrollPos + offset
        newScrollPos = min(newScrollPos, scrollableHeight)
        newScrollPos = max(newScrollPos, -navBarHeight)
        scrollView.contentOffset.y = newScrollPos
        
        
        if (recognizer.state == UIGestureRecognizerState.Ended) {
            println("end")
        }
        // Mark that we've used the timewheel for the Get started page
        if (recognizer.state == UIGestureRecognizerState.Ended && !getStartedUseTimeWheel) {
            getStartedUseTimeWheel = true
            print("checking banner")
            if (shouldHideLearnMoreBanner()) {
                dismissBanner()
            }
        }
    }
    
    var thumbnailImageView : UIImageView!

    @IBAction func onImageTapGesture(tapGestureRecognizer: UITapGestureRecognizer) {
        // Set the fullScreenImage to be the same size, position, & image as the thumbnail
        thumbnailImageView = tapGestureRecognizer.view as UIImageView
        var newOrigin = view.convertPoint(thumbnailImageView.frame.origin, fromView: thumbnailImageView.superview?)
        fullScreenImageView.frame = CGRect(origin: newOrigin, size: thumbnailImageView.frame.size)
        fullScreenImageView.image = thumbnailImageView.image
        
        // Unhide these
        fullScreenImageView.hidden = false
        imageBackgroundView.hidden = false
        
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            // Fade in background some
            self.imageBackgroundView.alpha = 0.25
            
            var imageSize = self.thumbnailImageView.image!.size
            
            // First, resize the image so it's not cropped
            if (imageSize.height > imageSize.width) {
                self.fullScreenImageView.frame.size.height = imageSize.height / imageSize.width * self.fullScreenImageView.frame.width
                self.fullScreenImageView.frame.origin.y -= (self.fullScreenImageView.frame.height - self.fullScreenImageView.frame.width)/2
            } else {
                self.fullScreenImageView.frame.size.width = imageSize.width / imageSize.height * self.fullScreenImageView.frame.width
                self.fullScreenImageView.frame.origin.x -= (self.fullScreenImageView.frame.width - self.fullScreenImageView.frame.height)/2
            }
            }, completion: { (b:Bool) -> Void in
                UIView.animateWithDuration(0.75, animations: { () -> Void in
                    
                    // Fade in background all the way
                    self.imageBackgroundView.alpha = 1
                    
                    // Resize image to full screen
                    self.fullScreenImageView.contentMode = UIViewContentMode.ScaleAspectFit
                    self.fullScreenImageView.frame.size.width = self.screenSize.width
                    self.fullScreenImageView.frame.size.height = self.screenSize.height
                    self.fullScreenImageView.frame.origin.y = 0
                    self.fullScreenImageView.frame.origin.x = 0
                })
        })
    }
    
    @IBAction func onFullScreenImageTapGesture(tapGestureRecognizer: UITapGestureRecognizer) {
        // Figure out thumbnail position
        var newOrigin = view.convertPoint(thumbnailImageView.frame.origin, fromView: thumbnailImageView.superview?)
        var thumbnailImageFrame = CGRect(origin: newOrigin, size: thumbnailImageView.frame.size)
        
        UIView.animateWithDuration(0.75, animations: { () -> Void in
            // Fade out background some
            self.imageBackgroundView.alpha = 0.75
            
            // First, resize image back to the size of the uncropped thumbnail
            var imageSize = self.fullScreenImageView.image!.size
            if (imageSize.height > imageSize.width) {
                self.fullScreenImageView.frame.size.width = thumbnailImageFrame.width
                self.fullScreenImageView.frame.size.height = imageSize.height / imageSize.width * thumbnailImageFrame.width
                self.fullScreenImageView.frame.origin.y = thumbnailImageFrame.origin.y - (self.fullScreenImageView.frame.height - self.fullScreenImageView.frame.width)/2
                self.fullScreenImageView.frame.origin.x = thumbnailImageFrame.origin.x
            } else {
                self.fullScreenImageView.frame.size.height = thumbnailImageFrame.height
                self.fullScreenImageView.frame.size.width = imageSize.width / imageSize.height * thumbnailImageFrame.width
                self.fullScreenImageView.frame.origin.x = thumbnailImageFrame.origin.x - (self.fullScreenImageView.frame.width - self.fullScreenImageView.frame.height)/2
                self.fullScreenImageView.frame.origin.y = thumbnailImageFrame.origin.y
            }
            }, completion: { (b:Bool) -> Void in
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    // Fade out background all the way
                    self.imageBackgroundView.alpha = 0.25
                    
                    // Crop image back to sqaure
                    self.fullScreenImageView.contentMode = UIViewContentMode.ScaleAspectFill
                    self.fullScreenImageView.frame.size.width = thumbnailImageFrame.width
                    self.fullScreenImageView.frame.size.height = thumbnailImageFrame.height
                    self.fullScreenImageView.frame.origin.x = thumbnailImageFrame.origin.x
                    self.fullScreenImageView.frame.origin.y = thumbnailImageFrame.origin.y
                    }, completion: { (b:Bool) -> Void in
                        
                        // Hide these
                        self.fullScreenImageView.hidden = true
                        self.imageBackgroundView.hidden = true
                    })
        })
    }
    
}
