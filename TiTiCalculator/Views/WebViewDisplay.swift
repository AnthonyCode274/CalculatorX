//
//  WebViewDisplay.swift
//  TiTiCalculator
//
//  Created by HauNguyen on 31/10/2565 BE.
//

import SwiftUI

struct WebViewDisplay: View {
    var body: some View {
        WebView(urlString: .constant("https://software.maytech.vn/gioi-thieu/"))
            .ignoresSafeArea()
    }
}

struct WebViewDisplay_Previews: PreviewProvider {
    static var previews: some View {
        WebViewDisplay()
    }
}
