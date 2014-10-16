//
//  GetStartedViewController.swift
//  Carousel
//
//  Created by Mel Ludowise on 10/15/14.
//  Copyright (c) 2014 Mel Ludowise. All rights reserved.
//

import UIKit

internal var getStartedViewPhoto = true
internal var getStartedUseTimeWheel = false
internal var getStartedSharePhoto = true

class GetStartedViewController: UIViewController {

    @IBOutlet weak var viewPhotoCheck: UIImageView!
    @IBOutlet weak var useTimeWheelCheck: UIImageView!
    @IBOutlet weak var sharePhotoCheck: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (getStartedViewPhoto) {
            viewPhotoCheck.image = UIImage(named:kCheckboxComplete)
        }
        if (getStartedUseTimeWheel) {
            useTimeWheelCheck.image = UIImage(named:kCheckboxComplete)
        }
        if (getStartedSharePhoto) {
            sharePhotoCheck.image = UIImage(named:kCheckboxComplete)
        }
    }
    
    @IBAction func onCloseButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

func shouldHideLearnMoreBanner() -> Bool {
    return getStartedViewPhoto && getStartedUseTimeWheel && getStartedSharePhoto
}