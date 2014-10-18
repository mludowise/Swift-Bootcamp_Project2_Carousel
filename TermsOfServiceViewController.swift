//
//  TermsOfServiceViewController.swift
//  Carousel
//
//  Created by Mel Ludowise on 10/15/14.
//  Copyright (c) 2014 Mel Ludowise. All rights reserved.
//

import UIKit

private var kTermsURL = "https://www.dropbox.com/terms?mobile=1"

class TermsOfServiceViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        var url = NSURL.URLWithString(kTermsURL)
        var urlRequest = NSURLRequest(URL: url)
        webView.loadRequest(urlRequest)
    }
    
    @IBAction func onDoneButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
