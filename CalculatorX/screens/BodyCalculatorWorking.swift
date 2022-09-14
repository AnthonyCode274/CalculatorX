//
//  BodyCalculatorWorking.swift
//  CalculatorX
//
//  Created by Hau Nguyen on 14/09/2022.
//

import SwiftUI

struct BodyCalculatorWorking: View {
    init(title: String = "", content: String = "") {
        self.title = title
        self.content = content
    }
    var title: String = ""
    var content: String = ""
    
    var body: some View {
        let radius: CGFloat = UIScreen.unit(16)
        
        ZStack {
            
            VStack(alignment: .trailing, spacing: UIScreen.unit(10)) {
                TextBody(title: "Balance", content: "$301.1")
                
                TextBody(title: "Mo. contribution", content: "$100")
                
                TextBody(title: "Interest rate, %", content: "6")
                
                TextBody(title: "Lenght", content: "12 mo.")
                    
            }
            .padding(UIScreen.unit(20))
            .background(
                RoundedRectangle(cornerRadius: radius)
                    .fill(Color.Neumorphic.main)
                    .softOuterShadow()
            )
            .padding(UIScreen.unit(20))
        }
    }
}

struct BodyCalculatorWorking_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.Neumorphic.main.ignoresSafeArea()
            
            BodyCalculatorWorking()
                
        }
        .colorScheme(.dark)
        
        
        ZStack {
            Color.Neumorphic.main.ignoresSafeArea()
            
            BodyCalculatorWorking()
                
        }
        .colorScheme(.light)
    }
}
