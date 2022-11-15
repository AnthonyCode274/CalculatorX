//
//  TiTiIntroductuion.swift
//  TiTiCalculator
//
//  Created by HauNguyen on 31/10/2565 BE.
//

import SwiftUI

struct TiTiIntroductuion: View {
        
    var body: some View {
        WebView(urlString: .constant("https://calc.maytech.app"))
            .ignoresSafeArea()
    }
}

struct TiTiIntroductuion_Previews: PreviewProvider {
    static var previews: some View {
        TiTiIntroductuion()
    }
}
