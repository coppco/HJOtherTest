//
//  DetailViewController.swift
//  03-TwitterSearches
//
//  Created by coco on 16/4/27.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIWebViewDelegate {


    @IBOutlet weak var webView: UIWebView!


    var detailItem: NSURL?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        webView.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if let url = self.detailItem {
            webView .loadRequest(NSURLRequest(URL: url))
        }
    }

    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        webView.stopLoading()
    }
    
    
    //代理方法
    func webViewDidStartLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        webView.loadHTMLString("<html><body><p>An error occurred when performing " + "the Twitter search: " + (error?.description)! + "</body></html>", baseURL: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

