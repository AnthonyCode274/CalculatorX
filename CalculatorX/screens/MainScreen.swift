//
//  MainScreen.swift
//  CalculatorX
//
//  Created by Hau Nguyen on 01/09/2022.
//

import SwiftUI
import Neumorphic

struct MainScreen: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 10) {
                HStack {
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Text(viewModel.displayWorking)
                            .font(.system(size: 24))
                            .fontWeight(.regular)
                            .foregroundColor(Color.white)
                        
                        
                    }
                }
                .padding(30)
                .padding(.top, 30)
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        
                        Text(viewModel.displayResult.numberFotmat)
                            .font(.system(size: 72))
                            .fontWeight(.regular)
                            .foregroundColor(Color.white)
                        
                        Text(MTUtils.spellOutToWord(numString: viewModel.displayResult))
                            .font(.system(size: 24))
                            .fontWeight(.regular)
                            .foregroundColor(Color.white)
                    }
                }
                .padding(.horizontal, 20)
                                
                VStack(spacing: 15) {
                    row1
                    row2
                    row3
                    row4
                    row5
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 30, alignment: .bottom)
        .edgesIgnoringSafeArea(.top)
        .alert(isPresented: $viewModel.isDisplayAlert) {
            viewModel.alert
        }
    }
    
    let paddingHorizontal: CGFloat = 15
    
    
    var row1: some View {
        HStack(spacing: paddingHorizontal) {
            ButtonView("AC", .black, Color.GrayLight) {
                viewModel.clearAll()
            }
            
            ButtonView("C", .black, Color.GrayLight) {
                viewModel.backTap()
            }
            
            
            ButtonView("%", .black, Color.GrayLight) {
                viewModel.percentTap()
            }
            
            ButtonView("/", .white, Color.YellowLight) {
                viewModel.devideTap()
            }
            
        }
    }
    
    var row2: some View {
        HStack(spacing: paddingHorizontal) {
            ButtonView("7", .white, Color.GrayDark) {
                viewModel.sevenTap()
            }
            
            ButtonView("8", .white, Color.GrayDark) {
                viewModel.eightTap()
            }
            
            ButtonView("9", .white, Color.GrayDark) {
                viewModel.nineTap()
            }
            
            ButtonView("X", .white, Color.YellowLight) {
                viewModel.timesTap()
            }
            
        }
    }
    
    var row3: some View {
        HStack(spacing: paddingHorizontal) {
            ButtonView("4", .white, Color.GrayDark) {
                viewModel.fourTap()
            }
            
            ButtonView("5", .white, Color.GrayDark) {
                viewModel.fiveTap()
            }
            
            ButtonView("6", .white, Color.GrayDark) {
                viewModel.sixTap()
            }
            
            ButtonView("-", .white, Color.YellowLight) {
                viewModel.minusTap()
            }
            
            
        }
    }
    
    var row4: some View {
        HStack(spacing: paddingHorizontal) {
            ButtonView("1", .white, Color.GrayDark) {
                viewModel.oneTap()
            }
            
            ButtonView("2", .white, Color.GrayDark) {
                viewModel.twoTap()
            }
            
            ButtonView("3", .white, Color.GrayDark) {
                viewModel.threeTap()
            }
            
            ButtonView("+", .white, Color.YellowLight) {
                viewModel.plusTap()
            }
            
        }
    }
    
    var row5: some View {
        HStack(spacing: paddingHorizontal) {
            
            ZeroButton("0") {
                viewModel.zeroTap()
            }
            
            ButtonView(".", .white, Color.GrayDark) {
                viewModel.decimalTap()
            }
            
            ButtonView("=", .white, Color.YellowLight) {
                viewModel.equalsTap()
            }
        }
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
            .colorScheme(.dark)
    }
}
