//
//  CalculatorButton.swift
//  CalculatorX
//
//  Created by Hau Nguyen on 16/09/2022.
//

import SwiftUI

struct CalculatorButton: View {
    init(overView: AnyView = AnyView(EmptyView()), backgroundColor: Color = Color.Neumorphic.main, action: @escaping () -> Void) {
        self.backgroundColor = backgroundColor
        self.overView = overView
        self.action = action
    }
    var backgroundColor: Color = Color.Neumorphic.main
    var overView: AnyView =  AnyView(EmptyView())
    let action: () -> Void
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        let width: CGFloat = UIScreen.getUnit(70)
        let height: CGFloat = width / 1.5
        let radius: CGFloat = UIScreen.getUnit(8)
        
        Button(action: action) {
            RoundedRectangle(cornerRadius: radius)
                .fill(self.backgroundColor)
                .frame(width: width, height: height, alignment: .center)
                .softOuterShadow()
                .overlay(self.overView)
        }
    }
}

struct CalculatorButton_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
            .colorScheme(.dark)
        
        CalculatorView()
            .colorScheme(.light)
    }
}
