//
//  SpecialButton.swift
//  CalculatorX
//
//  Created by Hau Nguyen on 14/09/2022.
//

import SwiftUI

struct SpecialButton: View {
    init(_ nameIcon: String = "",_ action: @escaping () -> Void) {
        self.nameIcon = nameIcon
        self.action = action
    }
    
    var nameIcon: String = ""
    let action: () -> Void
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        let width: CGFloat = UIScreen.unit((UIScreen.width / 3) - 70)
        let height: CGFloat = width * 0.70
        let radius: CGFloat = UIScreen.unit(16)
        
        Button(action: action) {
            RoundedRectangle(cornerRadius: radius)
                .fill(Color.OgranLight)
                .frame(width: width, height: height, alignment: .center)
                .softOuterShadow()
                .overlay(
                    Image(nameIcon)
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color.white)
                        .frame(width: width / 3.5, height: width / 3.5, alignment: .center)
                )
        }
    }
}

struct SpecialButton_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
            .colorScheme(.dark)
        
        CalculatorView()
            .colorScheme(.light)
    }
}
