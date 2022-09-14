//
//  ZeroButton.swift
//  CalculatorX
//
//  Created by Hau Nguyen on 04/09/2022.
//

import SwiftUI

struct ZeroButton: View {
    init(_ string: String = "",_ action: @escaping () -> Void) {
        self.string = string
        self.action = action
    }
    
    let string: String
    let action: () -> Void
    
    var body: some View {
        
        let size: CGFloat = (UIScreen.width / 4)
        
        Button(action: action) {
            RoundedRectangle(cornerRadius: 45)
                .fill(Color.GrayDark)
                .overlay(
                    Text(string)
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .padding(.leading, 45)
                    , alignment: .leading
                )
                
        }
        .frame(maxWidth: (size * 2) - 15, maxHeight: size - 15)
    }
}

struct ZeroButton_Previews: PreviewProvider {
    static var previews: some View {
        ZeroButton("9") {
            
        }
    }
}
