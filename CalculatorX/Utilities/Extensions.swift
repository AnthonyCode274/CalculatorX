//
//  Extensions.swift
//  CalculatorX
//
//  Created by Hau Nguyen on 04/09/2022.
//
import SwiftUI

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

extension Bundle {
    static func appName() -> String {
        guard let dictionary = Bundle.main.infoDictionary else {
            return ""
        }
        if let version : String = dictionary["CFBundleName"] as? String {
            return version
        } else {
            return ""
        }
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
    
    static var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    static var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    static func getUnit(_ number: CGFloat) -> CGFloat {
        return (number * UIScreen.screenWidth) / 360
    }
    
    static func getPer(_ percent: CGFloat) -> CGFloat {
        return UIScreen.screenWidth * percent
    }
    
    static func showAlert(title:String, msg:String, button:String) {
        NavigationUtil.top()?.showAlert(title: title, msg: msg, button:button)
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
}

extension String {
    func parseURL() -> URL {
        return URL(string: self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) ?? URL(string:String(Config.noImage).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
    }
    
    func capitalizeFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    func spellOut() -> String {
        let number = (self as NSString).doubleValue
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        formatter.maximumFractionDigits = 3
        formatter.locale = Locale(identifier: "vi_VN")
        let numberAsWord = String(formatter.string(from: NSNumber(value: number)) ?? "").capitalizeFirstLetter()
          
        var newString = numberAsWord.replacingOccurrences(of: "nghìn", with: "nghìn,").replacingOccurrences(of: "tỷ", with: "tỷ,").replacingOccurrences(of: "triệu", with: "triệu,").replacingOccurrences(of: "phẩy", with: "phẩy,")
        
        if let last = newString.last {
            if last == "," {
                newString.removeLast()
            }
        }
        
        return newString
    }
    
    func numberFormatted() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale.current
        formatter.usesGroupingSeparator = true
        formatter.decimalSeparator = ","
        formatter.groupingSeparator = "."
        formatter.maximumFractionDigits = 3
        
        var formatted: String? = nil
        
        if let index = self.firstIndex(of: ".") {
            let numString = self.replacingOccurrences(of: ".", with: ",")
            let rangeValueBefore = numString[numString.startIndex..<index]
            let rangeValueBAfter = numString[index..<numString.endIndex]
            
            let valFormatted = formatter.string(from: NSNumber(value: String(rangeValueBefore).doubleValue))
            let new = valFormatted?.appending(rangeValueBAfter)
            return new ?? ""
            
        } else {
            formatted = formatter.string(from: NSNumber(value: self.doubleValue))
        }
        
        if let valueFormatted = formatted {
            return valueFormatted
        } else {
            return self
        }
    }
    
    var isMatchOperation: Bool {
        return self.contains("+") || self.contains("-") || self.contains("*") || self.contains("/")
    }
    
    var doubleValue: Double {
        return (self as NSString).doubleValue
    }
}

extension Character {
    var isMatchOperation: Bool {
        return self == "+" || self == "-" || self == "*" || self == "/"
    }
}


extension Decimal {
    var stringValue: String {
        return NSDecimalNumber(decimal: self).stringValue
    }
}

extension Text {
    public func foregroundLinearGradient(colors: [Color], startPoint: UnitPoint, endPoint: UnitPoint) -> some View {
        self.overlay {
            LinearGradient(
                colors: colors,
                startPoint: startPoint,
                endPoint: endPoint
            )
            .mask(self)
        }
    }
}
