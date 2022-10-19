//
//  KeyboardCalculatorView.swift
//  CalculatorX
//
//  Created by HauNguyen on 05/10/2565 BE.
//

import SwiftUI

struct KeyboardCalculatorView: View {
    @ObservedObject var viewModel: CalculationViewModel
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        VStack(alignment: .center, spacing: UIScreen.getUnit(10)) {
            
            HStack {
                self.TotalAllButton
                
                Spacer()
                
                self.roleBackButton
            }
            
            VStack(alignment: .center, spacing: UIScreen.getUnit(10)) {
                
                self.row0
                
                self.row1
                
                self.row2
                
                self.row3
                
                self.row4
            }
        }
    }
    
    var TotalAllButton: some View {
        Button(action: {
            
        }) {
            Circle()
                .fill(Color.Neumorphic.main)
                .frame(width: UIScreen.getUnit(30), height: UIScreen.getUnit(30), alignment: .center)
                .softOuterShadow()
                .overlay(
                    Text("GT")
                        .font(.bold(size: 16))
                        .foregroundColor(.primary)
                )
        }
        .padding(.horizontal, UIScreen.getUnit(20))
    }
    
    var roleBackButton: some View {
        Button(action: {
            self.viewModel.backRemove()
        }) {
            Image(ImageStyle.name.removeIcon)
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
                .foregroundColor(self.colorScheme == .dark ? .white : .black)
                .frame(width: UIScreen.getUnit(30), height: UIScreen.getUnit(30), alignment: .center)
                .softOuterShadow()
        }
        .padding(.horizontal, UIScreen.getUnit(20))
    }
    
    let paddingH: CGFloat = UIScreen.getUnit(2)
    let paddingV: CGFloat = UIScreen.getUnit(20)
    
    var row0: some View {
        HStack(spacing: self.paddingH) {
            Spacer()
            
            CalculatorButtonImage(ImageStyle.name.acIcon, backgroundColor: Color.OgranLight) {
                self.viewModel.resetAll()
            }
            
            Spacer()
            
            CalculatorButtonImage(ImageStyle.name.plusOrSubtractIcon, backgroundColor: Color.OgranLight) {
                self.viewModel.setValue("+/-")
            }
            
            Spacer()
            
            CalculatorButtonImage(ImageStyle.name.percentIcon, backgroundColor: Color.OgranLight) {
                self.viewModel.setValue("%")
            }
            
            Spacer()
            
            CalculatorButtonImage(ImageStyle.name.divideIcon, backgroundColor: Color.OgranLight) {
                self.viewModel.setValue("/")
            }
            
            Spacer()
            
        }
    }
    
    var row1: some View {
        HStack(spacing: self.paddingH) {
            Spacer()
            
            CalculatorButtonText("1") {
                self.viewModel.setValue("1")
            }
            
            Spacer()
            
            CalculatorButtonText("2") {
                self.viewModel.setValue("2")
            }
            
            Spacer()
            
            CalculatorButtonText("3") {
                self.viewModel.setValue("3")
            }
            
            Spacer()
            
            
            CalculatorButtonImage(ImageStyle.name.multlyIcon, backgroundColor: Color.OgranLight) {
                self.viewModel.setValue("*")
            }
            
            Spacer()
            
        }
    }
    
    var row2: some View {
        HStack(spacing: self.paddingH) {
            Spacer()
            
            CalculatorButtonText("4") {
                self.viewModel.setValue("4")
            }
            
            Spacer()
            
            CalculatorButtonText("5") {
                self.viewModel.setValue("5")
            }
            
            Spacer()
            
            CalculatorButtonText("6") {
                self.viewModel.setValue("6")
            }
            
            Spacer()
            
            CalculatorButtonImage(ImageStyle.name.subtractIcon, backgroundColor: Color.OgranLight) {
                self.viewModel.setValue("-")
            }
            
            Spacer()
            
        }
    }
    
    var row3: some View {
        HStack(spacing: self.paddingH) {
            Spacer()
            
            CalculatorButtonText("7") {
                self.viewModel.setValue("7")
            }
            
            Spacer()
            
            CalculatorButtonText("8") {
                self.viewModel.setValue("8")
            }
            
            Spacer()
            
            CalculatorButtonText("9") {
                self.viewModel.setValue("9")
            }
            
            Spacer()
            
            CalculatorButtonImage(ImageStyle.name.plusIcon, backgroundColor: Color.OgranLight) {
                self.viewModel.setValue("+")
            }
            
            Spacer()
        }
    }
    
    var row4: some View {
        HStack(spacing: self.paddingH) {
            Spacer()
            
            CalculatorButtonText("000") {
                self.viewModel.setValue("000")
            }
            
            Spacer()
            
            CalculatorButtonText("0") {
                self.viewModel.setValue("0")
            }
            
            Spacer()
            
            CalculatorButtonText(".") {
                self.viewModel.setValue(".")
            }
            
            Spacer()
            
            CalculatorButtonImage(ImageStyle.name.equalIcon, backgroundColor: Color.OgranLight) {
                self.viewModel.equalButton()
            }
            
            Spacer()
        }
    }
}

struct KeyboardCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
    }
}
