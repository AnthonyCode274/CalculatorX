//
//  ListViewSelectionRate.swift
//  CalculatorX
//
//  Created by HauNguyen on 17/10/2565 BE.
//

import SwiftUI

struct ListViewSelectionRate: View {
    var data: [Currency]
    @ObservedObject var viewModel: CurrencyViewModel
    @Binding var isPresented: Bool
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        ZStack {
            Color.Neumorphic.main.ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: UIScreen.getUnit(10)) {
                    ForEach(self.data) { item in
                        VStack(spacing: UIScreen.getUnit(5)) {
                            Button(action: {
                                self.viewModel.currency = item
                                self.isPresented = false
                            }) {
                                HStack {
                                    Text("\(item.currencyName)")
                                        .font(.regular(size: 16))
                                        .foregroundColor(self.colorScheme == .dark ? .white : .black)
                                        .softOuterShadow()
                                    
                                    Spacer()
                                    
                                    Circle()
                                        .fill(Color.Neumorphic.main)
                                        .frame(width: UIScreen.getUnit(20), height: UIScreen.getUnit(20))
                                        .softOuterShadow()
                                        .overlay(
                                            Circle()
                                                .fill(self.colorForeground(item))
                                                .frame(width: UIScreen.getUnit(10), height: UIScreen.getUnit(10))
                                        )
                                        
                                }
                                .padding(.horizontal, UIScreen.getUnit(20))
                                .padding(.vertical, UIScreen.getUnit(5))
                            }

                            Divider()
                        }
                    }
                }
                .padding(.vertical, UIScreen.getUnit(20))
            }
        }
    }
    
    func colorForeground(_ item: Currency) -> Color {
        return self.matchId(item) ? .OviLight : .black.opacity(0.5)
    }
    
    func matchId(_ item: Currency) -> Bool {
        return self.viewModel.currency?.id == item.id
    }
}

struct ListViewSelectionRate_Previews: PreviewProvider {
    static var previews: some View {
        ListViewSelectionRate(data: [
            Currency(currencyId: 0, currencyName: "Giá vàng SJC"),
            Currency(currencyId: 1, currencyName: "Đô la Mỹ"),
            Currency(currencyId: 2, currencyName: "Đô la Úc"),
            Currency(currencyId: 3, currencyName: "Yên Nhật"),
            Currency(currencyId: 4, currencyName: "Bản Anh"),
            Currency(currencyId: 5, currencyName: "Won"),
            Currency(currencyId: 6, currencyName: "Chinese")
        ], viewModel: CurrencyViewModel(), isPresented: .constant(false))
        .colorScheme(.light)
    }
}
