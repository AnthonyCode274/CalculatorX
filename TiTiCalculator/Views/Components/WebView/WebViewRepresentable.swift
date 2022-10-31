//
//  WebViewRepresentable.swift
//  TiTiCalculator
//
//  Created by HauNguyen on 01/11/2565 BE.
//

import SwiftUI
import WebKit

struct WebViewRepresentable: UIViewRepresentable {
 
    @Binding var urlString: String
    @Binding var showLoading: Bool
 
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        if let url = URL(string: self.urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
            return webView
        } else {
            return WKWebView()
        }
    }
 
    func updateUIView(_ webView: WKWebView, context: Context) {
        
    }
    
    func makeCoordinator() -> WebviewCoordinator {
        return WebviewCoordinator(didStart: didStart, didFinish: didFinish)
    }
    
    func didStart() {
        self.showLoading = true
    }
    
    func didFinish() {
        self.showLoading = false
    }
    
    class WebviewCoordinator: NSObject, WKNavigationDelegate {
        init(didStart: @escaping () -> Void, didFinish: @escaping () -> Void) {
            self.didStart = didStart
            self.didFinish = didFinish
        }
        
        var didStart: () -> Void
        var didFinish: () -> Void
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            self.didStart()
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            self.didFinish()
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            
        }
    }
}
