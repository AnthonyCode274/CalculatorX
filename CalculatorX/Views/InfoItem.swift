//
//  InfoItem.swift
//  CalculatorX
//
//  Created by HauNguyen on 31/10/2565 BE.
//

import SwiftUI
import Neumorphic

struct InfoItem: View {
    @Binding var urlString: String
    var title: String
    var destination: AnyView
    
    var body: some View {
        NavigationLink(destination: destination) {
            HStack {
                AsyncImageView(urlString: .constant(urlString), resizingMode: .aspectFit)
                    .clipShape(Circle())
                    .frame(width: 56, height: 56)
                
                Text(title)
                    .font(.regular(size: 18))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                
                Spacer()
                
                Button(action: {}) {
                    Image(systemName: "chevron.up")
                        .foregroundColor(.black)
                        .rotationEffect(Angle(degrees: 90))
                        .frame(width: 20, height: 20)
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 10)
        }
        
    }
}

struct InfoItem_Previews: PreviewProvider {
    static var previews: some View {
        InfoItem(urlString: .constant("https://scontent.fsgn5-11.fna.fbcdn.net/v/t39.30808-6/239633553_3745787405523084_980017474790580034_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=yHi7FI4BAfcAX8h4hub&_nc_ht=scontent.fsgn5-11.fna&oh=00_AfAg0Bp-kOhXvk5ryRAyi0X5jg8Q8zlL_2oVrGwt9ecnBg&oe=636389DA"), title: "Giới thiệu công ty phần mềm MayTech", destination: AnyView(EmptyView()))
    }
}
