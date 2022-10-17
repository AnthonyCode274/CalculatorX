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

public extension UIScreen {
    static func setRotationDevice(to orientation: UIInterfaceOrientationMask) {
        AppDelegate.orientationLock = orientation
    }
    
    static var edges: UIEdgeInsets? {
        let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
        
        return keyWindow?.safeAreaInsets
    }
    
    static var width: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    static var height: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    static func getUnit(_ number: CGFloat) -> CGFloat {
        return (number * UIScreen.width) / 360
    }
    
    static func showAlert(title:String, msg:String, button:String) {
        NavigationUtil.top()?.showAlert(title: title, msg: msg, button:button)
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
}

public extension Color {
    
    static var GrayLight: Color {
        return Color(UIColor(red: 160/255, green: 160/255, blue: 160/255, alpha: 1.0))
    }
    
    static var GrayDark: Color {
        return Color(UIColor(red: 49/255, green: 49/255, blue: 49/255, alpha: 1.0))
    }
    
    static var YellowLight: Color {
        return Color(UIColor(red: 233/255, green: 158/255, blue: 57/255, alpha: 1.0))
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
}

extension String {
    func numberFormatter() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: "vi_VN")
        formatter.maximumFractionDigits = 2
        formatter.decimalSeparator = ","
        formatter.groupingSeparator = "."
        
        return formatter
    }
    
    func numberFormatted() -> String {
        let numberFormater = self.numberFormatter()
        
        let number = NSNumber(value: self.doubleValue())
        
        if let valueFormatted = numberFormater.string(from: number) {
            return valueFormatted
        } else {
            return self
        }
    }
    
    func spellOut() -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "vi_VN")
        formatter.numberStyle = .spellOut
        formatter.decimalSeparator = ","
        formatter.groupingSeparator = "."
        
        if let numberAsWord = formatter.string(from: NSNumber(value: self.doubleValue())) {
            return numberAsWord.capitalizeFirstLetter().replacingOccurrences(of: " phẩy", with: ",")
        } else {
            return self
        }
    }
    
    func capitalizeFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    func doubleValue() -> Double {
        let val = (self as NSString).doubleValue
        return val
    }
    
    func valueOf(index: String.Index) -> Character {
        return self[index]
    }
    
    func floatValue() -> Float {
        let val = (self as NSString).floatValue
        return val
    }
}

public extension StringProtocol {
    func distance(of element: Element) -> Int? { firstIndex(of: element)?.distance(in: self) }
    func distance<S: StringProtocol>(of string: S) -> Int? { range(of: string)?.lowerBound.distance(in: self) }
}

public extension Collection {
    func distance(to index: Index) -> Int { distance(from: startIndex, to: index) }
}

public extension String.Index {
    func distance<S: StringProtocol>(in string: S) -> Int { string.distance(to: self) }
}

public extension Encodable {
    func toData() -> Data {
        do {
            let jsonData = try JSONEncoder().encode(self)
            return jsonData
        }
        catch let jsonError {
            print("Erorr toJsonString at: >>> \(jsonError.localizedDescription)")
            return Data()
        }
    }
    
    func toDict() -> [String:Any] {
        var dict = [String:Any]()
        let otherSelf = Mirror(reflecting: self)
        for child in otherSelf.children {
            if let key = child.label {
                if let date = child.value as? Date {
                    dict[key] = date
                }else{
                    dict[key] = child.value
                }
            }
        }
        return dict
    }
    
    func toJsonString() -> String {
        do {
            let jsonData = try MTUtils.getJSONEncoder().encode(self)
            return String(data: jsonData, encoding: .utf8)!
        }
        catch let jsonError {
            print("Erorr toJsonString at: >>> \(jsonError.localizedDescription)")
            return ""
        }
    }
}


extension AnyView{
    static func + (left: AnyView, right: AnyView) -> AnyView{
        return AnyView(HStack{left.fixedSize(horizontal: true, vertical: false)
            right.fixedSize(horizontal: true, vertical: false)})
    }
}

public extension DateFormatter {
    static func defaultFormat() -> DateFormatter {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.calendar = Calendar(identifier: .iso8601)
        dateFormatterGet.locale = Locale(identifier: NSLocale.current.languageCode ?? "vi_VN")
        dateFormatterGet.timeZone = TimeZone.current
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatterGet
    }
}

public extension Date {
    
    static func getStamp() -> String {
        let dateFormatter = DateFormatter.defaultFormat()
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        return dateFormatter.string(from: Date())
    }
    
    static func formatToString(format: String) -> String {
        let dateFormatter = DateFormatter.defaultFormat()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self.now)
    }
    
    static func formatToString() -> String {
        let dateFormatter = DateFormatter.defaultFormat()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatter.string(from: self.now)
    }
    
    static var yesterday : Date {
        var dayComponent    = DateComponents()
        dayComponent.day    = -1 // For removing one day (yesterday): -1
        let theCalendar     = Calendar(identifier: .iso8601)
        return theCalendar.date(byAdding: dayComponent, to: Date())!
    }
}

extension String {
    func toString(decimal: Int = 9) -> String {
        let value = decimal < 0 ? 0 : decimal
        var string = String(format: "%.\(value)f", self)
        
        while string.last == "0" || string.last == "." {
            if string.last == "." { string = String(string.dropLast()); break}
            string = String(string.dropLast())
        }
        return string
    }
    
    func allNumsToDouble() throws -> String {
        
        let symbolsCharSet = ".,"
        let fullCharSet = "0123456789" + symbolsCharSet
        var i = 0
        var result = ""
        let chars = Array(self)
        while i < chars.count {
            if fullCharSet.contains(chars[i]) {
                var numString = String(chars[i])
                i += 1
            loop: while i < chars.count {
                if fullCharSet.contains(chars[i]) {
                    numString += String(chars[i])
                    i += 1
                } else {
                    break loop
                }
            }
                if let num = Double(numString) {
                    result += "\(num)"
                } else {
                    result += numString
                }
            } else {
                result += String(chars[i])
                i += 1
            }
        }
        return result
    }
    
    func calculate() throws -> Double? {
        let transformedString = try self.allNumsToDouble()
        let expr = NSExpression(format: transformedString)
        if let value = expr.expressionValue(with: nil, context: nil) as? NSNumber {
            return value.doubleValue
        }
        return 0
    }
}
