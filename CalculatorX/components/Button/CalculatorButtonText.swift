//
//  CalculatorButtonText.swift
//  CalculatorX
//
//  Created by Hau Nguyen on 17/09/2022.
//

import SwiftUI

struct CalculatorButtonText: View {
    init(_ string: String,_ action: @escaping () -> Void) {
        self.string = string
        self.action = action
    }
    init(_ string: String, backgroundColor: Color,_ action: @escaping () -> Void) {
        self.backgroundColor = backgroundColor
        self.string = string
        self.action = action
    }
    var backgroundColor: Color = Color.Neumorphic.main
    let string: String
    let action: () -> Void
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        let fontSize: CGFloat = self.string.contains("000") ? 26 : 32
        
        CalculatorButton(
            overView: AnyView(
                Text(string)
                    .font(.medium(size: fontSize))
                    .foregroundColor(self.colorScheme == .dark ? .white : .black)
            ),
            backgroundColor: backgroundColor,
            action: self.action)
    }
}

struct CalculatorButtonText_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorButtonText("9") {
            
        }
    }
}
