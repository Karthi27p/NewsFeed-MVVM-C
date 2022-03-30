//
//  ArticleDetailViewController.swift
//  NewsFeed
//
//  Created by karthi.palaniappan on 15/02/22.
//

import UIKit
import WebKit

class ArticleDetailViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var progressView: UIProgressView!
    var articleUrl: String = ""
    var itemsToShare: [Any]?
    
    override func loadView() {
        super.loadView()
        webView.navigationDelegate = self
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.init(systemName: "arrowshape.turn.up.forward"), style: .plain, target: self, action: #selector(shareButtonPressed))
        loadWebView(articleUrl: articleUrl)
        // Do any additional setup after loading the view.
    }
    
    func loadWebView(articleUrl: String) {
        if let url = URL(string: articleUrl) {
            webView.load(URLRequest(url: url))
            webView.allowsBackForwardNavigationGestures = true
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?)
    {
        if keyPath == "estimatedProgress" {
            self.progressView.progress = Float(self.webView.estimatedProgress)
            self.progressView.isHidden = self.webView.estimatedProgress == 1.0
        }
    }

    @objc func shareButtonPressed() {
        if let itemsToShare = itemsToShare {
            let activityController = UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)
            self.present(activityController, animated: true, completion: nil)
        }
    }
    
}

extension ArticleDetailViewController: UIActivityItemSource {
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        "Placeholder"
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        itemsToShare?[0]
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, subjectForActivityType activityType: UIActivity.ActivityType?) -> String {
        "Mail Subject"
    }
}
