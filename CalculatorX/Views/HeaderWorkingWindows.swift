//
//  HeaderWorkingWindows.swift
//  CalculatorX
//
//  Created by Hau Nguyen on 14/09/2022.
//

import SwiftUI
import Neumorphic

struct HeaderWorkingWindows: View {
    @EnvironmentObject private var viewModel: CalculatorViewModel
//    @StateObject private var viewModel = CalculatorViewModel()
    
    var workingShow: some View {
        Button(action: {}) {
            Text("\(viewModel.displayText)")
                .font(.custom("digital-7mono", size: 80))
                .foregroundColor(Color.black)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .truncationMode(.head)
        }
    }
    
    @ViewBuilder var displayStateOn: some View {
        if viewModel.displayStateOn == "=" {
            Image("icon-equal")
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.black)
                .frame(width: 16, height: 16)
        } else {
            Text("\(viewModel.displayStateOn)".uppercased())
                .font(.custom("AltoneTrial-BoldOblique", size: 16))
                .foregroundColor(.black)
        }
    }
    
    var body: some View {
        let width: CGFloat = UIScreen.screenWidth
        let height: CGFloat = UIScreen.getPer(0.25)
        let radius: CGFloat = UIScreen.getUnit(8)
        
        Image("background_calculator")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(maxWidth: width, maxHeight: height)
            .clipShape(RoundedRectangle(cornerRadius: radius))
            .background(
                RoundedRectangle(cornerRadius: radius)
                    .fill(Color.Neumorphic.main)
                    .frame(maxWidth: width, maxHeight: height)
                    .softOuterShadow()
            )
            .overlay(
                self.workingShow
                    .padding(.horizontal, UIScreen.getUnit(10))
                    .padding(.vertical, UIScreen.getUnit(5))
                    .padding(.top, UIScreen.getUnit(10)), alignment: .bottomTrailing
            )
            .overlay(
                self.displayStateOn
                    .padding(UIScreen.getUnit(8)), alignment: .topLeading
            )
            .padding(.horizontal, UIScreen.getUnit(10))
    }
}

struct HeaderWorkingWindows_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.Neumorphic.main.ignoresSafeArea()
            
            HeaderWorkingWindows()
        }
        .colorScheme(.dark)
    }
}
