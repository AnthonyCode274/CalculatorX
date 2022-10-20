//
//  ContentView.swift
//  CalculatorX
//
//  Created by Hau Nguyen on 01/09/2022.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        CalculatorView()
            .statusBar(hidden: true)
            .onAppear() {
                UIScreen.setRotationDevice(to: .portrait)
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
