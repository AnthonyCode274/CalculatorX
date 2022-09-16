//
//  Extensions.swift
//  CalculatorX
//
//  Created by Hau Nguyen on 04/09/2022.
//

import Foundation
import UIKit
import SwiftUI


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
    
    public static func unit(_ number: CGFloat) -> CGFloat {
        return (number * UIScreen.width) / 360
    }
}

extension Color {
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
        return Color(UIColor(red: 255/255, green: 140/255, blue: 0/255, alpha: 1.0))
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
}


extension AnyView{
    static func + (left: AnyView, right: AnyView) -> AnyView{
        return AnyView(HStack{left.fixedSize(horizontal: true, vertical: false)
            right.fixedSize(horizontal: true, vertical: false)})
    }
}
