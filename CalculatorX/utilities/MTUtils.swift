//
//  MTUtils.swift
//  CalculatorX
//
//  Created by HauNguyen on 05/10/2565 BE.
//

import Foundation

public class MTUtils {
    public static func getJSONDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.defaultFormat())
        return decoder
    }
    
    public static func getJSONEncoder() -> JSONEncoder {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(DateFormatter.defaultFormat())
        encoder.outputFormatting = .withoutEscapingSlashes
        return encoder
    }
}
