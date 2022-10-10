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

    
    var currencyName: String {
        return self.currencyViewModel.currency?.currencyName ?? ""
    }
    
    var currencyCode: String {
        return self.currencyViewModel.currency?.currencyCode ?? ""
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            self.spellOutView
            
            Spacer()
            
        }
        .padding(.top, UIScreen.getUnit(20))
        .padding(.horizontal, UIScreen.getUnit(20))
        .frame(maxWidth: UIScreen.width, alignment: .leading)
    }
    
    var rateExchange: some View {
        VStack(alignment: .leading, spacing: UIScreen.getUnit(10)) {
            HStack {
                FunctionMoreButtonText(string: "\(self.currencyName) (\(self.currencyCode))") {
                    
                }
                
                Spacer()
                
            }
            
            Text("=> \(String(Double(999 * 66200000)).numberFotmat) VNĐ")
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

                VStack(alignment: .trailing, spacing: 5) {
                    HStack {
                        Text(String(self.viewModel.resultValue).spellOut())
                            .font(.regular(size: 14))
                            .foregroundColor(self.colorScheme == .dark ? .white : .black)
                            .fixedSize(horizontal: false, vertical: true)
                        .lineLimit(2)
                        Spacer()
                    }

                    HStack {
                        Spacer()
                        Button(action: {
                            self.expanded = true
                        }) {
                            Text("Xem thêm")
                                .font(.regular(size: 14))
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
            .alert(Text("Đánh vần"), isPresented: $expanded) {
                Button(action: {
                    self.expanded = false
                }) {
                    Text("Ok".uppercased())
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }
            } message: {
                Text(String(self.viewModel.resultValue).spellOut())
                    .font(.regular(size: 18))
                    .foregroundColor(self.colorScheme == .dark ? .white : .black)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
}

struct BodyCalculatorWorking_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
            .colorScheme(.dark)
    }
}
