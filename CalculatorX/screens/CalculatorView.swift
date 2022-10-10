//
//  CalculatorView.swift
//  CalculatorX
//
//  Created by Hau Nguyen on 13/09/2022.
//

import SwiftUI
import Neumorphic

struct CalculatorView: View {
    @StateObject private var viewModel = CalculationViewModel()
    @StateObject private var currencyVM = CurrencyViewModel()
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.Neumorphic.main.ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                HeaderWorkingWindows(viewModel: viewModel)
                
                BodyCalculatorWorking(viewModel: viewModel, currencyViewModel: currencyVM)
                
                Spacer()
                
                VStack(spacing: UIScreen.getUnit(15)) {
                    KeyboardCalculatorView(viewModel: viewModel)
                    
                    ExchangeRateUpdates(viewModel: currencyVM)
                }
            }
            .padding(.vertical, UIScreen.getUnit(15))
            
        }
        .frame(maxWidth: UIScreen.width)
    }
    
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
            .colorScheme(.dark)
    }
}
