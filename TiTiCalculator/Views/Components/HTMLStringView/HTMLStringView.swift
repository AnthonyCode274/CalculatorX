//
//  HTMLStringView.swift
//  MaytechFramework
//
//  Created by Phuong Duong on 6/21/21.
//

import WebKit
import SwiftUI

public struct HTMLStringView: View {
    @Binding var htmlContent: String
    @State private var dynamicHeight: CGFloat = 0
    
    public init(htmlContent: Binding<String>) {
        self._htmlContent = htmlContent
    }
    
    public var body: some View {
        HTMLStringReader(htmlContent: $htmlContent, dynamicHeight: $dynamicHeight)
            .frame(height: self.dynamicHeight, alignment: .top)
    }
}
