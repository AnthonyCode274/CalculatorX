//
//  CalculatorButtonImage.swift
//  CalculatorX
//
//  Created by HauNguyen on 25/10/2565 BE.
//

import SwiftUI

struct CalculatorButtonImage: View {
    let buttonType: ButtonType
    @EnvironmentObject private var viewModel: CalculatorViewModel
    
    @EnvironmentObject private var currentRate: CurrentRateViewModel
//    @StateObject private var viewModel = CalculatorViewModel()
    
    var body: some View {
        Button(action: {
            viewModel.performAction(for: buttonType)
            if buttonType == .equals {
                currentRate.evaluateResultExchange(viewModel.getNumber)
            } else if buttonType == .clear {
                currentRate.clear()
            } else if buttonType == .allClear {
                currentRate.clearAll()
            }
        }) {
            Image(buttonType.description)
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fill)
                .foregroundColor(getForegroundColor())
                .frame(width: height, height: height)
        }
        .buttonStyle(
            CalculatorButtonStyle(
                size: getButtonSize(),
                backgroundColor: getBackgroundColor(),
                foregroundColor: getForegroundColor())
        )
    }
    
    private var width: CGFloat {
        return UIScreen.getUnit(75)
    }
    
    private var height: CGFloat {
        return width / 1.5
    }
    
    private func getButtonSize() -> CGSize {
        return .init(width: width, height: height)
    }
    
    private func getBackgroundColor() -> Color {
        return viewModel.buttonTypeIsHighlighted(buttonType: buttonType) ? buttonType.foregroundColor : buttonType.backgroundColor
    }
    
    private func getForegroundColor() -> Color {
        return viewModel.buttonTypeIsHighlighted(buttonType: buttonType) ? buttonType.backgroundColor : buttonType.foregroundColor
    }
}

struct CalculatorButtonImage_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 0) {
            ZStack {
                Color.Neumorphic.main.ignoresSafeArea()

                VStack(spacing: 30) {
                    CalculatorButtonImage(buttonType: .negative)
                    
                    CalculatorButtonText(buttonType: .digit(.one))
                }
            }
            .colorScheme(.light)
            
            ZStack {
                Color.Neumorphic.main.ignoresSafeArea()

                VStack(spacing: 30) {
                    CalculatorButtonImage(buttonType: .negative)
                    
                    CalculatorButtonText(buttonType: .digit(.one))
                }
            }
            .colorScheme(.dark)
        }
    }
}
