//
//  BodyCalculatorWorking.swift
//  CalculatorX
//
//  Created by Hau Nguyen on 14/09/2022.
//

import SwiftUI
import Neumorphic

struct BodyCalculatorWorking: View {
    @EnvironmentObject private var viewModel: CalculatorViewModel
    @State private var expanded: Bool = false
    @Environment(\.colorScheme) private var colorScheme
    @State private var isPresentedFrom: Bool = false
    @State private var isPresentedTo: Bool = false
    
    var spellOutView: some View {
        HStack(alignment: .top, spacing: UIScreen.getUnit(10)) {
            Button(action: { }) {
                Image("icon-loudspeaker")
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(self.colorScheme == .dark ? .white : .black)
                    .frame(width: UIScreen.getUnit(20), height: UIScreen.getUnit(20))
            }

            Button(action: {
                UIScreen.showAlert(title: "Đánh vần", msg: self.alertSpelloutMessage, button: "OK")
            }) {
                Text("\(viewModel.displayText.spellOut())")
                    .font(.regular(size: 16))
                    .foregroundColor(self.colorScheme == .dark ? .white : .black)
                    .fixedSize(horizontal: false, vertical: true)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .frame(height: UIScreen.getUnit(30))
                    .frame(maxWidth: UIScreen.screenWidth, alignment: .topLeading)
            }
        }
    }
    
    var exchangeCurrency: some View {
        VStack(alignment: .center, spacing: UIScreen.getUnit(10)) {
            HStack(alignment: .center, spacing: 0) {
                
                Button(self.currencyCodeLeft) {
                    self.isPresentedFrom = true
                }
                .buttonStyle(FuncMoreButtonStyle())
                .frame(maxWidth: .infinity)
                
                VStack(alignment: .center, spacing: 0) {
                    
                    Text("Sang")
                        .font(.regular(size: 12))
                        .foregroundColor(Color.OviLight)
                        .fixedSize(horizontal: true, vertical: false)
                        .lineLimit(1)
                    
                    Image("icon-right_arrow")
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color.OviLight)
                        .frame(width: UIScreen.getUnit(20),
                               height: UIScreen.getUnit(20))
                }
                .frame(maxWidth: .infinity)
                
                Button(self.currencyCodeRight) {
                    self.isPresentedTo = true
                }
                .buttonStyle(FuncMoreButtonStyle())
                .frame(maxWidth: .infinity)
                
            }
            
            Button(action: {
                
            }) {
                Text(self.totalResultExchangeShow + " " + self.currencyCodeRight)
                    .font(.bold(size: 18))
                    .foregroundColor(.OgranLight)
                    .softOuterShadow()
                    .frame(maxWidth: UIScreen.screenWidth)
            }
            
        }
        .sheet(isPresented: $isPresentedFrom) {
            ListViewSelectionRate(data: self.viewModel.currencies, itemSelected: self.$viewModel.fromCurrency, isPresented: $isPresentedFrom)
        }
        .sheet(isPresented: $isPresentedTo, onDismiss: onDismissSheet) {
            ListViewSelectionRate(data: self.viewModel.currencies, itemSelected: self.$viewModel.toCurrency, isPresented: $isPresentedTo)
        }
    }
    
    func onDismissSheet() {
        
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            self.spellOutView
            
            Spacer()
            
            VStack(spacing: UIScreen.getUnit(15)) {
                HStack {
                    Text(TextDictionary.ExchangeRate + ":")
                        .font(.boldItalic(size: 16))
                        .foregroundColor(.OviLight)

                    Spacer()

                }
                
                self.exchangeCurrency
            }
            
            Spacer()
        }
        .padding(.top, UIScreen.getUnit(10))
        .padding(.bottom, -UIScreen.getUnit(10))
        .padding(.horizontal, UIScreen.getUnit(20))
        .frame(maxWidth: UIScreen.screenWidth, alignment: .leading)
        
    }
    
    var alertSpelloutMessage: String {
        return ""
    }
    
    var totalResultExchange: Double {
        
        return 0
    }
    
    var totalResultExchangeShow: String {
        return ""
    }
    
    var currencyLeft: String {
        let string = self.viewModel.fromCurrency.currencyName
        return string.isEmpty ? TextDictionary.SpaceDivider : string
    }
    
    var currentcyRight: String {
        let string = self.viewModel.toCurrency.currencyName
        return string
    }
    
    var currencyNameFrom: String {
        let string = self.viewModel.fromCurrency.currencyName
        return string
    }
    
    var currencyNameTo: String {
        let string = self.viewModel.toCurrency.currencyName
        return string
    }
    
    var currencyCodeLeft: String {
        let string = self.viewModel.fromCurrency.currencyCode
        return string
    }
    
    var currencyCodeRight: String {
        let string = self.viewModel.toCurrency.currencyCode
        return string
    }
    
    var currentRateLeft: Double {
        let string = self.viewModel.fromCurrency.currencyRate
        return string
    }
    
    var currentRateRight: Double {
        let string = self.viewModel.toCurrency.currencyRate
        return string
    }
}

struct BodyCalculatorWorking_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
            .colorScheme(.light)
    }
}
