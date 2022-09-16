//
//  TextBody.swift
//  CalculatorX
//
//  Created by Hau Nguyen on 14/09/2022.
//

import SwiftUI

struct TextBody: View {
    init(title: String = "", content: String = "") {
        self.title = title
        self.content = content
    }
    var title: String = ""
    var content: String = ""
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack {
            Text(title)
                .font(.custom("AltoneTrial-Regular", size: 24))
                .foregroundColor(colorScheme == .dark ? Color.GrayLight : Color.GrayDark)
                
            Spacer()
            
            Text(content)
                .font(.custom("Gajkley", size: 24))
                .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
        }
    }
}

struct TextBody_Previews: PreviewProvider {
    static var previews: some View {
        TextBody()
    }
}
