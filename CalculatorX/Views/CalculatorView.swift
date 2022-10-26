//
//  CalculatorView.swift
//  CalculatorX
//
//  Created by Hau Nguyen on 13/09/2022.
//

import SwiftUI
import Neumorphic

struct CalculatorView: View {
    @EnvironmentObject private var viewModel: CalculatorViewModel
    @State private var maxCountDown = 15
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.Neumorphic.main.ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                HeaderWorkingWindows()
                
                BodyCalculatorWorking()
                
                Spacer()
                
                VStack(spacing: UIScreen.getUnit(10)) {
                    KeyboardPad()
                    
                    ExchangeRateUpdates()
                }
            }
            .padding(.vertical, UIScreen.getUnit(10))
            
        }
        .frame(maxWidth: UIScreen.screenWidth)
        .onReceive(self.viewModel.timer) { _ in
            if self.maxCountDown > 0 && self.viewModel.currencies.isEmpty {
                self.maxCountDown -= 1
                if self.maxCountDown == 0 {
                    DispatchQueue.main.async {
                        self.viewModel.loadCurrencies()
                    }
                    print("Loading == 0")
                    self.maxCountDown = 15
                }
                print("Loading API")
            }
        }
    }
    
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
            .colorScheme(.dark)
    }
}
