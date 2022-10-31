//
//  TextDictionary.swift
//  CalculatorX
//
//  Created by HauNguyen on 18/10/2565 BE.
//

import Foundation

public class TextDictionary: Codable {
    
    public static var subTitleInfo: String = "By Maytech & The Code-Love Team"
    public static func serviceDescription(iconName: String) -> String {
        return "Copyright \(iconName) " + "2022 Maytect".uppercased()
    }
    public static var Description = "Chi tiết"
    public static var OK = "OK"
    public static var SpaceDivider = " --- "
    public static var ExchangeRate = "Chuyển đổi tỉ giá"
    public static var ListOfExchangeRates = "Danh sách tỉ giá"
    public static var LastResult = "Kết quả trước"
    public static var CalculatorErrorMessage = "Không thể thực hiện được phép tính này"
    
}
