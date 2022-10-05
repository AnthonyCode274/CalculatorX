//
//  CalculatorView.swift
//  CalculatorX
//
//  Created by Hau Nguyen on 13/09/2022.
//

import SwiftUI
import Neumorphic

struct CalculatorView: View {
    @Environment(\.colorScheme) private var colorScheme
    @StateObject var viewModel = CalculatorViewModel()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.Neumorphic.main.ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                HeaderWorkingWindows(viewModel: viewModel)
                
                BodyCalculatorWorking(viewModel: viewModel)
                
                Spacer()
                
                VStack(alignment: .center, spacing: UIScreen.getUnit(10)) {
                    
                    roleBackButton
                    
                    row0
                    
                    row1
                     
                    row2
                    
                    row3
                    
                    row4
                }
            }
            .padding(.vertical, UIScreen.getUnit(15))
        }
        .frame(maxWidth: UIScreen.width)
    }
    
    var roleBackButton: some View {
        VStack(alignment: .trailing) {
            Button(action: {
                self.viewModel.backButtonClear()
            }) {
                Image("icon-delete")
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(
                        colorScheme == .dark ? Color.white : Color.black
                    )
                    .frame(width: UIScreen.getUnit(30), height: UIScreen.getUnit(30), alignment: .center)
                    .softOuterShadow()
            }
            .padding(.horizontal, UIScreen.getUnit(20))
        }
        .frame(maxWidth: UIScreen.width, alignment: .trailing)
    }
    
    let paddingH: CGFloat = UIScreen.getUnit(20)
    let paddingV: CGFloat = UIScreen.getUnit(20)
    
    var row0: some View {
        HStack(spacing: 0) {
            Spacer()
            
            CalculatorButtonImage("icon-letter_ac", backgroundColor: Color.OgranLight) {
                self.viewModel.clearAll()
            }
            
            Spacer()
            
            CalculatorButtonImage("icon-plus_and_minus", backgroundColor: Color.OgranLight) {
                self.viewModel.setValue("+/-")
            }
            
            Spacer()
            
            CalculatorButtonImage("icon-percent", backgroundColor: Color.OgranLight) {
                self.viewModel.setValue("%")
            }
            
            Spacer()
            
            CalculatorButtonImage("icon-divide", backgroundColor: Color.OgranLight) {
                self.viewModel.setValue("/")
            }
            
            Spacer()
            
        }
    }
    
    var row1: some View {
        HStack(spacing: 0) {
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
            
            
            CalculatorButtonImage("icon-crossed", backgroundColor: Color.OgranLight) {
                self.viewModel.setValue("*")
            }
            
            Spacer()
            
        }
    }
    
    var row2: some View {
        HStack(spacing: 0) {
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
            
            CalculatorButtonImage("icon-minus", backgroundColor: Color.OgranLight) {
                self.viewModel.setValue("-")
            }
            
            Spacer()
            
        }
    }
    
    var row3: some View {
        HStack(spacing: 0) {
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
            
            CalculatorButtonImage("icon-add", backgroundColor: Color.OgranLight) {
                self.viewModel.setValue("+")
            }
            
            Spacer()
        }
    }
    
    var row4: some View {
        HStack(spacing: 0) {
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
            
            CalculatorButtonImage("icon-equal", backgroundColor: Color.OgranLight) {
                self.viewModel.equalResult()
            }
            
            Spacer()
        }
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
            .colorScheme(.dark)
        
//        CalculatorView()
//            .colorScheme(.light)
    }
}
