//
//  Infomation.swift
//  TiTiCalculator
//
//  Created by HauNguyen on 31/10/2565 BE.
//

import SwiftUI
import Neumorphic

struct Infomation: View {
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color(hex: "#3467B1"), Color(hex: "#1C3252")], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            
            VStack {
                
                Spacer()
                
                Image("nguyenhuuhau")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .cornerRadius(20)
                    .padding(.top, (UIScreen.edges?.top ?? 0) + 60)
                
                VStack(spacing: 10) {
                    Text("HauNguyen \n Mobile Developer")
                        .font(.custom("AltoneTrial-BoldOblique", size: 26))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    Text("Connect with me")
                        .font(.footnote)
                        .foregroundColor(.blue)
                    HStack(spacing: 20) {
                        
                        SocialButton(imageUrlString: "https://is4-ssl.mzstatic.com/image/thumb/Purple112/v4/a6/72/a7/a672a7dd-a9e8-1a99-8caf-c1076562c0e9/Icon-Production-0-1x_U007emarketing-0-7-0-85-220.png/246x0w.webp", openLink: "https://www.facebook.com/nguyenhuuhau2704")
                        
                        SocialButton(imageUrlString: "https://is3-ssl.mzstatic.com/image/thumb/Purple122/v4/02/96/78/02967825-6bfa-fef0-55cd-79abe696a713/Prod-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/246x0w.webp", openLink: "https://www.instagram.com/so_yoong_/")
                        
                        SocialButton(imageUrlString: "https://is1-ssl.mzstatic.com/image/thumb/Purple122/v4/bf/82/bb/bf82bb3b-8a20-07ba-f92f-c5b96bba9e00/AppIcon-0-1x_U007emarketing-0-7-0-0-85-220.png/246x0w.webp", openLink: "https://zalo.me/0343271817")
                    }
                }
                .padding(.top, 30)
                .padding(.bottom, (UIScreen.edges?.bottom ?? 0))
                
                Spacer()
            }
            
        }
        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.defaultMainColor.ignoresSafeArea())
        .ignoresSafeArea()
        .statusBar(hidden: true)
    }
}

struct Infomation_Previews: PreviewProvider {
    static var previews: some View {
        Infomation()
    }
}
