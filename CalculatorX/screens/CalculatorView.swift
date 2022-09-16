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
                
                VStack(alignment: .leading) {
                    Button(action: {}) {
                        Image("loudspeaker")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color.white)
                            .frame(width: 24, height: 24)
                    }
                    .padding(UIScreen.unit(5))
                    
                    Text(viewModel.displayResult.spellOut().capitalizingFirstLetter())
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(.top, UIScreen.unit(10))
                .frame(width: UIScreen.width - UIScreen.unit(40), alignment: .leading)

                Spacer()

                BodyCalculatorWorking(viewModel: viewModel)
                
                
                VStack(alignment: .center, spacing: UIScreen.unit(20)) {
                    
                    row0
                    
                    row1
                    
                    row2
                    
                    row3
                    
                    row4
                }
                .padding(.bottom, UIScreen.unit(10))
            }
        }
    }
    
    var roleBackButton: some View {
        Button(action: {
        
        }) {
            RoundedRectangle(cornerRadius: UIScreen.unit(14))
                .fill(Color.Neumorphic.main)
                .frame(width: UIScreen.unit(60),
                       height: UIScreen.unit(40), alignment: .center)
                .softOuterShadow()
                .overlay(
                    Image("delete_icon")
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(
                            colorScheme == .dark ? Color.white : Color.black
                        )
                        .frame(width: UIScreen.unit(30),
                               height: UIScreen.unit(30), alignment: .center)
                )
        }
    }
    
    let paddingH: CGFloat = UIScreen.unit(20)
    
    var row0: some View {
        HStack(spacing: 0) {
            Spacer()
            
            CalculatorIconButton("letter_ac_icon") {
                viewModel.resetAll()
            }
            
            Spacer()
            
            CalculatorIconButton("letter_c_icon") {
                self.viewModel.backTap()
            }
            
            Spacer()
            
            SpecialButton("plus_and_minus") {
                
            }
            
            Spacer()
            
            SpecialButton("percent") {
                self.viewModel.percentTap()
            }
            
            Spacer()
            
        }
    }
    
    var row1: some View {
        HStack(spacing: 0) {
            Spacer()
            
            CalculatorNumberButton("1") {
                self.viewModel.oneTap()
            }
            
            Spacer()
            
            CalculatorNumberButton("2") {
                self.viewModel.twoTap()
            }
            
            Spacer()
            
            CalculatorNumberButton("3") {
                self.viewModel.threeTap()
            }
            
            Spacer()
            
            
            SpecialButton("divide") {
                self.viewModel.devideTap()
            }
            .disabled(self.viewModel.specialSelection == .devide ? true : false)
            
            Spacer()
            
        }
    }
    
    var row2: some View {
        HStack(spacing: 0) {
            Spacer()
            
            CalculatorNumberButton("4") {
                self.viewModel.fourTap()
            }
            
            Spacer()
            
            CalculatorNumberButton("5") {
                self.viewModel.fiveTap()
            }
            
            Spacer()
            
            CalculatorNumberButton("6") {
                self.viewModel.sixTap()
            }
            
            Spacer()
            
            SpecialButton("crossed") {
                self.viewModel.timesTap()
            }
            .disabled(self.viewModel.specialSelection == .times ? true : false)
            
            Spacer()
            
        }
    }
    
    var row3: some View {
        HStack(spacing: 0) {
            Spacer()
            
            CalculatorNumberButton("7") {
                self.viewModel.sevenTap()
            }
            
            Spacer()
            
            CalculatorNumberButton("8") {
                self.viewModel.eightTap()
            }
            
            Spacer()
            
            CalculatorNumberButton("9") {
                self.viewModel.nineTap()
            }
            
            Spacer()
            
            SpecialButton("minus") {
                self.viewModel.minusTap()
            }
            .disabled(self.viewModel.specialSelection == .minus ? true : false)
            
            Spacer()
        }
    }
    
    var row4: some View {
        HStack(spacing: 0) {
            Spacer()
            
            CalculatorNumberButton("0") {
                self.viewModel.zeroTap()
            }
            
            Spacer()
            
            CalculatorNumberButton(".") {
                self.viewModel.decimalTap()
            }
            
            Spacer()
            
            SpecialButton("equal") {
                self.viewModel.equalsTap()
            }
            
            Spacer()
            
            SpecialButton("add") {
                self.viewModel.plusTap()
            }
            .disabled(self.viewModel.specialSelection == .plus ? true : false)
            
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
