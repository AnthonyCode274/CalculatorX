//
//  FunctionMoreButtonText.swift
//  CalculatorX
//
//  Created by Hau Nguyen on 18/09/2022.
//

import SwiftUI
import Neumorphic

struct FunctionMoreButtonText: View {
    init(string: String, action: @escaping () -> Void) {
        self.string = string
        self.action = action
    }
    
    let string: String
    let action: () -> Void
    @Environment(\.colorScheme) private var colorScheme
    
    var color: Color {
        return self.colorScheme == .light ? .black : .white
    }
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: UIScreen.getUnit(8)) {
                
                Image("icon-drop_down")
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(color)
                    .frame(width: UIScreen.getUnit(12), height: UIScreen.getUnit(12))
                
                Text(string)
                    .font(.bold(size: UIScreen.getUnit(14)))
                    .foregroundColor(color)
                    .fixedSize(horizontal: true, vertical: false)
                
            }
            .padding(UIScreen.getUnit(8))
            .background(
                RoundedRectangle(cornerRadius: UIScreen.getUnit(8))
                    .fill(Color.Neumorphic.main)
                    .softOuterShadow()
            )
        }
    }
}

struct FunctionMoreButtonText_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            
            FunctionMoreButtonText(string: "Lượng vàng SJC") {
                
            }
            .colorScheme(.light)
        }
        .padding(50)
        .background(Color.Neumorphic.main)
        .colorScheme(.light)
        .previewLayout(.sizeThatFits)
        
        ZStack {
            
            FunctionMoreButtonText(string: "Lượng vàng SJC") {
                
            }
            .colorScheme(.dark)
        }
        .padding(50)
        .background(Color.Neumorphic.main)
        .colorScheme(.dark)
        .previewLayout(.sizeThatFits)
    }
}
