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
    case comma = ","
}

enum CalculationError: Error {
    case invalidString
    case invalidCalculator
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
        // Limit 1.000.000 => 1.000.000.000.000.000 (16 số) giống calculator trên iphone
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
            case .comma:
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
        if !self.currentWorking.isEmpty {
            // Check last character
            let lastChar = self.currentWorking.last != nil ? String(self.currentWorking.last!) : ""
            
            if !lastChar.isEmpty {
                if self.isMatchOperationCalulator(lastChar) {
                    // Update new value at index end value of string
                    // Drop last
                    var newString = String(self.currentWorking.dropLast())
                    // Add new a operator
                    newString.append(operation)
                    self.assignWorking(newString)
                }
                else if self.isMatchNumber(lastChar) {
                    self.appendWorking(operation)
                }
                else if self.isMatchOperationException(lastChar) {
                    var newString = String(self.currentWorking.dropLast())
                    // Add new a operator
                    newString.append(operation)
                    self.assignWorking(newString)
                }
                else {
                    self.appendWorking(operation)
                }
            }
        }
    }
    
    
    func numberValidation(_ number: String) {
        // Must be get number
        if !self.currentWorking.isEmpty {
            // Check last character
            let valueEnd = self.valueOfEnd(self.currentWorking)
            let lastChar = self.currentWorking.last != nil ? String(self.currentWorking.last!) : ""
            
            if !lastChar.isEmpty {
                if self.isMatchOperationCalulator(lastChar) {
                    // Append constaint number..
                    self.appendWorking(number)
                }
                else if self.isMatchOperationException(lastChar) {
                    print("numberValidation: \(self.currentWorking)")
                    
                    self.appendWorking(number)
                }
                else if self.isMatchNumber(number) {
                    if self.isLimitNumber(valueEnd) {
                        // Push error message -> Limit number
                        //UIScreen.showAlert(title: "Cảnh báo", msg: "Giá trị đã đạt đến số giới hạn 1 triệu tỉ số và không thể nhập thêm được nữa", button: "OK")
                        print("isLimitNumber")
                    } else {
                        // Check last number is zero
                        if valueEnd != "0" {
                            self.appendWorking(number)
                        } else {
                            print("valueEnd == 0")
                            // Drop last end replace new value
                            var newString = String(self.currentWorking.dropLast())
                            newString.append(number)
                            self.assignWorking(newString)
                        }
                    }
                } else {
                    print("numberValidation error")
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
        let valueEnd = self.valueOfEnd(self.currentWorking)
        // Nếu phần tử cuối là dấu chấm -> Giữ nguyên dấu chấm và nhân giá trị trước dấu chấm cho -1 (vd: 2*8-5. -> (+/-) -> 2*8+5.)
        
        print("\(valueEnd)")
        
//        if !valueEnd.isEmpty {
//            if valueEnd.doubleValue() > 0 {
//
//            } else {
//
//            }
//        }
        
    }
    
    
    func dotSliderWorking(_ operation: String) {
        if !self.currentWorking.isEmpty {
            let valueEnd = self.valueOfEnd(self.currentWorking)

            // Check first character
            let lastChar = self.currentWorking.last != nil ? String(self.currentWorking.last!) : ""

            if !lastChar.isEmpty {
                if self.isMatchOperationCalulator(lastChar) {
                    // Thêm số "0." đằng trước
                    print("isMatchOperationCalulator")
                    self.appendWorking("0.")
                }
                else if self.isMatchOperationException(lastChar) {
                    print("isMatchOperationException")
                }
                else if self.isMatchNumber(operation) {
                    let valueEnd = self.valueOfEnd(self.currentWorking)
                    if self.isLimitNumber(valueEnd) {
                        // Push error message -> Limit number
                        //UIScreen.showAlert(title: "Cảnh báo", msg: "Giá trị đã đạt đến số giới hạn 1 triệu tỉ số và không thể nhập thêm được nữa", button: "OK")
                        print("isLimitNumber: true")
                    } else {
                        print("isLimitNumber: false")
                    }
                } else {
                    // Check "." in valueOfEnd
                    if !valueEnd.contains(Operation.dot.rawValue) {
                        self.appendWorking(operation)
                    }
                }
            }
        }
    }
    
    func backRemove() {
        self.removeLastWorking()
    }
    
    
    func equalButton() {
        if !self.currentWorking.isEmpty {
            let lastChar = self.currentWorking.last != nil ? String(self.currentWorking.last!) : ""
            if !lastChar.isEmpty {
                if self.isMatchOperationCalulator(lastChar) {
                    // Drop last
                    let newString = String(self.currentWorking.dropLast())
                    // Make calculation
                    self.makeCalculation(newString)
                    
                } else {
                    // Make calculation
                    self.makeCalculation(self.currentWorking)
                }
            }
        }
    }
    
    func makeCalculation(_ string: String) {
        // Before use it
        // We must have to validate
        if let calculate = string.calculate() {
            self.resultValue = calculate
            self.assignWorking(self.numberFormated(calculate))
        } else {
            UIScreen.showAlert(title: "Lỗi", msg: "Không thể thực hiện phép tính này!", button: "OK")
            print("Error calculating.")
        }
    }
    
    func resetAll() {
        self.resultValue = 0
        self.resultValueTemp = 0
        self.deleteWorking()
        self.GT = ""
    }
    
    func isLimitNumber(_ string: String) -> Bool {
        var arr: String = ""
        for i in string.indices {
            if String(string[i]) != Operation.comma.rawValue {
                arr.append(string[i])
            }
        }
        return arr.count >= 16
    }
    
    func isMatchOperation(_ string: String) -> Bool {
        return self.isMatchOperationCalulator(string) || self.isMatchOperationException(string)
    }
    
    func isMatchOperationCalulator(_ string: String) -> Bool {
        return string == Operation.add.rawValue || string == Operation.subtract.rawValue || string == Operation.multiply.rawValue || string == Operation.divide.rawValue
    }
    
    func isMatchOperationException(_ string: String) -> Bool {
        if string == Operation.percent.rawValue || string == Operation.comma.rawValue || string == Operation.dot.rawValue {
            return true
        } else if string == Operation.addOrSubtract.rawValue {
            return true
        } else {
            return false
        }
    }
    
    func isMatchNumber(_ string: String) -> Bool {
        let targetNumber: String = "0123456789"
        return targetNumber.contains(string) || string.contains("000")
    }
    
    func valueOfEnd(_ string: String) -> String {
        let range = self.rangeOfEnd(string)
        return String(string[range])
    }
    
    func rangeOfEnd(_ string: String) -> Range<String.Index> {
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

