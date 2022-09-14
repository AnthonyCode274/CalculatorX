//
//  HeaderWorkingWindows.swift
//  CalculatorX
//
//  Created by Hau Nguyen on 14/09/2022.
//

import SwiftUI

struct HeaderWorkingWindows: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        let width: CGFloat = UIScreen.width - 40
        let height: CGFloat = UIScreen.unit(130)
        let radius: CGFloat = UIScreen.unit(16)
        let statusWorking: CGFloat = UIScreen.unit(20)
        let workingSize: CGFloat = UIScreen.unit(40)
        
        RoundedRectangle(cornerRadius: radius)
            .fill(Color.Neumorphic.main)
            .frame(width: width, height: height)
            .softOuterShadow()
            .overlay(
                Image("background_calculator")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth:  width - 40, maxHeight: height - 40)
                    .cornerRadius(radius / 2)
                    .clipped()
                    .overlay(
                        VStack(alignment: .trailing, spacing: 0) {
                            Text("Final balance")
                                .font(.custom("AltoneTrial-Regular", size: statusWorking))
                                .foregroundColor(Color.black)
                            
                            Text("$3,501.471")
                                .font(.custom("Gajkley", size: workingSize))
                                .foregroundColor(Color.black)
                        }.padding(.horizontal, UIScreen.unit(20)), alignment: .trailing
                    )
                    .softInnerShadow(
                        RoundedRectangle(cornerRadius: radius / 2),
                        darkShadow: Color.Neumorphic.darkShadow,
                        lightShadow: Color.clear,
                        spread: 0.115,
                        radius: radius / 2)
            )
    }
}

struct HeaderWorkingWindows_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.Neumorphic.main
            
            HeaderWorkingWindows()
        }
        .ignoresSafeArea()
        .colorScheme(.dark)
    }
}
