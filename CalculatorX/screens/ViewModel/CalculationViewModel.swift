//
//  CalculationViewModel.swift
//  CalculatorX
//
//  Created by HauNguyen on 10/10/2565 BE.
//

import Foundation
import SwiftUI

enum Operation: String, Codable {
    case none = "?"
    case add = "+"
    case subtract = "-"
    case multiply = "*"
    case divide = "/"
    case percent = "%"
    case addOrSubtract = "+/-"
    case dot = "."
}

class CalculationViewModel: ObservableObject {
    
    init() {
        self.resetAll()
    }
    
    @Published var currentWorking: String = ""
    
    @Published var currentWorkingShow: String = ""
    
    @Published var lastNumber: String = ""
    
    @Published var percent: String = ""
    
    @Published var GT: String = ""
    
    @Published var resultValue: Double = 0
    
    @Published var resultValueTemp: Double = 0
    
    func setValue(_ string: String) {
        self.isValidationInputForm(string)
    }
    
    func isValidationInputForm(_ string: String) {
        // Limit 1.000.000 => 1.000.000.000.000.000 (15 số 0) giống calculator trên iphone
        if let operation = Operation(rawValue: string) {
            switch operation {
            case .none:
                break;
            case .percent:
                self.percentWorking(operation.rawValue)
                break;
            case .addOrSubtract:
                self.addOrSubtractWorking(operation.rawValue)
                break;
            case .dot:
                self.dotSliderWorking(operation.rawValue)
                break;
            default:
                self.operatorValidation(operation.rawValue)
                break;
            }
        } else {
            // Number working..
            // Must be get input number
            self.numberValidation(string)
        }
    }
    
    
    func operatorValidation(_ operation: String) {
        let string = self.currentWorking
        // Checking is not empty value..
        if !string.isEmpty {
            // Check last character
            let lastChar = string.last != nil ? String(string.last!) : ""
            
            if !lastChar.isEmpty {
                if self.isMatchOperationCalulator(lastChar) {
                    // Update new value at index end value of string
                    // Drop last
                    var newString = String(string.dropLast())
                    // Add new a operator
                    newString.append(operation)
                    self.assignWorking(newString)
                } else {
                    if !lastChar.contains(".") {
                        self.appendWorking(operation)
                    } else {
                        let endValue = string[self.valueFromEnd(string)]
                        if !endValue.contains(".") {
                            var newString = String(string.dropLast())
                            newString.append(operation)
                            self.assignWorking(newString)
                        }
                    }
                }
            }
        } else {
            if !self.isMatchOperation(operation) {
                self.appendWorking(operation)
            }
        }
    }
    
    
    func numberValidation(_ number: String) {
        let bumberFormatted = number.numberFormatted()
        // Must be get number
        let string = self.currentWorking
        // Before checking..
        // Checking is not empty value..
        if !string.isEmpty {
            // Check last character
            let lastChar = string.last != nil ? String(string.last!) : ""
            
            if !lastChar.isEmpty {
                if self.isMatchOperation(lastChar.description) {
                    let valueEnd = string[self.valueFromEnd(string)]
                    
                    if valueEnd.contains(".") {
                        var newString = String(string.dropLast())
                        newString.append(number)
                        // Append constaint number..
                        self.assignWorking(newString)
                    } else {
                        self.appendWorking(number)
                    }
                    
                } else {
                    // Check limit number
                    let count = string[self.valueFromEnd(string)].count
                    
                    if count >= 16 {
                        // Push error message -> Limit number
                        //UIScreen.showAlert(title: "Cảnh báo", msg: "Giá trị đã đạt đến số giới hạn 1 triệu tỉ số và không thể nhập thêm được nữa", button: "OK")
                    } else {
                        self.appendWorking(number)
                    }
                }
            }
        } else {
            // Before adding a number, we have to check if the first element is zero
            self.appendWorking(number)
        }
    }
    
    
    func percentWorking(_ operation: String) {
        
//        var string = self.currentWorking
//        let range = self.valueFromEnd(string)
//        let valueOfRange = string[range]
//        let resultValue = self.numberFormated(Double(String(valueOfRange).doubleValue() / 100))
//        string.removeSubrange(range)
//        print(resultValue)
//        self.currentWorking = resultValue
    }
    
    
    func addOrSubtractWorking(_ string: String) {
        print("+/-")
    }
    
    
    func dotSliderWorking(_ operation: String) {
//        let string = self.currentWorking
//        if !string.isEmpty {
//            let endValue = string[self.valueFromEnd(string)]
//
//            // Check first character
//            let lastChar = string.last != nil ? String(string.last!) : ""
//
//            if !lastChar.isEmpty {
//                if self.isMatchOperationCalulator(lastChar.description) {
//                    // Update new value at index end value of string
//                    // Drop last
//                    var newString = String(string.dropLast())
//                    // Add new a operator
//                    newString.append(operation)
//                    self.assignWorking(newString)
//                } else {
//                    // Check string number if not exist "."
//                    let endValue = string[self.valueFromEnd(string)]
//
//                    if !endValue.contains(",") {
//                        self.appendWorking(operation)
//                    }
//                }
//            }
//        }
    }
    
    func backRemove() {
        self.removeLastWorking()
    }
    
    
    func equalButton() {
//        let string = self.currentWorking
//        if !string.isEmpty {
//            if let last = string.last {
//                if !self.isMatchOperationCalulator(last.description) {
//                    // Make calculation
//                    self.makeCalculation(string)
//                } else {
//                    // Drop last
//                    let newString = String(string.dropLast())
//                    // Make calculation
//                    self.makeCalculation(newString)
//                }
//            }
//        }
    }
    
    func makeCalculation(_ string: String) {
        // Before use it
        // We must have to validate
        if let calculate = string.calculate() {
            self.resultValue = calculate
            self.assignWorking(String(calculate))
        } else {
            UIScreen.showAlert(title: "Lỗi", msg: "Không thể thực hiện phép tính này", button: "OK")
        }
    }
    
    func resetAll() {
        self.resultValue = 0
        self.resultValueTemp = 0
        self.deleteWorking()
        self.GT = ""
    }
    
    func isMatchOperation(_ string: String) -> Bool {
        return self.isMatchOperationCalulator(string) || self.isMatchOperationException(string)
    }
    
    func isMatchOperationCalulator(_ string: String) -> Bool {
        return string == "+" || string == "-" || string == "*" || string == "/"
    }
    
    func isMatchOperationException(_ string: String) -> Bool {
        if string == "%" || string == "," {
            return true
        } else if string == "+/-" {
            return true
        } else {
            return false
        }
    }
    
    func valueFromEnd(_ string: String) -> Range<String.Index> {
        var array = [String.Index]()
        for i in string.indices {
            let char = string[i]
            if self.isMatchOperationCalulator(String(char)) {
                //let index = string.distance(from: string.startIndex, to: i)
                array.append(i)
            }
        }
        if let maxIndex = array.max() {
            let range = string.index(after: maxIndex)..<string.endIndex
            return range
        }
        return string.startIndex..<string.endIndex
    }
    
    
    func numberFormated(_ value: Double) -> String {
        return String(value)
    }
    
    func appendWorking(_ string: String) {
        self.currentWorking.append(string)
        self.currentWorkingShow.append(string)
    }
    
    func assignWorking(_ newString: String) {
        self.currentWorking = newString
        self.currentWorkingShow = newString
    }
    
    func deleteWorking() {
        self.currentWorking = ""
        self.currentWorkingShow = ""
    }
    
    func removeLastWorking() {
        if !self.currentWorking.isEmpty && !self.currentWorkingShow.isEmpty {
            self.currentWorking.removeLast()
            self.currentWorkingShow.removeLast()
        }
    }
}

