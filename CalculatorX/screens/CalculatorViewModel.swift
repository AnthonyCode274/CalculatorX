//
//  CalculatorViewModel.swift
//  CalculatorX
//
//  Created by Hau Nguyen on 15/09/2022.
//

import Foundation
import SwiftUI

enum WorkingOn {
    case leftSide
    case rightSide
}

enum Operation: String {
    case add = "+"
    case subtract = "-"
    case multiply = "*"
    case divide = "/"
    case equals = "="
    case addOrSubtract = "+/-"
    case dot = "."
}

class CalculatorViewModel: ObservableObject {
    
    init() {
        self.clearAll()
    }
    
    @Published var currentWorking: String = ""
        
    @Published var workingMiniShow: String = ""
    
    @Published var leftSide: String = ""
    
    @Published var rightSide: String = ""
    
    @Published var operation: Operation?
    
    @Published var AT: String = ""
    
    @Published var resultValue: Double = 0
    
    @Published var oldResult: Double = 0
    
    @Published var workingOn: WorkingOn = .leftSide
    
    
    func setValue(_ number: String) {
        switch number {
        case Operation.add.rawValue:
            self.operationWorkingOn(.add)
            break;
        case Operation.subtract.rawValue:
            self.operationWorkingOn(.subtract)
            break;
        case Operation.multiply.rawValue:
            self.operationWorkingOn(.multiply)
            break;
        case Operation.divide.rawValue:
            self.operationWorkingOn(.divide)
            break;
        case Operation.dot.rawValue:
            self.operationWorkingOn(.dot)
            break;
        case Operation.addOrSubtract.rawValue:
            self.operationWorkingOn(.addOrSubtract)
            break;
        default:
            self.numberWorkingOn(number)
            break;
        }
        
    }
    
    func numberWorkingOn(_ number: String) {
        if self.resultValue.isZero {
            if self.workingOn == .leftSide {
                self.leftSide += number
            } else {
                self.rightSide += number
            }
        } else {
            if self.workingOn == .leftSide {
                self.leftSide += number
            } else {
                self.rightSide += number
            }
        }
        
        self.checkWorkingToShow()
    }
    
    func operationWorkingOn(_ operation: Operation) {
        
        if self.resultValue.isZero {
            self.operation = operation
            
            if self.leftSide.isEmpty {
                self.workingOn = .leftSide
            } else {
                self.workingOn = .rightSide
            }
            
            self.checkWorkingToShow()
        } else {
            self.leftSide = "\(self.resultValue)"
            self.workingOn = .rightSide
            self.rightSide = ""
        }
        
    }
    
    func checkWorkingToShow() {
        if self.resultValue.isZero {
            if !self.leftSide.isEmpty && !self.rightSide.isEmpty {
                self.currentWorking = "\(self.leftSide)\(self.operation?.rawValue ?? "")\(self.rightSide)"
            }
            if !self.leftSide.isEmpty && self.rightSide.isEmpty {
                if self.operation != nil {
                    self.currentWorking = "\(self.leftSide)\(self.operation?.rawValue ?? "")"
                } else {
                    self.currentWorking = "\(self.leftSide)"
                }
            }
        } else {
            self.currentWorking = "\(self.resultValue)"
        }
    }
    
    
    func backButtonClear() {
        
    }
    
    func equalResult() {
        self.makeCalculation(self.leftSide, self.rightSide)
    }
    
    func makeCalculation(_ left: String, _ right: String) {
        let getLeft = left.doubleValue()
        let getRight = right.doubleValue()
        var tempValue: Double = 0
        
        switch self.operation {
        case .add:
            tempValue = getLeft + getRight
            break;
        case .subtract:
            tempValue = getLeft - getRight
            break;
        case .multiply:
            tempValue = getLeft * getRight
            break;
        case .divide:
            tempValue = getLeft / getRight
            break;
        case .dot:
            break;
        case .addOrSubtract:
            break;
        default:
            break;
        }
        
        if self.resultValue.isZero {
            self.workingMiniShow = self.currentWorking
        } else {
            self.workingMiniShow = "\(self.resultValue)\(self.operation?.rawValue ?? "")\(self.rightSide)"
        }
        
        self.resultValue = tempValue
        self.currentWorking = "\(self.resultValue)"
        
        print("Result value: \(self.resultValue)")
        print("Current working: \(self.currentWorking)")
        print("Left \(self.leftSide)")
        print("Right \(self.rightSide)")
        print("Working on \(self.workingOn)")
        print("Operation \(self.operation?.rawValue ?? "")")
        print("Mini Show: \(self.workingMiniShow)")
        print("\n")
    }
        
    func resetWorkingForm() {
        self.leftSide = ""
        self.rightSide = ""
        self.workingOn = .leftSide
    }
    
    func clearAll() {
        self.workingOn = .leftSide
        self.resultValue = 0
        self.operation = nil
        self.leftSide = ""
        self.rightSide = ""
        self.currentWorking = ""
        self.workingMiniShow = ""
    }
}
