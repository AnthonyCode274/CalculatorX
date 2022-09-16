//
//  CalculatorIconButton.swift
//  CalculatorX
//
//  Created by Hau Nguyen on 14/09/2022.
//

import SwiftUI

struct CalculatorIconButton: View {
    init(_ nameIcon: String = "",_ action: @escaping () -> Void) {
        self.nameIcon = nameIcon
        self.action = action
    }
    
    var nameIcon: String = ""
    let action: () -> Void
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        let width: CGFloat = UIScreen.unit((UIScreen.width / 3) - 70)
        let height: CGFloat = width * 0.70
        let radius: CGFloat = UIScreen.unit(16)
        
        Button(action: action) {
            RoundedRectangle(cornerRadius: radius)
                .fill(Color.Neumorphic.main)
                .frame(width: width, height: height, alignment: .center)
                .softOuterShadow()
                .overlay(
                    Image(nameIcon)
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(
                            colorScheme == .dark ? Color.white : Color.black
                        )
                        .frame(width: width / 2, height: width / 2, alignment: .center)
                )
        }
    }
}

struct CalculatorIconButton_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
            .colorScheme(.dark)
    }
}
