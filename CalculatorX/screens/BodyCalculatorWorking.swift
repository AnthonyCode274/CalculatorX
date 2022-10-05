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
    @ObservedObject private var viewModel: CalculatorViewModel
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            self.spellOutView
            
            Spacer()
        }
        .padding(.top, UIScreen.getUnit(20))
        .padding(.horizontal, UIScreen.getUnit(20))
        .frame(maxWidth: UIScreen.width, alignment: .leading)
    }
    
    var spellOutView: some View {
        VStack(alignment: .leading, spacing: UIScreen.getUnit(20)) {
            HStack(alignment: .top, spacing: UIScreen.getUnit(10)) {
                Button(action: { }) {
                    Image("icon-loudspeaker")
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(self.systemColor)
                        .frame(width: UIScreen.getUnit(20), height: UIScreen.getUnit(20))
                }
                
                LongText("\(self.viewModel.resultValue)".spellOut(), lineLimit: 2)
                
            }
            
            VStack(spacing: UIScreen.getUnit(10)) {
                FunctionMoreButtonText(string: "Lượng vàng SJC - \(String("66200000").numberFotmat) VNĐ / SJC Cây") {
                    
                }
                
                Text("999 * SJC Cây = \(String(Double(999 * 66200000)).numberFotmat) VNĐ")
                    .font(.bold(size: 18))
                    .foregroundColor(.yellow)
                    
            }
            .frame(maxWidth: UIScreen.width, alignment: .center)
        }
        
    }
    
    var systemColor: Color {
        return self.colorScheme == .dark ? Color.white : Color.black
    }
}

struct BodyCalculatorWorking_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
            .colorScheme(.dark)
    }
}
