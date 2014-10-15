//
//  IntroViewController.swift
//  Carousel
//
//  Created by Mel Ludowise on 10/14/14.
//  Copyright (c) 2014 Mel Ludowise. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {

    @IBOutlet weak var introImage: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = CGSizeMake(320, introImage.image!.size.height)
    }
//    
//    override func viewDidAppear(animated: Bool) {
//        super.viewDidAppear(animated)
//        
//        scrollView.contentInset.top = 0
//        scrollView.contentInset.bottom = 50
//        scrollView.scrollIndicatorInsets.top = 0
//        scrollView.scrollIndicatorInsets.bottom = 50
//    }
}
