//
//  BodyCalculatorWorking.swift
//  CalculatorX
//
//  Created by Hau Nguyen on 14/09/2022.
//

import SwiftUI

struct BodyCalculatorWorking: View {
    @ObservedObject var viewModel: CalculationViewModel
    @ObservedObject var currencyViewModel: CurrencyViewModel
    @State private var expanded: Bool = false
    @Environment(\.colorScheme) private var colorScheme
    @State private var isPresentedSheet: Bool = false
    
    var rateExchange: some View {
        VStack(alignment: .leading, spacing: UIScreen.getUnit(10)) {
            HStack {
                FunctionMoreButtonText(string: "\(self.currencyName) (\(self.currencyCode))") {
                    
                }
                
                Spacer()
                
            }
            
            Text("=> \(String(Double(999 * 66200000)).numberFormatted()) VNĐ")
                .font(.bold(size: 18))
                .foregroundColor(.yellow)
                
        }
        .frame(maxWidth: UIScreen.width, alignment: .leading)
        
    }
    
    var spellOutView: some View {
        VStack(alignment: .leading, spacing: UIScreen.getUnit(20)) {
            HStack(alignment: .top, spacing: UIScreen.getUnit(10)) {
                Button(action: { }) {
                    Image("icon-loudspeaker")
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(self.colorScheme == .dark ? .white : .black)
                        .frame(width: UIScreen.getUnit(20), height: UIScreen.getUnit(20))
                }

                HStack {
                    Text(String(self.viewModel.currentWorking).spellOut())
                        .font(.regular(size: 16))
                        .foregroundColor(self.colorScheme == .dark ? .white : .black)
                        .fixedSize(horizontal: false, vertical: true)
                        .lineLimit(2)
                    
                    Spacer()
                    
                    Button(action: {
                        UIScreen.showAlert(title: "Đánh vần", msg: self.currentWorkingShow, button: "OK")
                    }) {
                        Text("Xem")
                            .font(.regular(size: 12))
                            .foregroundColor(.blue)
                    }
                }
            }
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            self.spellOutView
            
            Spacer()
            
            VStack(spacing: UIScreen.getUnit(20)) {
                HStack {
                    Text("Chuyển đổi tỉ giá:")
                        .font(.boldItalic(size: 16))
                        .foregroundColor(.OviLight)
                    
                    Spacer()
                    
                    FunctionMoreButtonText(string: self.currencyName) {
                        self.isPresentedSheet = true
                    }
                }
                
                Button(action: {
                    self.viewModel.currentNumberSpell = self.resultExchangeRateConversion
                }) {
                    Text("= " + self.resultExchangeRateConversion + " " + "VNĐ")
                        .font(.regular(size: 18))
                        .softOuterShadow()
                }
            }
            
            Spacer()
        }
        .padding(.top, UIScreen.getUnit(20))
        .padding(.horizontal, UIScreen.getUnit(20))
        .frame(maxWidth: UIScreen.width, alignment: .leading)
        .sheet(isPresented: $isPresentedSheet) {
            ListViewSelectionRate(data: self.currencyViewModel.currencies, viewModel: self.currencyViewModel, isPresented: $isPresentedSheet)
        }
    }
    
    var resultExchangeRateConversion: String {
        
        let lastResult = self.viewModel.oldResults.last ?? ""
        
        let calculate = lastResult.floatValue() * self.currentRate
        
        let formatted = String(calculate)
        
        return formatted.numberFormatted()
    }
    
    var currentWorkingShow: String {
        let string = self.viewModel.currentWorking
        return string.spellOut()
    }
    
    var currencyName: String {
        return self.currencyViewModel.currency?.currencyName ?? " --- "
    }
    
    var currencyCode: String {
        return self.currencyViewModel.currency?.currencyCode ?? ""
    }
    
    var currentRate: Float {
        return self.currencyViewModel.currency?.currencyRate ?? 0
    }
}

struct BodyCalculatorWorking_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
            .colorScheme(.dark)
    }
}
