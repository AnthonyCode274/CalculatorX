//
//  ViewModel.swift
//  CalculatorX
//
//  Created by Hau Nguyen on 04/09/2022.
//

import Foundation
import SwiftUI

class ViewModel: ObservableObject {
    // Calculation..
    @Published var workings: String = ""
    
    @Published var displayWorking: String = ""
    @Published var displayResult: String = ""
    @Published var isDisplayAlert: Bool = false
    @Published var alert: Alert = Alert(title: Text(""))
    
    init() {
        clearAll()
    }
    
    func clearAll() {
        workings = ""
        displayResult = ""
        displayWorking = ""
    }
    
    func equalsTap() {
        if validInput() {
            let checkedWorkingsForPercent = workings.replacingOccurrences(of: "%", with: "*0.01")
            let expression = NSExpression(format: checkedWorkingsForPercent)
            let result = expression.expressionValue(with: nil, context: nil) as! Double
            let resultString = formatResult(result: result)
            displayResult = resultString
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
        
        if !workings.isEmpty {
            for char in workings
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
                
                if(index == workings.count - 1)
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
        if !workings.isEmpty {
            workings.removeLast()
            displayWorking = workings
        }
    }
    
    func addTap(value: String) {
        workings = workings + value
        displayWorking = workings
    }
    
    func percentTap() {
        addTap(value: "%")
    }
    
    func devideTap() {
        addTap(value: "/")
    }
    
    func timesTap() {
        addTap(value: "*")
    }
    
    func minusTap() {
        addTap(value: "-")
    }
    
    func plusTap() {
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
