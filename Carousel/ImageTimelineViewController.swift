//
//  ImageTimelineViewController.swift
//  Carousel
//
//  Created by Mel Ludowise on 10/15/14.
//  Copyright (c) 2014 Mel Ludowise. All rights reserved.
//

import UIKit

internal var getStartedViewPhoto = false
internal var getStartedUseTimeWheel = false
internal var getStartedSharePhoto = false

class ImageTimelineViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var banner: UIView!
    @IBOutlet weak var feedView: UIView!
    @IBOutlet weak var scrubberImage: UIImageView!
    
    @IBOutlet weak var fullScreenImageView: UIImageView!
    @IBOutlet weak var imageBackgroundView: UIView!
    @IBOutlet var backgroundTapGestureRecognizer: UITapGestureRecognizer!
    
    @IBOutlet weak var taskCompletedCheckImageView: UIImageView!
    
    private var screenSize : CGRect!
    private var startScrollPos : CGFloat!
    private var thumbnailImageView : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Cache screen size
        screenSize = UIScreen.mainScreen().bounds
        
        // Size scrollview
        scrollView.contentSize = CGSize(width: screenSize.width, height: feedView.frame.height)
        
        // Hide banner if all tasks have been completed
        if (checkIfCompletedAllGetStartedTasks()) {
            self.banner.hidden = true
            self.scrollView.frame.origin.y = 0
        }
        
        // Center checkmark
        taskCompletedCheckImageView.frame.origin.x = (screenSize.width - taskCompletedCheckImageView.frame.width) / 2
        taskCompletedCheckImageView.frame.origin.y = (screenSize.height - taskCompletedCheckImageView.frame.height) / 2
    }
    
    func dismissBanner() {
        if (!banner.hidden) {
            UIView.animateWithDuration(0.5, animations: {
                self.banner.frame.offset(dx: -self.banner.frame.width, dy: 0)
                }, completion: { (b: Bool) -> Void in
                    UIView.animateWithDuration(0.25, animations: { () -> Void in
                        self.scrollView.frame.origin.y -= self.banner.frame.height
                        self.scrollView.frame.size.height += self.banner.frame.height
                    })
            })
        }
    }
    
    func showTaskCompletion(completion: (() -> Void)?) {
        // Unhide checkmark
        taskCompletedCheckImageView.hidden = false
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            // Fade In
            self.taskCompletedCheckImageView.alpha = 1
            
            // Show at 150%
            self.taskCompletedCheckImageView.transform = CGAffineTransformMakeScale(1.25, 1.25)
            }) { (completed: Bool) -> Void in
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    // Fade Out
                    self.taskCompletedCheckImageView.alpha = 0
                    
                    // Show at 100%
                    self.taskCompletedCheckImageView.transform = CGAffineTransformMakeScale(1, 1)
                    }, completion: { (completed: Bool) -> Void in
                        // Hide again
                        self.taskCompletedCheckImageView.hidden = true
                        
                        if (completion != nil) {
                            completion!()
                        }
                })
        }
    }
    
    func completedViewPhoto() {
        if (!getStartedViewPhoto) {
            getStartedViewPhoto = true
            showTaskCompletion(nil)
        }
    }
    
    func completedUseTimeWheel(completion: (() -> Void)?) {
        if (!getStartedUseTimeWheel) {
            getStartedUseTimeWheel = true
            showTaskCompletion(completion)
        }
    }
    
    func completedSharePhoto() {
        if (!getStartedSharePhoto) {
            getStartedSharePhoto = true
            showTaskCompletion(nil)
        }
    }
    
    func checkIfCompletedAllGetStartedTasks() -> Bool {
        return getStartedViewPhoto && getStartedUseTimeWheel && getStartedSharePhoto
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
        var offset = -ratio * scrollableHeight
        var newScrollPos = startScrollPos + offset
        newScrollPos = min(newScrollPos, scrollableHeight)
        newScrollPos = max(newScrollPos, -navBarHeight)
        scrollView.contentOffset.y = newScrollPos
        
        
        // Mark that we've used the timewheel for the Get started page
        if (recognizer.state == UIGestureRecognizerState.Ended && !getStartedUseTimeWheel) {
            completedUseTimeWheel({ () -> Void in
                if (self.checkIfCompletedAllGetStartedTasks()) {
                    self.dismissBanner()
                }
            })
        }
    }
    
    @IBAction func onImageTapGesture(tapGestureRecognizer: UITapGestureRecognizer) {
        // Set the fullScreenImage to be the same size, position, & image as the thumbnail
        thumbnailImageView = tapGestureRecognizer.view as UIImageView
        var newOrigin = view.convertPoint(thumbnailImageView.frame.origin, fromView: thumbnailImageView.superview?)
        fullScreenImageView.frame = CGRect(origin: newOrigin, size: thumbnailImageView.frame.size)
        fullScreenImageView.image = thumbnailImageView.image
        
        // Unhide these
        fullScreenImageView.hidden = false
        imageBackgroundView.hidden = false
        
        // Get navBar for fade out
        var navBar = navigationController?.navigationBar
        
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            // Fade in background some
            self.imageBackgroundView.alpha = 0.25
            
            // Fade out nav bar some
            if (navBar != nil) {
                navBar!.alpha = 0.5
            }
            
            var imageSize = self.thumbnailImageView.image!.size
            
            // First, resize the image so it's not cropped
            if (imageSize.height > imageSize.width) {
                self.fullScreenImageView.frame.size.height = imageSize.height / imageSize.width * self.fullScreenImageView.frame.width
                self.fullScreenImageView.frame.origin.y -= (self.fullScreenImageView.frame.height - self.fullScreenImageView.frame.width)/2
            } else {
                self.fullScreenImageView.frame.size.width = imageSize.width / imageSize.height * self.fullScreenImageView.frame.width
                self.fullScreenImageView.frame.origin.x -= (self.fullScreenImageView.frame.width - self.fullScreenImageView.frame.height)/2
            }
            }, completion: { (completed: Bool) -> Void in
                UIView.animateWithDuration(0.75, animations: { () -> Void in
                    // Fade out nav bar all the way
                    if (navBar != nil) {
                        navBar!.alpha = 0
                    }
                    
                    // Fade in background all the way
                    self.imageBackgroundView.alpha = 1
                    
                    // Resize image to full screen
                    self.fullScreenImageView.contentMode = UIViewContentMode.ScaleAspectFit
                    self.fullScreenImageView.frame.size.width = self.screenSize.width
                    self.fullScreenImageView.frame.size.height = self.screenSize.height
                    self.fullScreenImageView.frame.origin.y = 0
                    self.fullScreenImageView.frame.origin.x = 0
                }, completion: { (completed: Bool) -> Void in
                    if (navBar != nil) {
                        navBar!.hidden = true
                    }
                    
                    // Mark that user has finished viewing image
                    self.completedViewPhoto()
                })
        })
    }
    
    @IBAction func onFullScreenImageTapGesture(tapGestureRecognizer: UITapGestureRecognizer) {
        // Figure out thumbnail position
        var newOrigin = view.convertPoint(thumbnailImageView.frame.origin, fromView: thumbnailImageView.superview?)
        var thumbnailImageFrame = CGRect(origin: newOrigin, size: thumbnailImageView.frame.size)
        
        // Get navBar for fade in
        var navBar = navigationController?.navigationBar
        if (navBar != nil) {
            navBar!.hidden = false
        }
        
        UIView.animateWithDuration(0.75, animations: { () -> Void in
            // Fade in nav bar some
            if (navBar != nil) {
                navBar!.alpha = 0.5
            }
            
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
            }, completion: { (completed: Bool) -> Void in
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    // Fade in nav bar all the way
                    if (navBar != nil) {
                        navBar!.alpha = 1
                    }
                    
                    // Fade out background all the way
                    self.imageBackgroundView.alpha = 0
                    
                    // Crop image back to sqaure
                    self.fullScreenImageView.contentMode = UIViewContentMode.ScaleAspectFill
                    self.fullScreenImageView.frame.size.width = thumbnailImageFrame.width
                    self.fullScreenImageView.frame.size.height = thumbnailImageFrame.height
                    self.fullScreenImageView.frame.origin.x = thumbnailImageFrame.origin.x
                    self.fullScreenImageView.frame.origin.y = thumbnailImageFrame.origin.y
                    }, completion: { (completed: Bool) -> Void in
                        
                        // Hide these
                        self.fullScreenImageView.hidden = true
                        self.imageBackgroundView.hidden = true
                        
                        if(self.checkIfCompletedAllGetStartedTasks()) {
                            self.dismissBanner()
                        }
                    })
        })
    }

    @IBAction func swipeUpOnImage(sender: AnyObject) {
        if (thumbnailImageView != nil) {
            let activityViewController = UIActivityViewController(activityItems: [thumbnailImageView.image!], applicationActivities: nil)
            activityViewController.completionHandler = { (activityType: String?, completed: Bool) -> Void in
                // Mark that user shared image
                self.completedSharePhoto()
            }
            self.presentViewController(activityViewController, animated: true, completion: nil)
        }
    }
    
}
