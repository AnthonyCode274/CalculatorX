//
//  ExchangeRateUpdates.swift
//  CalculatorX
//
//  Created by HauNguyen on 05/10/2565 BE.
//

import SwiftUI

struct ExchangeRateUpdates: View {
    @ObservedObject var viewModel: CurrencyViewModel
    @Environment(\.colorScheme) private var colorScheme
    @State private var rotation: Double = 0
    @State private var isActiveSheet: Bool = false
    @State private var indexPicker: Int = 0
    
    var currencyRate: String {
        return String(format: "%.2f", self.viewModel.fromCurrency?.currencyRate ?? "").numberFormatted()
    }
    
    var currencyName: String {
        return self.viewModel.fromCurrency?.currencyName ?? ""
    }
    
    var currencyCode: String {
        return self.viewModel.fromCurrency?.currencyCode ?? ""
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: UIScreen.getUnit(2)) {
            HStack(spacing: UIScreen.getUnit(10)) {
                Button(action: {
                    self.rotation += 720
                    self.viewModel.loadCurrencies()
                }) {
                    Image("icon-refresh")
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(self.colorScheme == .dark ? .white : .black)
                        .frame(width: UIScreen.getUnit(16), height: UIScreen.getUnit(16))
                        .rotationEffect(.degrees(self.rotation))
                        .animation(.default.speed(0.25), value: self.rotation)
                }
                
                HStack(spacing: UIScreen.getUnit(5)) {
                    Group {
                        Text("1 \(self.currencyName) (\(self.currencyCode))")
                        
                        Text("=")
                        
                        Text("\(self.currencyRate) VNĐ")
                    }
                    .font(.regular(size: 16))
                    .foregroundColor(self.colorScheme == .dark ? .white : .black)

//                    Text("1 \(self.currencyName) " + "(\(self.currencyCode))" + " = " + "\(self.currencyRate) VNĐ")
//                        .font(.regular(size: 16))
//                        .foregroundColor(self.colorScheme == .dark ? .white : .black)
                    
                }
                
            }
            
            Text("Cập nhật mới nhất: \(self.viewModel.currentDateUpdate.formatted())")
                .font(.regular(size: 10))
                .foregroundColor(self.colorScheme == .dark ? .white : .black)
        }
        .halfSheet(isPresented: $isActiveSheet, onDismiss: self.onEnd) {
            VStack(spacing: 10) {
                Section {
                    Picker(selection: $indexPicker, label: EmptyView()) {
                        ForEach(self.viewModel.currencies.indices) { item in
                            Text("\(self.viewModel.currencies[item].currencyName)")
                                .font(.regular(size: 20))
                                .foregroundColor(self.colorScheme == .dark ? .white : .black)
                        }
                    }
                    .pickerStyle(.wheel)
                }
            }
        }
    }
    
    
    func onEnd() {
        self.viewModel.fromCurrency = self.viewModel.currencies[self.indexPicker]
        self.isActiveSheet = false
    }
}

struct ExchangeRateUpdates_Previews: PreviewProvider {
    static var previews: some View {
        ExchangeRateUpdates(viewModel: CurrencyViewModel())
    }
}
