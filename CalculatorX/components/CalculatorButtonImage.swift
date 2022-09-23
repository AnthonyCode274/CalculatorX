//
//  CalculatorButtonImage.swift
//  CalculatorX
//
//  Created by Hau Nguyen on 16/09/2022.
//

import SwiftUI

struct CalculatorButtonImage: View {
    init(_ name: String,_ action: @escaping () -> Void) {
        self.name = name
        self.action = action
    }
    init(_ name: String, backgroundColor: Color,_ action: @escaping () -> Void) {
        self.backgroundColor = backgroundColor
        self.name = name
        self.action = action
    }
    var backgroundColor: Color = Color.Neumorphic.main
    let name: String
    let action: () -> Void
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        let size: CGFloat = UIScreen.getUnit(20)
        
        CalculatorButton(
            overView: AnyView(
                Image(name)
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(
                        colorScheme == .dark ? Color.white : Color.black
                    )
                    .frame(width: size, height: size, alignment: .center)
            ),
            backgroundColor: backgroundColor,
            action: self.action)
    }
}

struct CalculatorButtonImage_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorButtonImage("percent") {
            
        }
    }
}
