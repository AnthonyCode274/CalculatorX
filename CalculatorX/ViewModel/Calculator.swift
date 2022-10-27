//
//  Calculator.swift
//  CalculatorX
//
//  Created by HauNguyen on 25/10/2565 BE.
//

import Foundation

struct Calculator {
    private var expression: ArithmeticExpression?
    private var result: Decimal?
    private var carryingNegative: Bool = false
    private var carryingDecimal: Bool = false
    private var carryingZeroCount: Int = 0
    private var pressedClear: Bool = false
    public var allResult = [Decimal]()
    private var stateOn: StateOn? = nil
    
    private struct ArithmeticExpression: Equatable {
        var number: Decimal
        var operation: ArithmeticOperation
        
        func evaluate(with secondNumber: Decimal) -> Decimal {
            switch operation {
            case .addition:
                return number + secondNumber
            case .subtraction:
                return number - secondNumber
            case .multiplication:
                return !secondNumber.isZero ? (number * secondNumber) : .zero
            case .division:
                return !secondNumber.isZero ? (number / secondNumber) : .zero
            }
        }
    }
    
    // MARK: - PROPERTIES
    
    private var newNumber: Decimal? {
        didSet {
            guard newNumber != nil else { return }
            carryingNegative = false
            carryingDecimal = false
            carryingZeroCount = 0
            pressedClear = false
        }
    }
    
    // MARK: - COMPUTED PROPERTIES
    
    public var displayText: String {
        let string = getNumberString(forNumber: number, withCommas: true)
        
        return string
    }
    
    public var displayStateOn: String {
        return stateOn?.rawValue ?? ""
    }
    
    public var showAllClear: Bool {
        newNumber == nil && expression == nil && result == nil || pressedClear
    }
        
    public var number: Decimal? {
        if pressedClear || carryingDecimal {
            return newNumber
        }
        return newNumber ?? expression?.number ?? result
    }
    
    private var containsDecimal: Bool {
        let state = getNumberString(forNumber: number).contains(".")
        return state
    }
    
    // MARK: - OPERATIONS
    
    mutating func setDigit(_ digit: Digit) {
        stateOn = nil
        if containsDecimal && digit == .zero {
            if expression?.operation != nil && operationIsHighlighted(expression!.operation) {
                addNumber(digit)
            } else {
                carryingZeroCount += 1
            }
        } else if canAddDigit(digit) {
            if let number = number {
                if !number.isNormal {
                    addNumber(digit)
                } else {
                    if self.isLimitNumber(number) {
                        if expression?.operation != nil && operationIsHighlighted(expression!.operation) {
                            addNumber(digit)
                        }
                    } else {
                        addNumber(digit)
                    }
                }
            } else {
                addNumber(digit)
            }
        }
    }
    
    mutating func addNumber(_ digit: Digit) {
        let numberString = getNumberString(forNumber: newNumber)
        newNumber = Decimal(string: numberString.appending("\(digit.rawValue)"))
    }
    
    mutating func addNumber(_ number: String) {
        let numberString = getNumberString(forNumber: newNumber)
        newNumber = Decimal(string: numberString.appending("\(number)"))
    }
    
    mutating func setThreeZero() {
        stateOn = nil
        if containsDecimal {
            if let number = number {
                if !number.isNormal {
                    addNumber("000")
                } else {
                    if self.isLimitNumber(number) {
                        if expression?.operation != nil && operationIsHighlighted(expression!.operation) {
                            addNumber("000")
                        }
                    } else {
                        addNumber("000")
                    }
                }
            } else {
                addNumber("000")
            }
        } else if canAddDigit(.zero) {
            if let number = number {
                if !number.isNormal {
                    addNumber("000")
                } else {
                    if self.isLimitNumber(number) {
                        if expression?.operation != nil && operationIsHighlighted(expression!.operation) {
                            addNumber("000")
                        }
                    } else {
                        addNumber("000")
                    }
                }
            } else {
                addNumber("000")
            }
        }
    }
    
    mutating func setOperation(_ operation: ArithmeticOperation) {
        if expression?.operation != nil {
            evaluate()
            setProgressOperation(operation)
            expression?.operation = operation
        } else {
            setProgressOperation(operation)
        }
    }
    
    mutating func setProgressOperation(_ operation: ArithmeticOperation) {
        guard var number = newNumber ?? result else { return }
        if let existingExpression = expression {
            number = existingExpression.evaluate(with: number)
        }
        expression = ArithmeticExpression(number: number, operation: operation)
        newNumber = nil
    }
    
    mutating func toggleSign() {
        if let number = newNumber {
            newNumber = -number
            return
        }
        if let number = result {
            result = -number
            return
        }
        
        carryingNegative.toggle()
    }
    
    mutating func isLimitNumber(_ number: Decimal) -> Bool {
        if let _ = number.stringValue.firstIndex(of: ".") {
            return number.stringValue.count >= 17
        } else {
            return number.stringValue.count >= 16
        }
    }
    
    mutating func setPercent() {
        if let number = newNumber {
            newNumber = number / 100
            return
        }
        if let number = result {
            result = number / 100
            return
        }
    }
    
    mutating func setDecimal() {
        if containsDecimal { return }
        carryingDecimal = true
    }
    
    mutating func evaluate() {
        guard let number = newNumber else { return }
        
        allResult.append(number)
        
        guard let expressionToEvaluate = expression else { return }
        
        let e = expressionToEvaluate.evaluate(with: number)
        result = e
        expression = nil
        newNumber = nil
        
        if !allResult.isEmpty {
            guard let last = allResult.last else { return print("Can not to get last decimal") }
            
            if last != e {
                allResult.append(e)
            }
        } else {
            allResult.append(e)
        }
        stateOn = .equal
    }
    
    mutating func chervonBackRemove() {
        var stringNumber = (newNumber?.stringValue ?? "0")
        stringNumber.removeLast()
        newNumber = Decimal(string: stringNumber)
    }
    
    mutating func gt() {
        if !allResult.isEmpty {
            let sum = allResult.reduce(0, {$0 + $1})
            newNumber = sum
            expression = nil
            stateOn = .gt
            print("\(allResult.toJsonString()) - sum: \(sum)")
        }
    }
    
    mutating func allClear() {
        newNumber = nil
        expression = nil
        result = nil
        allResult.removeAll()
        carryingNegative = false
        carryingDecimal = false
        carryingZeroCount = 0
        stateOn = nil
    }
    
    mutating func clear() {
        newNumber = nil
        carryingNegative = false
        carryingDecimal = false
        carryingZeroCount = 0
        stateOn = nil
        pressedClear = true
    }
    
    // MARK: - HELPERS
    
    public func operationIsHighlighted(_ operation: ArithmeticOperation) -> Bool {
        return expression?.operation == operation && newNumber == nil
    }
    
    private func getNumberString(forNumber number: Decimal?, withCommas: Bool = false) -> String {
        var numberString = (withCommas ? (number?.stringValue) : number.map(String.init)) ?? "0"
        
        if carryingNegative {
            numberString.insert("-", at: numberString.startIndex)
        }
        
        if carryingDecimal {
            numberString.insert(".", at: numberString.endIndex)
        }
        
        if carryingZeroCount > 0 {
            numberString.append(String(repeating: "0", count: carryingZeroCount))
        }
        
        return numberString
    }
    
    private func canAddDigit(_ digit: Digit) -> Bool {
        return number != nil || digit != .zero
    }
}
