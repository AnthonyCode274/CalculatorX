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
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            self.spellOutView
            
            Spacer()
        }
        .padding(.vertical, UIScreen.getUnit(15))
        .padding(.horizontal, UIScreen.getUnit(20))
        .frame(maxWidth: UIScreen.width, alignment: .leading)
    }
    
    var spellOutView: some View {
        VStack(alignment: .leading, spacing: UIScreen.getUnit(10)) {
            HStack(alignment: .top, spacing: UIScreen.getUnit(10)) {
                Button(action: { }) {
                    Image("loudspeaker")
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(systemColor)
                        .frame(width: UIScreen.getUnit(20), height: UIScreen.getUnit(20))
                }
                
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
                    .foregroundColor(systemColor)
                    .font(.system(size: 16))
                    .fixedSize(horizontal: false, vertical: true)
                    .lineLimit(2)
            }
            
//            VStack {
            
        }
        
    }
    
    var systemColor: Color {
        return colorScheme == .dark ? Color.white : Color.black
    }
}

struct BodyCalculatorWorking_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
            .colorScheme(.dark)
    }
}
