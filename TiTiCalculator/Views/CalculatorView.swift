//
//  CalculatorView.swift
//  TiTiCalculator
//
//  Created by Hau Nguyen on 13/09/2022.
//

import SwiftUI
import Neumorphic

struct CalculatorView: View {
    @EnvironmentObject private var viewModel: CalculatorViewModel
    @EnvironmentObject private var currentRate: CurrentRateViewModel
    
    private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    @State private var maxCountDown = 5
    
    @State private var startLoading: Bool = false
    
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
        .onAppear() {
            NetworkChecking.internetConnectionChecking()
        }
    }
    
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
            .colorScheme(.dark)
    }
}
