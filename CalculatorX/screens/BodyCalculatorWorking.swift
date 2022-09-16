//
//  BodyCalculatorWorking.swift
//  CalculatorX
//
//  Created by Hau Nguyen on 14/09/2022.
//

import SwiftUI

struct BodyCalculatorWorking: View {
    init(viewModel: CalculatorViewModel) {
        self.viewModel = viewModel
    }
    @ObservedObject var viewModel: CalculatorViewModel
    
    var body: some View {
        let radius: CGFloat = UIScreen.unit(16)
        let width: CGFloat = UIScreen.width - 40
        
        ZStack {
            
            HStack(alignment: .center, spacing: UIScreen.unit(20)) {
                
                FunctionMoreImageButton("number_to_word_icon") {
                    viewModel.numberWorking += "9"
                }
                
                FunctionMoreImageButton("number_to_word_icon") {
                    viewModel.resetAll()
                }
                
                FunctionMoreImageButton("number_to_word_icon") {
                    
                }
                
                FunctionMoreImageButton("number_to_word_icon") {
                    
                }
                
                FunctionMoreImageButton("number_to_word_icon") {
                    
                }
                
                FunctionMoreImageButton("number_to_word_icon") {
                    
                }
                
//                TextBody(title: "Balance", content: "$301.1")
                
//                TextBody(title: "Mo. contribution", content: "$100")
                
//                TextBody(title: "Interest rate, %", content: "6")
//                
//                TextBody(title: "Lenght", content: "12 mo.")
                    
            }
            .padding(UIScreen.unit(20))
            .background(
                RoundedRectangle(cornerRadius: radius)
                    .fill(Color.Neumorphic.main)
                    .softOuterShadow()
                    .frame(width: width)
            )
            .padding(UIScreen.unit(20))
        }
    }
}

struct BodyCalculatorWorking_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
            .colorScheme(.dark)
        
        CalculatorView()
            .colorScheme(.light)
    }
}
