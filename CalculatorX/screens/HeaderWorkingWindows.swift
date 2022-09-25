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
    @State private var leftSideSelected: Bool = false
    @State private var rightSideSelected: Bool = false
    
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
                        self.currencyUnitChange, alignment: .bottomTrailing
                    )
                
            )
            .sheet(isPresented: $leftSideSelected) {
                Text("Lựa chọn đơn vị đổi")
            }
            .sheet(isPresented: $rightSideSelected) {
                Text("Lựa chọn đơn vị chuyển đổi thành")
            }
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
            .font(.custom("digital-7mono", size: self.textSize))
            .foregroundColor(Color.black)
            .padding(.horizontal, UIScreen.getUnit(10))
            .padding(.top, UIScreen.getUnit(5))
    }
    
    var resultStatusWorking: some View {
        HStack(alignment: .center, spacing: 10) {
            
            Button(action: {}) {
                Image("icon-history")
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color.GrayDark)
                    .frame(width: UIScreen.getUnit(16), height: UIScreen.getUnit(16))
            }
            
            Spacer()
            
            Text("999")
                .font(.custom("digital-7", size: UIScreen.getUnit(18)))
                .foregroundColor(Color.GrayDark)
                .lineLimit(2)
                .multilineTextAlignment(.trailing)
        }
        .frame(height: UIScreen.getUnit(20), alignment: .center)
        .padding(.horizontal, UIScreen.getUnit(10))
        .padding(.top, UIScreen.getUnit(10))
    }
    
    var currencyUnitChange: some View {
        HStack {
            
            HStack(alignment: .center, spacing: 10) {
                Button(action: {
                    withAnimation {
                        self.leftSideSelected.toggle()
                    }
                }) {
                    HStack(alignment: .center, spacing: UIScreen.getUnit(5)) {
                        Text("VN")
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
                
                Image("right-arrow")
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color.GrayDark.opacity(0.5))
                    .frame(width: UIScreen.getUnit(12), height: UIScreen.getUnit(12))
            }
            
            Spacer()
            
            HStack(alignment: .center, spacing: UIScreen.getUnit(10)) {
                
                Text("22.977")
                    .font(.custom("digital-7monoitalic", size: UIScreen.getUnit(16)))
                    .foregroundColor(Color.black)
                
                Button(action: {
                    withAnimation {
                        self.rightSideSelected.toggle()
                    }
                }) {
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
