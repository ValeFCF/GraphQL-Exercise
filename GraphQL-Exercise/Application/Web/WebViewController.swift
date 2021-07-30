//
//  WebViewController.swift
//  GraphQL-Exercise
//
//  Created by Valentín Granados on 17/07/21.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    private let url: URL
    
    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var webView: WKWebView!
    
    private let innerView = WebViewLoading()
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        view = innerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myRequest = URLRequest(url: url)
        webView.load(myRequest)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        view = webView
    }
}
