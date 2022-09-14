//
//  MTUtils.swift
//  CalculatorX
//
//  Created by Hau Nguyen on 08/09/2022.
//

import Foundation

public class MTUtils {
    
    public static func spellOutToWord(numString: String) -> String {
        let doubleValue = (numString as NSString).doubleValue
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        formatter.locale = Locale(identifier: "vi_VN")
        let toWord = formatter.string(for: doubleValue)
        return String(toWord ?? "")
    }
    
}
