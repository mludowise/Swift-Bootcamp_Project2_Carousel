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
    
    private var tileImageViews : [UIImageView] = []
    
    private var tileTransform : [(scale: CGFloat, rotation: CGFloat)] = [
        (1.0, CGFloat(-10 * M_PI / 180)),
        (1.64, CGFloat(-10 * M_PI / 180)),
        (1.68, CGFloat(10 * M_PI / 180)),
        (1.60, CGFloat(10 * M_PI / 180)),
        (1.64, CGFloat(10 * M_PI / 180)),
        (1.64, CGFloat(-10 * M_PI / 180)),
    ]
    
    private var tileStartPositions : [CGPoint] = [
        CGPoint(x: -33, y: 471),
        CGPoint(x: 208, y: 473),
        CGPoint(x: 181, y: 379),
        CGPoint(x: 106, y: 478),
        CGPoint(x: -14, y: 371),
        CGPoint(x: 74, y: 386),
    ]
    
    private var tileEndPositions : [CGPoint] = []
    
    private var screenSize : CGRect?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Cache screen size
        screenSize = UIScreen.mainScreen().bounds
        
        // Set the scrollview delegate
        scrollView!.delegate = self
        
        // Set the signIn button border programatically because you can't do it in storyboard
        signInButton!.layer.borderWidth = 2
        signInButton!.layer.borderColor = kButtonColor
        
        // Set the main view to be below the fold
        mainView!.frame.origin.y = screenSize!.height
        
        // The scrollview should be double the screen height
        scrollView!.contentSize = CGSizeMake(mainView!.frame.width, screenSize!.height * 2)
        
        // Assume the tiles are in their final position in the storyboard. Cache their positions & sizes
        initializeTiles([tileImage1!, tileImage2!, tileImage3!, tileImage4!, tileImage5!, tileImage6!])
    }
    
    func getTuple() -> (postiion: CGPoint, size:CGSize, rotation: CGFloat) {
        return (CGPoint(x: 0, y: 0), CGSize(width: 0, height: 0), CGFloat(0))
    }
    
    func initializeTiles(imageViews : [UIImageView]) {
        for (i, imageView) in enumerate(imageViews) {
            tileImageViews.append(imageView)
            tileEndPositions.append(imageView.frame.origin)
            transformImage(i, amount: CGFloat(0))
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView!) {
        // Will scroll between 0 and the height of the screen
        var scrollPercentage = scrollView.contentOffset.y / screenSize!.height
        scrollPercentage = max(0, scrollPercentage)
        scrollPercentage = min(1, scrollPercentage)
        for (i, imageView) in enumerate(tileImageViews) {
            transformImage(i, amount: CGFloat(scrollPercentage))
        }
        
    }
    
    func transformImage(index: Int, amount: CGFloat) {
        var imageView = tileImageViews[index]
        var mainViewY = mainView!.frame.origin.y
        imageView.transform = CGAffineTransformMakeTranslation(
            (tileStartPositions[index].x - tileEndPositions[index].x) * (1 - amount),
            (tileStartPositions[index].y - tileEndPositions[index].y - mainViewY) * (1 - amount))
        imageView.transform = CGAffineTransformScale(imageView.transform,
            (tileTransform[index].scale - 1) * (1 - amount) + 1,
            (tileTransform[index].scale - 1) * (1 - amount) + 1)
        imageView.transform = CGAffineTransformRotate(imageView.transform, tileTransform[index].rotation  * (1 - amount))
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
