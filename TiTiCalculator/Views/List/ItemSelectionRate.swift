//
//  ItemSelectionRate.swift
//  CalculatorX
//
//  Created by HauNguyen on 17/10/2565 BE.
//

import SwiftUI

struct ItemSelectionRate: View {
    var item: Currency
    @Binding var itemSelected: Currency
    @Binding var isPresented: Bool
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        Button(action: {
            self.itemSelected = self.item
            self.isPresented = false
        }) {
            HStack {
                Group {
                    Text("\(self.item.currencyName)" + " ")
                        .font(.medium(size: 16))
                    
                    Text("(\(self.item.currencyCode))")
                        .font(.custom("AltoneTrial-BoldOblique", size: UIScreen.getUnit(14)))
                        
                }
                .foregroundColor(self.colorScheme == .dark ? .white : .black)
                .softOuterShadow()
                
                Spacer()
                
                Circle()
                    .fill(Color.Neumorphic.main)
                    .frame(width: UIScreen.getUnit(20), height: UIScreen.getUnit(20))
                    .softOuterShadow()
                    .overlay(
                        Circle()
                            .fill(self.colorForeground(self.item))
                            .frame(width: UIScreen.getUnit(10), height: UIScreen.getUnit(10))
                    )
                    
            }
            .padding(.horizontal, UIScreen.getUnit(20))
            .padding(.vertical, UIScreen.getUnit(5))
        }
    }
    
    func colorForeground(_ item: Currency) -> Color {
        return self.matchId(item) ? .OviLight : .black.opacity(0.5)
    }
    
    func matchId(_ item: Currency) -> Bool {
        return self.itemSelected.id == item.id
    }
}

struct ItemSelectionRate_Previews: PreviewProvider {
    static var previews: some View {
        ItemSelectionRate(item: Currency(), itemSelected: .constant(Currency()), isPresented: .constant(false))
    }
}
