//
//  BodyCalculatorWorking.swift
//  CalculatorX
//
//  Created by Hau Nguyen on 14/09/2022.
//

import SwiftUI

struct BodyCalculatorWorking: View {
    @ObservedObject var viewModel: CalculatorViewModel
    @State private var expanded: Bool = false
    @Environment(\.colorScheme) private var colorScheme
    @State private var isPresentedFrom: Bool = false
    @State private var isPresentedTo: Bool = false
    
    var spellOutView: some View {
        HStack(alignment: .top, spacing: UIScreen.getUnit(10)) {
            Button(action: { }) {
                Image(ImageStyle.name.speaker)
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(self.colorScheme == .dark ? .white : .black)
                    .frame(width: UIScreen.getUnit(20), height: UIScreen.getUnit(20))
            }

            HStack {
                Text(self.spellOutNumber)
                    .font(.regular(size: 16))
                    .foregroundColor(self.colorScheme == .dark ? .white : .black)
                    .fixedSize(horizontal: false, vertical: true)
                    .lineLimit(2)
                    .frame(height: UIScreen.getUnit(30), alignment: .top)
                
                Spacer()
                
                Button(action: {
                    UIScreen.showAlert(title: "Đánh vần", msg: String(self.viewModel.spellNumber).spellOut(), button: "OK")
                }) {
                    Text("Xem")
                        .font(.medium(size: 14))
                        .foregroundColor(.blue)
                }
            }
        }
    }
    
    var exchangeCurrency: some View {
        VStack(alignment: .center, spacing: UIScreen.getUnit(10)) {
            HStack(alignment: .center, spacing: 0) {
                                
                FunctionMoreButtonText(string: self.currencyCodeLeft) {
                    self.isPresentedFrom = true
                }
                .frame(maxWidth: .infinity)
                
                VStack(alignment: .center, spacing: 0) {
                    
                    Text("Sang")
                        .font(.regular(size: 12))
                        .foregroundColor(Color.OviLight)
                        .fixedSize(horizontal: true, vertical: false)
                        .lineLimit(1)
                    
                    Image(ImageStyle.name.nextIcon)
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color.OviLight)
                        .frame(width: UIScreen.getUnit(20),
                               height: UIScreen.getUnit(20))
                }
                .frame(maxWidth: .infinity)
                                
                FunctionMoreButtonText(string: self.currencyCodeRight) {
                    self.isPresentedTo = true
                }
                .frame(maxWidth: .infinity)
                
            }
            
            Button(action: {
                //self.viewModel.currentNumberSpell = String(format: "%.3f", self.totalResultExchange)
            }) {
                Text(self.totalResultExchangeShow + " " + self.currencyCodeRight)
                    .font(.bold(size: 18))
                    .foregroundColor(.OgranLight)
                    .fixedSize(horizontal: true, vertical: false)
                    .lineLimit(1)
                    .softOuterShadow()
            }
            
        }
        .sheet(isPresented: $isPresentedFrom) {
            ListViewSelectionRate(data: self.viewModel.currencies, itemSelected: self.$viewModel.fromCurrency, isPresented: $isPresentedFrom)
        }
        .sheet(isPresented: $isPresentedTo) {
            ListViewSelectionRate(data: self.viewModel.currencies, itemSelected: self.$viewModel.toCurrency, isPresented: $isPresentedTo)
        }
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
        .frame(maxWidth: UIScreen.width, alignment: .leading)
        
    }
    
    var spellOutNumber: String {
        return self.viewModel.operation != nil ? self.viewModel.operation!.operatorToWord().capitalizeFirstLetter() : String(self.viewModel.spellNumber).spellOut()
    }
    
    var totalResultExchange: Double {
        let resultValue = self.viewModel.resultWorking.doubleValue()
        let unit = MTUtils.unitCurrency(from: self.currentRateLeft, to: self.currentRateRight)
        let result = resultValue * unit
        return result
    }
    
    var totalResultExchangeShow: String {
        let result = self.totalResultExchange
        return String(result).numberFormatted()
    }
    
    var currencyLeft: String {
        let string = self.viewModel.fromCurrency.currencyName
        return string.isEmpty ? TextDictionary.SpaceDivider : string
    }
    
    var currentcyRight: String {
        let string = self.viewModel.toCurrency.currencyName
        return string
    }
    
    var currentWorkingShow: String {
        let string = self.viewModel.workings
        return string.spellOut()
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
