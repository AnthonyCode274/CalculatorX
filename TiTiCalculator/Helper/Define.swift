//
//  Define.swift
//  CalculatorX
//
//  Created by HauNguyen on 05/10/2565 BE.
//

import Foundation
import SwiftUI

public enum EHttpMethod : String, Codable
{
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
}

public enum ArithmeticOperation: CaseIterable, CustomStringConvertible {
    case addition, subtraction, multiplication, division
    
    public var description: String {
        switch self {
        case .addition:
            return "icon_add"
        case .subtraction:
            return "icon_subtract"
        case .multiplication:
            return "icon_multiplication"
        case .division:
            return "icon_divide"
        }
    }
}


public enum Digit: Int, CaseIterable, CustomStringConvertible {
    case zero, one, two, three, four, five, six, seven, eight, nine
    
    public var description: String {
        "\(rawValue)"
    }
}

public enum StateOn: String {
    case gt = "gt"
    case equal = "="
    case operation = "operation"
}

public enum ButtonType: Hashable, CustomStringConvertible {
    case threeZero
    case digit(_ digit: Digit)
    case operation(_ operation: ArithmeticOperation)
    case negative
    case percent
    case decimal
    case equals
    case allClear
    case clear
    
    public var description: String {
        switch self {
        case .threeZero:
            return "000"
        case .digit(let digit):
            return digit.description
        case .operation(let operation):
            return operation.description
        case .negative:
            return "icon_negative"
        case .percent:
            return "icon_percent"
        case .decimal:
            return "."
        case .equals:
            return "icon_equal"
        case .allClear:
            return "icon_allclear"
        case .clear:
            return "icon_clear"
        }
    }
    
    public var backgroundColor: Color {
        switch self {
        case .allClear, .clear, .negative, .percent, .operation, .equals:
            return .OgranLight
        case .digit, .decimal, .threeZero:
            return .Neumorphic.main
        }
    }
    
    public var foregroundColor: Color {
        switch self {
        case .allClear, .clear, .negative, .percent, .operation, .equals:
            return .white
        default:
            return .primary
        }
    }
}
