//
//  CustomContextMenu.swift
//  CalculatorX
//
//  Created by HauNguyen on 04/10/2565 BE.
//

import SwiftUI

struct CustomContextMenu<Content: View, PreView: View>: View {
    init(@ViewBuilder content: @escaping () -> Content, @ViewBuilder preview: @escaping () -> PreView, actions: (() -> UIMenu)? = nil, onEnd: (() -> Void)? = nil) {
        self.content = content()
        self.preview = preview()
        self.menu = actions?()
        self.onEnd = onEnd
    }
    
    var content: Content
    var preview: PreView
    var menu: UIMenu?
    var onEnd: (() -> Void)?
    
    var body: some View {
        ZStack {
            self.content
                .overlay(
                    ContextMenusHelper(content: self.content, preview: self.preview, actions: self.menu)
                )
        }
    }
}

struct CustomContextMenu_Previews: PreviewProvider {
    static var previews: some View {
        CustomContextMenu(content: {
            Label {
                Text("Click me!")
                    .font(.title2)
            } icon: {
                Image(systemName: "lock.fill")
            }
            .font(.title2)
            .foregroundColor(.white)
            .padding()
            .background(.purple)
            .cornerRadius(8)

        }, preview: {
            Text("Hello")
        }, actions: {
            let like = UIAction(title: "Like me", image: UIImage(systemName: "siut.heart.fill")) { _ in
                print("Like")
            }
            let share = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up.fill")) { _ in
                print("Share")
            }
            
            return UIMenu(title: "", children: [like, share])
        }, onEnd: {
            
        })
    }
}
