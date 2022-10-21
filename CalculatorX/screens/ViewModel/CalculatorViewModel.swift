//
//  CalculatorViewModel.swift
//  CalculatorX
//
//  Created by HauNguyen on 19/10/2565 BE.
//

import SwiftUI
import MathExpression

enum Operation: String, Codable {
    case add = "+"
    case subtract = "-"
    case multiply = "*"
    case divide = "/"
    case percent = "%"
    case addOrSubtract = "+/-"
    case dot = "."
    case comma = ","
}

struct SpellOut: Codable {
    init(spellNumber: String = "", substring: String = "", stateOn: StateOn = .currency) {
        self.spellNumber = spellNumber
        self.substring = substring
        self.stateOn = stateOn
    }
    
    enum StateOn: String, Codable {
        case working
        case currency
    }
    
    var spellNumber: String = ""
    var substring: String = ""
    var stateOn: StateOn = .currency
    
    var isEmpty: Bool {
        return self.spellNumber.isEmpty
    }
}

class CalculatorViewModel: CurrencyViewModel {
    
    override init() {
        super.init()
        self.resetAll()
    }
    
    @Published var workings: String = ""
    
    @Published var resultWorking: String = ""
    
    @Published var operation: Operation? = nil
    
    @Published var spellout: SpellOut = SpellOut()
    
    
    func setValue(_ string: String) {
        if string.isNumber {
            if self.spellout.stateOn == .working {
                self.spellout.substring.removeAll()
            }
            self.checkNumberValid(string)
        } else {
            //self.spellout.substring.removeAll()
            self.checkOperationValid(string)
        }
    }
    
    
    func checkOperationValid(_ stringOperator: String) {
        if self.workings.isEmpty {
            print("Is empty")
            if stringOperator.equal(".") {
                self.addWorking("0.")
            }
            return
        } else {
            // Check last char
            if let lastChar = self.workings.last {
                let operation = Operation(rawValue: stringOperator)

                if !lastChar.isNumber {
                    
                    switch operation {
                    case .percent:
                        print("%")
                        break;
                    case .addOrSubtract:
                        self.addOrSubtract(stringOperator)
                        break;
                    case .dot:
                        self.dotOperatorAction(stringOperator)
                        break;
                    case .comma:
                        print(",.")
                        break;
                    default:
                        // + - * /
                        // Replace current char
                        self.removeLastWorking()
                        self.addWorking(stringOperator)
                        break;
                    }
                } else {
                    switch operation {
                    case .percent:
                        print("%")
                        break;
                    case .addOrSubtract:
                        self.addOrSubtract(stringOperator)
                        break;
                    case .dot:
                        self.dotOperatorAction(stringOperator)
                        break;
                    case .comma:
                        print(",.")
                        break;
                    default:
                        // + - * /
                        // Replace current char
                        self.addWorking(stringOperator)
                        break;
                    }
                }
                
            } else {
                return
            }
        }
    }
    
    func addOrSubtract(_ stringOperator: String) {
        // Lấy chuỗi numbers ở cuối và kiểm tra.
        let lastNumbers = String(self.workings.endNumbers())
        let rangeOfEnd = self.workings.rangeOfEnd()
        if self.workings.isMatchOperator {
            if !lastNumbers.isEmpty {
                let beforeNumbers = lastNumbers.index(before: rangeOfEnd.lowerBound)
                let type = Operation(rawValue: String(self.workings[beforeNumbers]))
                
                switch type {
                case .add:
                    self.workings.replaceSubrange(beforeNumbers..<rangeOfEnd.upperBound, with: "-\(lastNumbers)")
                    break;
                case .subtract:
                    self.workings.replaceSubrange(beforeNumbers..<rangeOfEnd.upperBound, with: "+\(lastNumbers)")
                    break;
                case .multiply:
                    self.workings.replaceSubrange(beforeNumbers..<rangeOfEnd.upperBound, with: "*(-\(lastNumbers))")
                    break;
                case .divide:
                    self.workings.replaceSubrange(beforeNumbers..<rangeOfEnd.upperBound, with: "/(-\(lastNumbers))")
                    break;
                default:
                    break;
                }
            } else {
                print("Empty")
            }
        } else {
            self.workings.replaceSubrange(rangeOfEnd.lowerBound..<rangeOfEnd.upperBound, with: "-\(lastNumbers)")
        }
    }
    
    func dotOperatorAction(_ stringOperator: String) {
        if self.workings.isEmpty {
            self.addWorking("0.")
            return
        } else {
            if let lastChar = self.workings.last {
                if lastChar.isNumber {
                    let lastNumbers = String(self.workings.endNumbers())
                    // Check limit "."
                    if let _ = lastNumbers.firstIndex(of: ".") {
                        print("Existed")
                        return
                    } else {
                        self.addWorking(stringOperator)
                        return
                    }
                } else {
                    print("Operator checking")
                    self.removeLastWorking()
                    self.addWorking(stringOperator)
                    return
                }
            } else {
                print("Operator checking")
                return
            }
        }
    }
    
    func checkNumberValid(_ stringNumber: String) {
        if self.workings.isEmpty {
            if !stringNumber.equal("000") && !stringNumber.equal("0") {
                self.addWorking(stringNumber)
                return
            } else {
                self.addWorking("0")
                return
            }
            
        } else {
            let numberOfEnd = String(self.workings.endNumbers())
            if numberOfEnd.isLimitNumber {
                print("Number has limited")
                return
            } else {
                let lastNumbers = String(self.workings.endNumbers())
                
                if let _ = lastNumbers.firstIndex(of: ".") {
                    // Thoải mái
                    print("Founded dot slider")
                    self.addWorking(stringNumber)
                    return
                } else {
                    print("Dot slider not found")
                    // Kiểm tra phần tử phía trước có phải == 0 ?. Có 2 trường hợp
                    if let first = lastNumbers.first {
                        print("Can not find first char")
                        if first.equal("0") || first.equal("000") {
                            if stringNumber.equal("0") || stringNumber.equal("000") {
                                return
                            } else {
                                self.removeFirstWorking()
                                self.addWorking(stringNumber)
                                return
                            }
                        } else {
                            self.addWorking(stringNumber)
                            return
                        }
                    } else {
                        self.addWorking(stringNumber)
                        return
                    }
                    // Nếu phần tử đầu tiên của chuỗi == 0
                }
            }
        }
    }
    
    func removeButton() {
        self.removeLastWorking()
        if !self.spellout.isEmpty && self.spellout.stateOn == .working {
            self.spellout.spellNumber.removeLast()
        }
    }
    
    // GT Button
    func totalCalculation() {
        
    }
    
    func resetExchangeCurreny() {
        self.fromCurrency = Currency()
        self.toCurrency = Currency()
        self.currencies = [Currency]()
        self.currentDateUpdate = .now
    }
    
    func equalButton() {
        var calculateResult: Double = 0
        
        if !self.workings.isEmpty {
            if let lastChar = self.workings.last {
                if lastChar.isMatchOperator {
                    // Drop last
                    let newString = String(self.workings.dropLast())
                    // Make calculation
                    calculateResult = self.makeCalculation(newString)
                    
                } else {
                    // Make calculation
                    calculateResult = self.makeCalculation(self.workings)
                }
            }
        }
        let convertString = String(calculateResult)
        self.resultWorking = convertString
        self.workings = convertString
        self.spellout.spellNumber = convertString
        self.spellout.substring.removeAll()
        self.spellout.stateOn = .working
        self.operation = nil
    }
    
    func makeCalculation(_ string: String) -> Double {
        // Before use it
        // We must have to validate
        do {
            let expression = try MathExpression(string)
            let result = expression.evaluate()
            return result
        } catch let err {
            UIScreen.showAlert(title: "Lỗi", msg: TextDictionary.CalculatorErrorMessage, button: "ok".uppercased())
            print("Error: " + err.localizedDescription)
            return 0
        }
    }
    
    // AC button
    func resetAll() {
        self.deleteWorking()
        self.resultWorking = ""
        self.spellout.spellNumber.removeAll()
        self.spellout.substring.removeAll()
        self.spellout.stateOn = .working
    }
    
    func addWorking(_ value: String) {
        if !value.isNumber {
            self.operation = Operation(rawValue: value) ?? .none
        } else {
            self.operation = nil
        }
        
        if !self.workings.isEmpty {
            self.workings.append(value)
            let lastNumbers = String(self.workings.endNumbers())
            if self.spellout.stateOn == .working {
                self.spellout.spellNumber = lastNumbers
            }
        } else {
            self.workings.append(value)
            if self.spellout.stateOn == .working {
                self.spellout.spellNumber.append(value)
            }
        }
    }
    
    func updateWorking(_ newValue: String) {
        self.workings = newValue
    }
    
    func removeFirstWorking() {
        if !self.workings.isEmpty {
            self.workings.removeFirst()
        }
    }
    
    func removeLastWorking() {
        if !self.workings.isEmpty {
            self.workings.removeLast()
        }
    }
    
    func deleteWorking() {
        self.workings = ""
    }
}
