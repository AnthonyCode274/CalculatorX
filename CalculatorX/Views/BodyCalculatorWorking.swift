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
    
    @EnvironmentObject private var currentRate: CurrentRateViewModel
    
    @State private var expanded: Bool = false
    
    @Environment(\.colorScheme) private var colorScheme
    
    @State private var isPresentedFrom: Bool = false
    
    @State private var isPresentedTo: Bool = false
    
    @State private var leftCurrency: Currency = Currency()
    
    @State private var rightCurrency: Currency = Currency()
    
    private var spellOutView: some View {
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
                UIScreen.showAlert(title: "Đánh vần", msg: self.viewModel.spellOutNumber, button: TextDictionary.OK)
            }) {
                Text(self.viewModel.spellOutNumber)
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
    
    private var exchangeCurrencyView: some View {
        VStack(alignment: .center, spacing: UIScreen.getUnit(10)) {
            HStack(alignment: .center, spacing: 0) {
                
                Button("\(self.currentRate.currencyCodeLeft)") {
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
                
                Button("\(self.currentRate.currencyCodeRight)") {
                    self.isPresentedTo = true
                }
                .buttonStyle(FuncMoreButtonStyle())
                .frame(maxWidth: .infinity)
                
            }
            
            Button(action: {
                UIScreen.showAlert(title: TextDictionary.Description,
                                   msg: self.currentRate.displayDescription,
                                   button: TextDictionary.OK)
            }) {
                Text(self.currentRate.displayTotalResultExchange)
                    .font(.bold(size: 18))
                    .foregroundColor(.OgranLight)
                    .softOuterShadow()
                    .frame(maxWidth: UIScreen.screenWidth)
            }
            
        }
        .sheet(isPresented: $isPresentedFrom, onDismiss: onDismissLeft) {
            ListViewSelectionRate(data: currentRate.currencies,
                                  itemSelected: $leftCurrency,
                                  isPresented: $isPresentedFrom)
            .onAppear() {
                self.leftCurrency = self.currentRate.leftCurrency ?? Currency()
            }
        }
        .sheet(isPresented: $isPresentedTo, onDismiss: onDismissRight) {
            ListViewSelectionRate(data: currentRate.currencies,
                                  itemSelected: $rightCurrency,
                                  isPresented: $isPresentedTo)
            .onAppear() {
                self.rightCurrency = self.currentRate.rightCurrency ?? Currency()
            }
        }
    }
    
    private func onDismissLeft() {
        self.currentRate.leftCurrency = self.leftCurrency
    }
    
    private func onDismissRight() {
        self.currentRate.rightCurrency = self.rightCurrency
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
                
                self.exchangeCurrencyView
            }
            
            Spacer()
        }
        .padding(.top, UIScreen.getUnit(10))
        .padding(.bottom, -UIScreen.getUnit(10))
        .padding(.horizontal, UIScreen.getUnit(20))
        .frame(maxWidth: UIScreen.screenWidth, alignment: .leading)
        
    }
}

struct BodyCalculatorWorking_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
            .colorScheme(.light)
    }
}
