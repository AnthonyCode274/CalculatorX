//
//  FuncitonMoreText.swift
//  CalculatorX
//
//  Created by Hau Nguyen on 21/09/2022.
//

import SwiftUI

struct FuncitonMoreText: View {
    init(label: String, contentString: String) {
        self.label = label
        self.contentString = contentString
    }
    
    let label: String
    let contentString: String
    
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        VStack(alignment: .center, spacing: UIScreen.getUnit(5)) {
            Text(label)
                .font(.custom("", size: 16))
                .fontWeight(.bold)
                .foregroundColor(self.systemColor)
            
            Text(contentString)
                .font(.custom("", size: 20))
                .fontWeight(.bold)
                .foregroundColor(self.systemColor)
        }
    }
    
    var systemColor: Color {
        return self.colorScheme == .dark ? Color.white : Color.black
    }
}

struct FuncitonMoreText_Previews: PreviewProvider {
    static var previews: some View {
        FuncitonMoreText(label: "Gold price", contentString: "1,663.8")
    }
}
