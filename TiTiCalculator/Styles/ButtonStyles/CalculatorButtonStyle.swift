//
//  CalculatorButtonStyle.swift
//  Calculator
//
//  Created by Ricardo Montemayor on 18/07/22.
//

import SwiftUI
import Neumorphic

struct CalculatorButtonStyle: ButtonStyle {
    
    var size: CGSize
    var backgroundColor: Color
    var foregroundColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .frame(width: width, height: height)
                .background(
                    RoundedRectangle(cornerRadius: UIScreen.getUnit(8))
                        .fill(backgroundColor)
                        .frame(width: width, height: height)
                        .softOuterShadow()
                )
                .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
    
    var width: CGFloat {
        return size.width
    }
    
    var height: CGFloat {
        return size.height
    }
}

struct CalculatorButtonStyle_Previews: PreviewProvider {
    static let buttonType: ButtonType = .digit(.zero)
    
    static var previews: some View {
        Button(buttonType.description) { }
            .buttonStyle(
                CalculatorButtonStyle(
                    size: .init(width: 80, height: 80),
                    backgroundColor: buttonType.backgroundColor,
                    foregroundColor: buttonType.foregroundColor
                )
            )
            .padding()
    }
}
