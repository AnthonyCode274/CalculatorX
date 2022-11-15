//
//  SocialButton.swift
//  TiTiCalculator
//
//  Created by HauNguyen on 13/11/2565 BE.
//

import SwiftUI

struct SocialButton: View {
    let imageUrlString: String
    let openLink: String
    
    var body: some View {
        Button(action: {
            UIApplication.shared.open(Utilities.openUrl(openLink))
        }) {
            AsyncImageView(urlString: .constant(imageUrlString), resizingMode: .aspectFit)
                .frame(width: 32, height: 32)
                .cornerRadius(6)
        }
    }
}

struct SocialButton_Previews: PreviewProvider {
    static var previews: some View {
        SocialButton(imageUrlString: "https://is4-ssl.mzstatic.com/image/thumb/Purple112/v4/a6/72/a7/a672a7dd-a9e8-1a99-8caf-c1076562c0e9/Icon-Production-0-1x_U007emarketing-0-7-0-85-220.png/246x0w.webp", openLink: "")
    }
}
