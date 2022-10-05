//
//  HeaderWorkingWindows.swift
//  CalculatorX
//
//  Created by Hau Nguyen on 14/09/2022.
//

import SwiftUI

struct HeaderWorkingWindows: View {
    init(viewModel: CalculatorViewModel) {
        self.viewModel = viewModel
    }
    @ObservedObject var viewModel: CalculatorViewModel
    @Environment(\.colorScheme) private var colorScheme
    @State private var number: Double = 0
    
    var body: some View {
        let width: CGFloat = UIScreen.width - 30
        let height: CGFloat = UIScreen.getUnit(140)
        let radius: CGFloat = UIScreen.getUnit(16)
        
        RoundedRectangle(cornerRadius: radius)
            .fill(Color.Neumorphic.main)
            .frame(width: width, height: height)
            .softOuterShadow()
            .overlay(
                Image("background_calculator")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth:  width - 30, maxHeight: height - 30)
                    .cornerRadius(radius / 2)
                    .clipped()
                    .softInnerShadow(
                        RoundedRectangle(cornerRadius: radius / 2),
                        darkShadow: .black.opacity(0.5),
                        lightShadow: .clear,
                        spread: 0.15,
                        radius: 6
                    )
                    .overlay(
                        self.resultStatusWorking, alignment: .topTrailing
                    )
                    .overlay(
                        self.workingNumber, alignment: .bottomTrailing
                    )
                
            )
            .onAppear() {
                self.viewModel.currentWorking = "11111111111111111111"
                self.viewModel.resultValue = Double(11111111111111111111)
            }
    }
    
    var workingNumber: some View {
        Text(self.viewModel.currentWorking.isEmpty ? "0" : self.viewModel.currentWorking)
            .font(.custom("digital-7mono", size: self.resizeWorkingNumber()))
            .foregroundColor(Color.black)
            .padding(.horizontal, UIScreen.getUnit(10))
            .padding(.vertical, UIScreen.getUnit(10))
    }
    
    var resultStatusWorking: some View {
        HStack(alignment: .center, spacing: UIScreen.getUnit(10)) {
            
            HStack(alignment: .center, spacing: UIScreen.getUnit(2)) {
                
                Image("icon-history")
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.GrayDark)
                    .frame(width: UIScreen.getUnit(14), height: UIScreen.getUnit(14))
                
                
                Text("\(self.viewModel.currentWorking.count) - \(self.resizeWorkingNumber())")
                    .font(.custom("digital-7monoitalic", size: UIScreen.getUnit(16)))
                    .foregroundColor(Color.GrayDark)
                    .lineLimit(1)
                    .multilineTextAlignment(.leading)
                
            }
            .frame(height: UIScreen.getUnit(20), alignment: .bottom)
            
            Spacer()
            
            Text("\(self.viewModel.workingMiniShow)")
                .font(.custom("digital-7monoitalic", size: UIScreen.getUnit(20)))
                .foregroundColor(Color.GrayDark)
                .lineLimit(2)
                .multilineTextAlignment(.trailing)
        }
        .frame(height: UIScreen.getUnit(20), alignment: .center)
        .padding(UIScreen.getUnit(10))
    }

    func resizeWorkingNumber() -> CGFloat {
        var size: CGFloat = 58
        let count = self.viewModel.currentWorking.count
        
        
        switch count {
        case 11:
            size = 54
            break;
        case 12:
            size = 50
            break;
        case 13:
            size = 46
            break;
        case 14:
            size = 44
            break;
        case 15:
            size = 42
            break;
        case 16:
            size = 38
            break;
        case 17:
            size = 36
            break;
        case 18:
            size = 34
            break;
        case 19:
            size = 32
            break;
        case 20:
            size = 30
            break;
        default:
            size = 58
            break;
        }
        
        return UIScreen.getUnit(size)
    }
}

struct HeaderWorkingWindows_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
            .colorScheme(.dark)
        
//        CalculatorView()
//            .colorScheme(.light)
    }
}
