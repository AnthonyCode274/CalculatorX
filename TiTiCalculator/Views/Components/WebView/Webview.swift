//
//  Webview.swift
//  TiTiCalculator
//
//  Created by HauNguyen on 31/10/2565 BE.
//

import SwiftUI
import WebKit

struct WebView: View {
    @Binding var urlString: String
    
    @State private var showLoading: Bool = false
    
    var body: some View {
        WebViewRepresentable(urlString: $urlString, showLoading: $showLoading)
            .overlay(
                showLoading ? AnyView(
                    ProgressView(label: {
                        Text("Loading..")
                            .foregroundColor(.black)
                    }).tint(.black)) : AnyView(EmptyView())
            )
    }
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(urlString: .constant("https://google.com"))
    }
}
