//
//  ContentView.swift
//  TiTiCalculator
//
//  Created by Hau Nguyen on 01/09/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = CalculatorViewModel()
    @StateObject private var currentRate = CurrentRateViewModel()
    
    var body: some View {
        NavigationView {
            CalculatorView()
                .statusBar(hidden: true)
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
                .onAppear() {
                    UIScreen.setRotationDevice(to: .portrait)
                    self.currentRate.loadData()
                }
                .environmentObject(viewModel)
                .environmentObject(currentRate)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
