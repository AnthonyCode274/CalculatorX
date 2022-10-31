//
//  HeaderNavigationBar.swift
//  CalculatorX
//
//  Created by HauNguyen on 31/10/2565 BE.
//

import SwiftUI

struct HeaderNavigationBar: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        HStack {
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image("icon-back")
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
                    .frame(width: 24, height: 24)
                    .background {
                        BlurView()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                    }
                    
            }
            
            Spacer()
        }
        .frame(maxHeight: UIScreen.getUnit(50), alignment: .center)
        .padding(.top, UIScreen.edges?.top)
        .padding(.horizontal, 20)
    }
}

struct HeaderNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        HeaderNavigationBar()
    }
}
