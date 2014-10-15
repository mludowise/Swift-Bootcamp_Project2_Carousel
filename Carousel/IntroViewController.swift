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
    
    // Points represent the center of the image
    private var tileStartPositions : [CGPoint] = [
        CGPoint(x: -33 + 153/2, y: 471 + 152/2),
        CGPoint(x: 208 + 124/2, y: 473 + 122/2),
        CGPoint(x: 181 + 128/2, y: 379 + 128/2),
        CGPoint(x: 106 + 121/2, y: 478 + 121/2),
        CGPoint(x: -14 + 124/2, y: 371 + 122/2),
        CGPoint(x: 74 + 124/2, y: 386 + 123/2),
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
        signInButton!.layer.borderWidth = 1
        signInButton!.layer.borderColor = kButtonColor
        
        // Set the main view to be below the fold
        mainView!.frame.origin.y = screenSize!.height
        
        // The scrollview should be double the screen height
        scrollView!.contentSize = CGSizeMake(mainView!.frame.width, screenSize!.height * 2)
        
        // Assume the tiles are in their final position in the storyboard. Cache their positions & sizes
        initializeTiles([tileImage1!, tileImage2!, tileImage3!, tileImage4!, tileImage5!, tileImage6!])
    }
    
    override func viewWillAppear(animated: Bool) {
//        <#code#>
    }
    
    func initializeTiles(imageViews : [UIImageView]) {
        for (i, imageView) in enumerate(imageViews) {
            tileImageViews.append(imageView)
            tileEndPositions.append(CGPoint(x: imageView.frame.origin.x + imageView.frame.width / 2,
                y: imageView.frame.origin.y + imageView.frame.height / 2))

            transformImage(i, amount: CGFloat(0))
            
//            print(i)
//            print(": x=")
//            print(imageView.frame.origin.x)
//            print(", y=")
//            print(imageView.frame.origin.y)
//            print(", w=")
//            print(imageView.frame.width)
//            print(", h=")
//            print(imageView.frame.height)
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
}
