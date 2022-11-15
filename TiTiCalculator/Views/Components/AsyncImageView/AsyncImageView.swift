//
//  AsyncImageView.swift
//  TiTiCalculator
//
//  Created by HauNguyen on 31/10/2565 BE.
//

import SwiftUI
import NukeUI

struct AsyncImageView: View {
    init(urlString: Binding<String>, resizingMode: ImageResizingMode) {
        self._urlString = urlString
        self.resizingMode = resizingMode
    }
    @Binding private var urlString: String
    private var resizingMode: ImageResizingMode
    @State private var imageRequest: ImageRequest = ImageRequest(url: URL(string: ""))
    
    var body: some View {
        LazyImage(source: imageRequest, resizingMode: resizingMode)
            .onChange(of: urlString.count) { _ in
                self.loadData()
            }
            .onAppear() {
                self.loadData()
            }
    }
    
    private func loadData() {
        DispatchQueue.main.async {
            if self.urlString.isEmpty {
                self.imageRequest = ImageRequest(url: Config.noImage.parseURL())
            } else {
                self.imageRequest = ImageRequest(url: urlString.parseURL())
            }
        }
    }
}

struct AsyncImageView_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageView(urlString: .constant("https://photo2.tinhte.vn/data/attachment-files/2022/06/6012635_Apple_WWDC_20222_Tinhte.jpg"), resizingMode: .center)
            .frame(height: 300)
    }
}
