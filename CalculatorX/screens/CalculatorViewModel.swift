//
//  CalculatorViewModel.swift
//  CalculatorX
//
//  Created by Hau Nguyen on 15/09/2022.
//

import Foundation
import SwiftUI

enum Special: String, Codable {
    case plus = "+"
    case minus = "-"
    case times = "*"
    case devide = "/"
}

class CalculatorViewModel: ObservableObject {
    
    init() {
        self.isResetOn = true
        self.resetAll()
    }
    
    @Published var numberWorking: String = ""
    @Published var displayWorking: String = ""
    @Published var displayResult: String = ""
    @Published var statusWorking: String = "Final working"
    @Published var limitNumber: String = ""

    @Published var isResetOn: Bool = false
    @Published var textSize: CGFloat = UIScreen.unit(38)
    @Published var alert: Alert?
    @Published var isDisplayAlert: Bool = false
    @Published var specialSelection: Special? = nil
    
    func resetAll() {
        self.statusWorking = ""
        self.numberWorking = ""
        self.displayResult = ""
        self.displayWorking = ""
        self.limitNumber = ""
        self.textSize = UIScreen.unit(38)
        self.specialSelection = nil
    }
    
    func equalsTap() {
        if self.validInput() {
            let checkedWorkingsForPercent = self.numberWorking.replacingOccurrences(of: "%", with: "*0.01")
            let expression = NSExpression(format: checkedWorkingsForPercent)
            let result = expression.expressionValue(with: nil, context: nil) as! Double
            let resultString = self.formatResult(result: result)
            self.displayResult = resultString
        } else {
            self.alert = Alert(
                title: Text("Invalid Input"),
                message: Text("Calculator unable to do math based on input"),
                dismissButton: .default(Text("Okay"))
            )
            self.isDisplayAlert.toggle()
        }
        
    }
    
    func validInput() ->Bool
    {
        var count = 0
        var funcCharIndexes = [Int]()
        
        if !numberWorking.isEmpty {
            for char in numberWorking
            {
                if(specialCharacter(char: char))
                {
                    funcCharIndexes.append(count)
                }
                count += 1
            }
            
            
            var previous: Int = -1
            
            for index in funcCharIndexes
            {
                if(index == 0)
                {
                    return false
                }
                
                if(index == numberWorking.count - 1)
                {
                    return false
                }
                
                if (previous != -1)
                {
                    if(index - previous == 1)
                    {
                        return false
                    }
                }
                previous = index
            }
            
            return true

        } else {
            return false
        }
        
        
    }
    
    func specialCharacter(char: Character) -> Bool {
        if char == "*" {
            return true
        }
        if char == "/" {
            return true
        }
        if char == "+" {
            return true
        }
        return false
    }
    
    func formatResult(result: Double) -> String {
        if result.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", result)
        } else {
            return String(format: "%.2f", result)
        }
    }
    
    func backTap() {
        if !numberWorking.isEmpty {
            numberWorking.removeLast()
            displayWorking = numberWorking
        }
    }
    
    func addTap(value: String) {
        self.specialSelection = nil
        numberWorking = numberWorking + value
        displayWorking = numberWorking
    }
    
    func percentTap() {
        addTap(value: "%")
    }
    
    func devideTap() {
        self.specialSelection = .devide
        addTap(value: "/")
    }
    
    func timesTap() {
        self.specialSelection = .times
        addTap(value: "*")
    }
    
    func minusTap() {
        self.specialSelection = .minus
        addTap(value: "-")
    }
    
    func plusTap() {
        self.specialSelection = .plus
        addTap(value: "+")
    }
    
    func decimalTap() {
        addTap(value: ".")
    }
    
    func zeroTap() {
        addTap(value: "0")
    }
    
    func oneTap() {
        addTap(value: "1")
    }
    
    func twoTap() {
        addTap(value: "2")
    }
    
    func threeTap() {
        addTap(value: "3")
    }
    
    func fourTap() {
        addTap(value: "4")
    }
    
    func fiveTap() {
        addTap(value: "5")
    }
    
    func sixTap() {
        addTap(value: "6")
    }
    
    func sevenTap() {
        addTap(value: "7")
    }
    
    func eightTap() {
        addTap(value: "8")
    }
    
    func nineTap() {
        addTap(value: "9")
    }
}
