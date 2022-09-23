//
//  HeaderWorkingWindows.swift
//  CalculatorX
//
//  Created by Hau Nguyen on 14/09/2022.
//

import SwiftUI

struct HeaderWorkingWindows: View {
    init(viewModel: CalculatorViewModel) {
        self.viewModel = viewModel
    }
    @ObservedObject var viewModel: CalculatorViewModel
    @Environment(\.colorScheme) private var colorScheme
    @State private var textSize: CGFloat = UIScreen.getUnit(38)
    
    var body: some View {
        let width: CGFloat = UIScreen.width - 30
        let height: CGFloat = UIScreen.getUnit(140)
        let radius: CGFloat = UIScreen.getUnit(16)
        
        RoundedRectangle(cornerRadius: radius)
            .fill(Color.Neumorphic.main)
            .frame(width: width, height: height)
            .softOuterShadow()
            .overlay(
                Image("background_calculator")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth:  width - 30, maxHeight: height - 30)
                    .cornerRadius(radius / 2)
                    .clipped()
                    .softInnerShadow(RoundedRectangle(cornerRadius: radius / 2),
                                     darkShadow: .black.opacity(0.5),
                                     lightShadow: .clear,
                                     spread: 0.15,
                                     radius: 6)
                    .overlay(
                        self.resultStatusWorking, alignment: .topTrailing
                    )
                    .overlay(
                        self.workingNumber, alignment: .trailing
                    )
                    .overlay(
                        self.currencyUnit, alignment: .bottomTrailing
                    )
                
            )
    }
    
    func firstOnView() {
        
    }
    
    var currentFlag: some View {
        Button(action: {}) {
            Image("vietnam")
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fill)
                .frame(width: 24, height: 24)
                .padding(.vertical, UIScreen.getUnit(6))
                .padding(.horizontal, UIScreen.getUnit(10))
                
        }
        
    }
    
    var workingNumber: some View {
        Text("999")
            .font(.custom("digital", size: self.textSize))
            .foregroundColor(Color.black)
            .padding(.horizontal, UIScreen.getUnit(10))
            .padding(.top, UIScreen.getUnit(5))
    }
    
    var resultStatusWorking: some View {
        Text("999")
            .font(.custom("Kameron-Bold", size: UIScreen.getUnit(20)))
            .foregroundColor(Color.GrayDark)
            .lineLimit(2)
            .multilineTextAlignment(.trailing)
            .padding(UIScreen.getUnit(10))
    }
    
    var currencyUnit: some View {
        HStack {
            
            Spacer()
            
            HStack(alignment: .center, spacing: UIScreen.getUnit(10)) {
                
                Text("22.977")
                    .font(.custom("AltoneTrial-RegularOblique", size: UIScreen.getUnit(14)))
                    .foregroundColor(Color.black)
                
                Button(action: {}) {
                    HStack(alignment: .center, spacing: UIScreen.getUnit(5)) {
                        Text("USD")
                            .font(.custom("AltoneTrial-BoldOblique", size: UIScreen.getUnit(14)))
                            .foregroundColor(Color.black)
                        
                        Image("drop-down")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color.black)
                            .frame(width: UIScreen.getUnit(10),
                                   height: UIScreen.getUnit(10))
                    }
                }
            }
        }
        .padding(UIScreen.getUnit(6))
    }
}

struct HeaderWorkingWindows_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
            .colorScheme(.dark)
        
//        CalculatorView()
//            .colorScheme(.light)
    }
}
