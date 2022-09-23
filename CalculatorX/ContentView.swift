//
//  ContentView.swift
//  CalculatorX
//
//  Created by Hau Nguyen on 01/09/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        CalculatorView()
            .statusBar(hidden: true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
