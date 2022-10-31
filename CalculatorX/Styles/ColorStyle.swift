//
//  ColorStyle.swift
//  CalculatorX
//
//  Created by HauNguyen on 17/10/2565 BE.
//

import SwiftUI

public extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

public extension Color {
    
    static var GrayLight: Color {
        return Color(UIColor(red: 160/255, green: 160/255, blue: 160/255, alpha: 1.0))
    }
    
    static var GrayDark: Color {
        return Color(UIColor(red: 49/255, green: 49/255, blue: 49/255, alpha: 1.0))
    }
    
    static var YellowLight: Color {
        return Color(hex: "#E99E39")
    }
    
    static var OgranLight: Color {
        return Color(hex: "#FF8C00")
    }
    
    static var OgranDark: Color {
        return Color(hex: "#9A5500")
    }
    
    static var OviLight: Color {
        return Color(hex: "#00C8FF") // old: 38F3FF
    }
    
    static var LinearGradientBackgroundInfo: LinearGradient {
        return LinearGradient(gradient: Gradient(colors: [Color(hex: "#2A94CF"), Color(hex: "#7EE297")]), startPoint: .leading, endPoint: .trailing)
    }
}
