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
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: UIScreen.getUnit(8)) {
                
                Text(string)
                    .font(.medium(size: 16))
                    .foregroundColor(self.colorScheme == .dark ? .white : .black)
                    .fixedSize(horizontal: true, vertical: false)
                    .lineLimit(1)
                
                Image("icon-drop_down")
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(self.colorScheme == .dark ? .white : .black)
                    .frame(width: UIScreen.getUnit(8), height: UIScreen.getUnit(8))
            }
            .padding(.horizontal, UIScreen.getUnit(10))
            .padding(.vertical, UIScreen.getUnit(8))
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
        
        CalculatorView()
            .colorScheme(.dark)
        
        ZStack {
            
            FunctionMoreButtonText(string: "Lượng vàng SJC") {
                
            }
            .colorScheme(.dark)
        }
        .padding(50)
        .background(Color.Neumorphic.main)
        .colorScheme(.dark)
        .previewLayout(.sizeThatFits)
        
        CalculatorView()
            .colorScheme(.light)
    }
}
