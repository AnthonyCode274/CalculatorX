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
            Button(action: {}) {
                Image("delete_icon")
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
    
    var row0: some View {
        HStack(spacing: 0) {
            Spacer()
            
            CalculatorButtonImage("letter_ac_icon", backgroundColor: Color.OgranLight) {
                
            }
            
            Spacer()
            
            CalculatorButtonImage("plus_and_minus", backgroundColor: Color.OgranLight) {
                
            }
            
            Spacer()
            
            CalculatorButtonImage("percent", backgroundColor: Color.OgranLight) {
                
            }
            
            Spacer()
            
            CalculatorButtonImage("divide", backgroundColor: Color.OgranLight) {
                
            }
            
            Spacer()
            
        }
    }
    
    var row1: some View {
        HStack(spacing: 0) {
            Spacer()
            
            CalculatorButtonText("1") {
                
            }
            
            Spacer()
            
            CalculatorButtonText("2") {
                
            }
            
            Spacer()
            
            CalculatorButtonText("3") {
                
            }
            
            Spacer()
            
            
            CalculatorButtonImage("crossed", backgroundColor: Color.OgranLight) {
                
            }
            
            Spacer()
            
        }
    }
    
    var row2: some View {
        HStack(spacing: 0) {
            Spacer()
            
            CalculatorButtonText("4") {
                
            }
            
            Spacer()
            
            CalculatorButtonText("5") {
                
            }
            
            Spacer()
            
            CalculatorButtonText("6") {
                
            }
            
            Spacer()
            
            CalculatorButtonImage("minus", backgroundColor: Color.OgranLight) {
                
            }
            
            Spacer()
            
        }
    }
    
    var row3: some View {
        HStack(spacing: 0) {
            Spacer()
            
            CalculatorButtonText("7") {
                
            }
            
            Spacer()
            
            CalculatorButtonText("8") {
                
            }
            
            Spacer()
            
            CalculatorButtonText("9") {
                
            }
            
            Spacer()
            
            CalculatorButtonImage("add", backgroundColor: Color.OgranLight) {
                
            }
            
            Spacer()
        }
    }
    
    var row4: some View {
        HStack(spacing: 0) {
            Spacer()
            
            CalculatorButtonText("000") {
                
            }
            
            Spacer()
            
            CalculatorButtonText("0") {
                
            }
            
            Spacer()
            
            CalculatorButtonText(".") {
                
            }
            
            Spacer()
            
            CalculatorButtonImage("equal", backgroundColor: Color.OgranLight) {
                
            }
            
            Spacer()
        }
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
            .colorScheme(.dark)
        
        CalculatorView()
            .colorScheme(.light)
    }
}
