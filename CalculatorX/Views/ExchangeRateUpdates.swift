//
//  ExchangeRateUpdates.swift
//  CalculatorX
//
//  Created by HauNguyen on 05/10/2565 BE.
//

import SwiftUI

struct ExchangeRateUpdates: View {
    
    @EnvironmentObject private var viewModel: CalculatorViewModel
    
    @EnvironmentObject private var currenRate: CurrentRateViewModel
    
    @State private var rotation: Double = 0
    
    var body: some View {
        HStack(spacing: 0) {
            Button(action: {
                self.rotation += 720
                self.currenRate.loadData()
            }) {
                Image("icon-refresh")
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.primary)
                    .frame(width: 20, height: 20)
                    .rotationEffect(.degrees(self.rotation))
                    .animation(.default.speed(0.25), value: self.rotation)
            }
            
            Spacer()
            
            VStack(alignment: .center, spacing: UIScreen.getUnit(2)) {
                Text("\(self.currenRate.displayCurrentRateSelected)")
                    .font(.regular(size: 16))
                    .foregroundColor(.primary)
                
                Text("Cập nhật mới nhất: \(self.currenRate.currentDateUpdate.formatted())")
                    .font(.regular(size: 10))
                    .foregroundColor(.primary)
            }
            
            Spacer()
            
            NavigationLink(destination: Infomation()) {
                Image(systemName: "info.circle")
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.primary)
                    .frame(width: 20, height: 20)
            }
        }
        .padding(.horizontal, 20)
    }
}

struct ExchangeRateUpdates_Previews: PreviewProvider {
    static var previews: some View {
        ExchangeRateUpdates()
    }
}
