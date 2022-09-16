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
    
    var body: some View {
        let width: CGFloat = UIScreen.width - 40
        let height: CGFloat = UIScreen.unit(150)
        let radius: CGFloat = UIScreen.unit(16)
        
        RoundedRectangle(cornerRadius: radius)
            .fill(Color.Neumorphic.main)
            .frame(width: width, height: height)
            .softOuterShadow()
            .overlay(
                Image("background_calculator")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth:  width - 40, maxHeight: height - 40)
                    .cornerRadius(radius / 2)
                    .clipped()
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
            .onAppear(perform: self.firstOnView)
            .onChange(of: self.viewModel.displayWorking.count) { count in
                self.workingChange(count: count)
            }
    }
    
    func firstOnView() {
        if self.viewModel.isResetOn {
            self.workingChange(count: self.viewModel.displayWorking.count)
        }
    }
    
    func workingChange(count: Int) {
        
        switch count {
        case 11:
            self.viewModel.textSize -= UIScreen.unit(2)
            break
        case 12:
            self.viewModel.textSize -= UIScreen.unit(2)
            break
        case 13:
            self.viewModel.textSize -= UIScreen.unit(2)
            break
        case 14:
            self.viewModel.textSize -= UIScreen.unit(3)
            break
        case 15:
            self.viewModel.textSize -= UIScreen.unit(3)
            break
        case 16:
            self.viewModel.textSize -= UIScreen.unit(2)
            break
        case 17:
            self.viewModel.textSize -= UIScreen.unit(3)
            break
        case 18:
            self.viewModel.statusWorking = "Limit number"
            self.viewModel.limitNumber = self.viewModel.numberWorking
            break
        default:
            break
        }
        if count > 18 {
            self.viewModel.numberWorking = self.viewModel.limitNumber
        }
    }
    
    var workingNumber: some View {
        Text(String(self.viewModel.displayResult).numberFotmat)
            .font(.custom("Kameron-Bold", size: self.viewModel.textSize))
            .foregroundColor(Color.black)
            .padding(.horizontal, UIScreen.unit(10))
            .padding(.top, UIScreen.unit(5))
    }
    
    var resultStatusWorking: some View {
        Text(self.viewModel.displayWorking.isEmpty ? "0" : self.viewModel.displayWorking)
            .font(.custom("Kameron-Regular", size: UIScreen.unit(20)))
            .foregroundColor(Color.GrayDark)
            .lineLimit(2)
            .multilineTextAlignment(.trailing)
            .padding(UIScreen.unit(10))
    }
    
    var currencyUnit: some View {
        Text("USD")
            .font(.custom("AltoneTrial-BoldOblique", size: UIScreen.unit(14)))
            .foregroundColor(Color.black)
            .padding(UIScreen.unit(10))
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
