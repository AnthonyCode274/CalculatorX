//
//  HTMLStringReader.swift
//  ThietThachClient
//
//  Created by HauNguyen on 06/07/2022.
//

import SwiftUI
import UIKit
import WebKit

struct HTMLStringReader: UIViewControllerRepresentable {
    init(htmlContent: Binding<String>, dynamicHeight: Binding<CGFloat>) {
        self._htmlContent = htmlContent
        self._dynamicHeight = dynamicHeight
    }
    @Binding var htmlContent: String
    @Binding var dynamicHeight: CGFloat
    
    func makeUIViewController(context: Context) -> ViewController {
        
        return ViewController(htmlContent: $htmlContent, dynamicHeight: $dynamicHeight)
    }
    
    func updateUIViewController(_ viewController: ViewController, context: Context) {
        viewController.loadHTMLContent(self.htmlContent)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class ViewController: UIViewController, WKNavigationDelegate {
        init(htmlContent: Binding<String>, dynamicHeight: Binding<CGFloat>) {
            self._htmlContent = htmlContent
            self._dynamicHeight = dynamicHeight
            super.init(nibName: nil, bundle: nil)
        }
        @Binding var htmlContent: String
        @Binding var dynamicHeight: CGFloat
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.setupSubviews()
            self.loadHTMLContent(self.htmlContent)
        }
        
        let scrollView: UIScrollView = {
            let scrollView = UIScrollView()
            scrollView.showsVerticalScrollIndicator = false
            return scrollView
        }()
        
        let contentView: UIView = {
            let view = UIView()
            view.backgroundColor = .white
            return view
        }()
        
        var webViewHeightConstraint: NSLayoutConstraint?
        
        
        func loadHTMLContent(_ htmlContent: String) {
            let htmlStart = "<HTML><HEAD><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, shrink-to-fit=no\"><link href=\"https://fonts.googleapis.com/css?family=Roboto:300,400,500,600,700\" rel=\"stylesheet\"><style>body {font-family: Roboto;font-style: normal;font-weight: normal;font-size: \(14)px;line-height: \(21)px;color: #20203F;margin: 10;} img {width:100%} figure {margin: 0}</style></HEAD><BODY>"
            let htmlEnd = "</BODY></HTML>"
            var htmlString = "\(htmlStart)\(htmlContent)\(htmlEnd)"
            htmlString = htmlString.replacingOccurrences(of: "&lt;", with: "<")
            htmlString = htmlString.replacingOccurrences(of: "&gt;", with: ">")
            self.webView.loadHTMLString(htmlString, baseURL: nil)
        }
        
        lazy var webView: WKWebView = {
            let webView = WKWebView(frame: .zero)
            webView.navigationDelegate = self
            webView.scrollView.isScrollEnabled = false
            webView.scrollView.bounces = false
            return webView
        }()
        
        func setupSubviews() {
            
            view.addSubview(self.scrollView)
            self.scrollView.translatesAutoresizingMaskIntoConstraints = false
            self.scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            self.scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            self.scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            self.scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

            self.scrollView.addSubview(self.contentView)
            self.contentView.translatesAutoresizingMaskIntoConstraints = false
            self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
            self.contentView.leftAnchor.constraint(equalTo: self.scrollView.leftAnchor).isActive = true
            self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true
            self.contentView.rightAnchor.constraint(equalTo: self.scrollView.rightAnchor).isActive = true
            self.contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor).isActive = true
            
            self.contentView.addSubview(self.webView)
            self.webView.translatesAutoresizingMaskIntoConstraints = false
            self.webView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
            self.webView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
            self.webView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
            self.webView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
            self.webViewHeightConstraint = self.webView.heightAnchor.constraint(equalToConstant: 0)
            self.webViewHeightConstraint?.isActive = true
            
        }
        
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            DispatchQueue.main.async {
                if webView.isLoading == false {
                    webView.evaluateJavaScript("document.body.scrollHeight", completionHandler: { (height, error) in
                        if let height = height as? CGFloat {
                            self.webViewHeightConstraint?.constant = height
                            self.dynamicHeight = height
                        }
                    })
                }
            }
        }
    }
    
    class Coordinator: NSObject {
        
        
    }
}
