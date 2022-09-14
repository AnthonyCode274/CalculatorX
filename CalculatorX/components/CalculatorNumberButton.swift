//
//  CalculatorNumberButton.swift
//  CalculatorX
//
//  Created by Hau Nguyen on 13/09/2022.
//

import SwiftUI

struct CalculatorNumberButton: View {
    init(_ character: String = "",_ action: @escaping () -> Void) {
        self.character = character
        self.action = action
    }
    
    var character: String = ""
    let action: () -> Void
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        let width: CGFloat = UIScreen.unit((UIScreen.width / 3) - 65)
        let height: CGFloat = width * 0.65
        let radius: CGFloat = UIScreen.unit(16)
        let fontSize: CGFloat = UIScreen.unit(32)
        
        Button(action: action) {
            RoundedRectangle(cornerRadius: radius)
                .fill(Color.Neumorphic.main)
                .frame(width: width, height: height, alignment: .center)
                .overlay(
                    Text(character)
                        .font(.system(size: fontSize))
                        .foregroundColor(
                            colorScheme == .dark ? Color.white : Color.black
                        )
                )
                .softOuterShadow()
        }
    }
}

struct CalculatorNumberButton_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
            .colorScheme(.dark)
    }
}
