//
//  FunctionMoreButton.swift
//  CalculatorX
//
//  Created by Hau Nguyen on 15/09/2022.
//

import SwiftUI
import Neumorphic

struct FunctionMoreImageButton: View {
    init(_ name: String,_ action: @escaping () -> Void) {
        self.name = name
        self.action = action
    }
    
    let name: String
    let action: () -> Void
    
    var body: some View {
        let width: CGFloat = UIScreen.unit(30)
        let radius: CGFloat = UIScreen.unit(6)
        
        Button(action: action) {
            Image(name)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width, height: width, alignment: .center)
                .background(
                    RoundedRectangle(cornerRadius: radius)
                        .fill(Color.Neumorphic.secondary)
                        .frame(width: width, height: width, alignment: .center)
                        .softOuterShadow()
                )
        }
        
    }
}

struct FunctionMoreImageButton_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
            .colorScheme(.dark)
        
        CalculatorView()
            .colorScheme(.light)
    }
}
