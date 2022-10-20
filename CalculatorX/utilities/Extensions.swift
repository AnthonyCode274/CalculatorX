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

extension Operation {
    
    func operatorToWord() -> String {
        var print: String = ""

        if self == .add {
            print = "cộng"
        }
        if self == .subtract {
            print = "trừ"
        }
        if self == .multiply {
            print = "nhân"
        }
        if self == .divide {
            print = "chia"
        }
        return print
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

extension String {
    
    func endNumbers() -> Substring {
        let range = self.rangeOfEnd()
        return self[range]
    }
    
    func rangeOfEnd() -> Range<String.Index> {
        var array = [String.Index]()
        for i in self.indices {
            if self[i].isMatchOperator {
                array.append(i)
            }
        }
        if let maxIndex = array.max() {
            let range = self.index(after: maxIndex)..<self.endIndex
            return range
        } else {
            return self.startIndex..<self.endIndex
        }
    }
    
    // hello, (Nice to- meet 한국 école %&$you all. 123 ! Давай العربية 😀 => hello Nice to meet 한국 école $you all 123  Давай العربية 😀
    var withoutPunctuations: String {
        return self.components(separatedBy: CharacterSet.punctuationCharacters).joined(separator: "")
    }
    
    func numberFormatted() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale.current
        formatter.maximumFractionDigits = 3
        formatter.usesGroupingSeparator = true
        formatter.decimalSeparator = ","
        formatter.groupingSeparator = "."
        
        let number = NSNumber(value: self.doubleValue())
        
        if let valueFormatted = formatter.string(from: number) {
            return valueFormatted
        } else {
            return self
        }
    }
    
    var isLimitNumber: Bool {
        if let indexFind = self.firstIndex(of: ".") {
            // Remove at index
            var getString = self
            getString.remove(at: indexFind)
            return getString.count >= 16
        } else {
            return self.count >= 16
        }
    }
    
    func equal(_ string: String) -> Bool {
        return self == string
    }
    
    var isMatchOperator: Bool {
        for i in self {
            if i == "+" || i == "-" || i == "*" || i == "/" {
                return true
            }
        }
        return false
    }
    
    var isMatchOperatorException: Bool {
        return self == "." || self == "+/-" || self == "%" || self == ","
    }
    
    func isMatchNumber() -> Bool {
        let targetNumber: String = "0123456789"
        return targetNumber.contains(self) || self.contains("000")
    }
    
    var isNumber: Bool {
        return self.range(
            of: "^[0-9]*$", // 1
            options: .regularExpression) != nil
    }
    
    func specialFormatted() -> String {
        var string = self
        
        return string
    }
    
    func subString(startIndex: String.Index, endIndex: String.Index) -> String {
        return String(self[startIndex...endIndex])
    }

    func subString(_ from: Int, _ to: Int) -> String {
          let startIndex = self.index(self.startIndex, offsetBy: from)
          let endIndex = self.index(self.startIndex, offsetBy: to)
        return String(self[startIndex...endIndex])
    }
        
    func spellOut() -> String {
        let number = (self as NSString).doubleValue
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        formatter.maximumFractionDigits = 3
        formatter.locale = Locale(identifier: "vi_VN")
        var numberAsWord = String(formatter.string(from: NSNumber(value: number)) ?? "").capitalizeFirstLetter()
        
        let newString = numberAsWord.replacingOccurrences(of: "nghìn", with: "nghìn,").replacingOccurrences(of: "tỷ", with: "tỷ,").replacingOccurrences(of: "triệu", with: "triệu,").replacingOccurrences(of: " phẩy", with: ",")
        numberAsWord = newString
        
        return numberAsWord
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
    
    func toString(decimal: Int = 9) -> String {
        let value = decimal < 0 ? 0 : decimal
        var string = String(format: "%.\(value)f", self)
        
        while string.last == "0" || string.last == "." {
            if string.last == "." { string = String(string.dropLast()); break}
            string = String(string.dropLast())
        }
        return string
    }
    
    func allNumsToDouble() -> String {
        
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
    
    func calculate() -> Double? {
        let transformedString = self.allNumsToDouble()
        let expr = NSExpression(format: transformedString)
        if let value = expr.expressionValue(with: nil, context: nil) as? NSNumber {
            return value.doubleValue
        } else {
            return 0
        }
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

public extension String.Element {
    func toString() -> String {
        return String(self)
    }
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


extension Character {
    var isMatchOperator: Bool {
        return self == "+" || self == "-" || self == "*" || self == "/"
    }
    
    func equal(_ character: Character) -> Bool {
        return self == character
    }
    
    func equal(_ string: String) -> Bool {
        return String(self) == string
    }
}
