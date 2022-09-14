//
//  ItemRow.swift
//  CalculatorX
//
//  Created by Hau Nguyen on 01/09/2022.
//

import SwiftUI

struct ButtonView: View {
    init(_ string: String = "",_ textColor: Color = Color.white,_ backgroundColor: Color = Color.GrayDark, action: @escaping () -> Void) {
        self.string = string
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.action = action
    }
    
    let string: String
    let textColor: Color
    let backgroundColor: Color
    let action: () -> Void
    
    var body: some View {
        
        let size: CGFloat = (UIScreen.width / 4)
        
        Button(action: action) {
            Circle()
                .fill(backgroundColor)
                .overlay(
                    Text(string)
                        .foregroundColor(textColor)
                        .font(.largeTitle)
                        .fontWeight(.regular)
                )
        }
        .frame(maxWidth: size - 15, maxHeight: size - 15)
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView("9", Color.gray) {
            
        }
    }
}
