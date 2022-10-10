//
//  CalculationViewModel.swift
//  CalculatorX
//
//  Created by HauNguyen on 10/10/2565 BE.
//

import Foundation
import SwiftUI

enum WorkingOn: String, Codable {
    case leftSide = "left"
    case rightSide = "right"
}

enum Operation: String, Codable {
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
    
    @Published var leftSide: String = ""
    
    @Published var rightSide: String = ""
    
    @Published var operation: Operation? = nil
    
    @Published var operationBefore: Operation? = nil
        
    @Published var GT: String = ""
    
    @Published var resultValue: Double = 0
    
    @Published var workingOn: WorkingOn = .leftSide
    
    
    func setValue(_ string: String) {
        if self.isMatchOperation(string) {
            self.operationWorkingOn(string)
        } else {
            // Number
            self.numberWorking(string)
        }
    }
    
    func numberWorking(_ number: String) {
        if self.workingOn == .leftSide {
            self.leftSide += number
        } else {
            self.rightSide += number
        }
        self.currentWorking.append(number)
    }
    
    func operationWorkingOn(_ string: String) {
        let type = Operation(rawValue: string)
        
        if !self.currentWorking.isEmpty {
            let valueAtIndex = String(self.currentWorking.last!)
            let getLeft = self.leftSide.doubleValue()
            let getRight = self.rightSide.doubleValue()
            
            switch type {
            case .percent:
                // Code
                if self.isMatchOperation(valueAtIndex) {
                    let newString = String(self.currentWorking.dropLast())
                    self.currentWorking = newString
                } else {
                    if !getLeft.isZero && !getRight.isZero {
                        self.rightSide = "\(getRight / 100)"
                    }
                    if !getLeft.isZero && getRight.isZero {
                        self.leftSide = "\(getLeft / 100)"
                    }
                }
                break;
            case .addOrSubtract:
                // Code
                break;
            case .dot:
                // Code
                break;
            default:
                if self.isMatchOperation(valueAtIndex) {
                    // Update
                    var newString = String(self.currentWorking.dropLast())
                    newString.append(string)
                    self.currentWorking = newString
                } else {
                    self.currentWorking.append(string)
                }
                if !getLeft.isZero && !getRight.isZero {
                    self.operationBefore = self.operation
                    self.leftSide = self.numberFormated(self.makeCalculation(getLeft, getRight, self.operation))
                    self.rightSide = ""
                    self.workingOn = .rightSide
                } else {
                    self.workingOn = .rightSide
                }
                break;
            }
            
            self.operation = type
        }
    }
    
    func percentWorkingOn() {
        if self.workingOn == .leftSide {
            
        } else {
            
        }
    }
    
    
    func makeCalculation(_ left: Double, _ right: Double,_ operation: Operation?) -> Double {
        var result: Double = 0
        
        switch operation {
        case .add:
            result = left + right
            break;
        case .subtract:
            result = left - right
            break;
        case .multiply:
            result = left * right
            break;
        case .divide:
            result = left / right
            break;
        default:
            break;
        }
        
        return result
    }
    
    
    func backRemove() {
        
    }
    
    func equalButton() {
        self.resultValue = self.makeCalculation(self.leftSide.doubleValue(), self.rightSide.doubleValue(), self.operation)
        self.currentWorking = String(format: "%.2f", self.resultValue)
    }
    
    func isMatchOperation(_ string: String) -> Bool {
        let character: Character = Character(string)
        
        if character == "+" || character == "-" || character == "*" || character == "/" || character == "." || character == "%" {
            return true
        } else if string == "+/-" {
            return true
        } else {
            return false
        }
    }
    
    func resetAll() {
        self.resultValue = 0
        self.operation = nil
        self.leftSide = ""
        self.rightSide = ""
        self.workingOn = .leftSide
        self.currentWorking = ""
        self.GT = ""
    }
    
    func numberFormated(_ value: Double) -> String {
        return String(value)
    }
}

