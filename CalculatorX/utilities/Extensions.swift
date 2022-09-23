//
//  Extensions.swift
//  CalculatorX
//
//  Created by Hau Nguyen on 04/09/2022.
//

import Foundation
import UIKit
import SwiftUI


extension Double {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
    
    func truncate(places: Int) -> Double {
        return Double(floor(pow(10.0, Double(places)) * self) / pow(10.0, Double(places)))
    }
}

extension UIScreen {
    public static var edges: UIEdgeInsets? {
        let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
        
        return keyWindow?.safeAreaInsets
    }
    
    public static var width: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    public static var height: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    public static func getUnit(_ number: CGFloat) -> CGFloat {
        return (number * UIScreen.width) / 360
    }
}

extension Color {
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
    
    public static var GrayLight: Color {
        return Color(UIColor(red: 160/255, green: 160/255, blue: 160/255, alpha: 1.0))
    }
    
    public static var GrayDark: Color {
        return Color(UIColor(red: 49/255, green: 49/255, blue: 49/255, alpha: 1.0))
    }
    
    public static var YellowLight: Color {
        return Color(UIColor(red: 233/255, green: 158/255, blue: 57/255, alpha: 1.0))
    }
    
    public static var OgranLight: Color {
        return Color(hex: "#FF8C00")
    }
    
    public static var OgranDark: Color {
        return Color(hex: "#9A5500")
    }
}

extension String {
    var numberFotmat: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.decimalSeparator = ","
        formatter.groupingSeparator = "."
        
        let doubleValue = (self as NSString).doubleValue
        
        print("doubleValue: \(doubleValue)")
        
        let number = NSNumber(value: doubleValue)
        let formattedValue = formatter.string(from: number)!
        return String(formattedValue)
    }
    
    func spellOut() -> String {
        let number = (self as NSString).intValue
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        formatter.locale = Locale(identifier: "vi_VN")
        let numberAsWord = formatter.string(from: NSNumber(value: number))
        return String(numberAsWord ?? "")
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    func convertFromDoubleToCleanString() -> String? {
        
        if self.last == "." {
            return self
        }
        
        if let double = Double(self) {
            return double.truncate(places: 4).clean
        } else {
            return nil
        }
    }
}


extension AnyView{
    static func + (left: AnyView, right: AnyView) -> AnyView{
        return AnyView(HStack{left.fixedSize(horizontal: true, vertical: false)
            right.fixedSize(horizontal: true, vertical: false)})
    }
}
