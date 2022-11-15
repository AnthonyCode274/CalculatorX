//
//  MaytechIntroduction.swift
//  TiTiCalculator
//
//  Created by HauNguyen on 31/10/2565 BE.
//

import SwiftUI

struct MaytechIntroduction: View {
    var body: some View {
        WebView(urlString: .constant("https://software.maytech.vn/gioi-thieu/"))
            .ignoresSafeArea()
    }
}

struct MaytechIntroduction_Previews: PreviewProvider {
    static var previews: some View {
        MaytechIntroduction()
    }
}
