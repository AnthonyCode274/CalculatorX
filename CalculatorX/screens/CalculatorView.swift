//
//  CalculatorView.swift
//  CalculatorX
//
//  Created by Hau Nguyen on 13/09/2022.
//

import SwiftUI
import Neumorphic

struct CalculatorView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.Neumorphic.main.ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                HeaderWorkingWindows()
                
//                BodyCalculatorWorking()
                
                Spacer()
                
                VStack(alignment: .center, spacing: UIScreen.unit(20)) {
                    //roleBackButton
                    
                    row0
                    
                    row1
                    
                    row2
                    
                    row3
                    
                    row4
                }
                .padding(.bottom, UIScreen.unit(20))
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
                
            }
            
            Spacer()
            
            SpecialButton("plus_and_minus") {
                
            }
            
            Spacer()
            
            SpecialButton("percent") {
                
            }
            
            Spacer()
            
            SpecialButton("divide") {
                
            }
            
            Spacer()
            
        }
    }
    
    var row1: some View {
        HStack(spacing: 0) {
            Spacer()
            
            CalculatorNumberButton("1") {
                
            }
            
            Spacer()
            
            CalculatorNumberButton("2") {
                
            }
            
            Spacer()
            
            CalculatorNumberButton("3") {
                
            }
            
            Spacer()
            
            
            
            SpecialButton("crossed") {
                
            }
            
            Spacer()
            
        }
    }
    
    var row2: some View {
        HStack(spacing: 0) {
            Spacer()
            
            CalculatorNumberButton("4") {
                
            }
            
            Spacer()
            
            CalculatorNumberButton("5") {
                
            }
            
            Spacer()
            
            CalculatorNumberButton("6") {
                
            }
            
            Spacer()
            
            SpecialButton("minus") {
                
            }
            
            Spacer()
            
        }
    }
    
    var row3: some View {
        HStack(spacing: 0) {
            Spacer()
            
            CalculatorNumberButton("7") {
                
            }
            
            Spacer()
            
            CalculatorNumberButton("8") {
                
            }
            
            Spacer()
            
            CalculatorNumberButton("9") {
                
            }
            
            Spacer()
            
            SpecialButton("add") {
                
            }
            
            Spacer()
        }
    }
    
    var row4: some View {
        HStack(spacing: 0) {
            Spacer()
            
            CalculatorNumberButton("?") {
                
            }
            
            Spacer()
            
            CalculatorNumberButton("0") {
                
            }
            
            Spacer()
            
            CalculatorNumberButton(".") {
                
            }
            
            Spacer()
            
            SpecialButton("equal") {
                
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
