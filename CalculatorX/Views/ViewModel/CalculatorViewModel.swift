//
//  CalculatorViewModel.swift
//  CalculatorX
//
//  Created by HauNguyen on 19/10/2565 BE.
//

import Foundation
import Combine

class CalculatorViewModel: ObservableObject {
    
    // MARK: - PROPERTIES
    
    @Published private var calculator = Calculator()
    
    var getNumber: Decimal {
        return calculator.number ?? .zero
    }
    
    var stateOn: StateOn? {
        return calculator.stateOn
    }
        
    var displayText: String {
        return calculator.displayText.numberFormatted()
    }
    
    public var alertSpellOut: String {
        return displayText + "\n" + spellOutNumber
    }
    
    var spellOutNumber: String {
        return calculator.displayText.spellOut()
    }
    
    var getAllResult: [Decimal] {
        return calculator.allResult
    }
    
    var buttonTypes: [[ButtonType]] {
        let clearType: ButtonType = calculator.showAllClear ? .allClear : .clear
        return [
            [clearType, .negative, .percent, .operation(.division)],
            [.digit(.seven), .digit(.eight), .digit(.nine), .operation(.multiplication)],
            [.digit(.four), .digit(.five), .digit(.six), .operation(.subtraction)],
            [.digit(.one), .digit(.two), .digit(.three), .operation(.addition)],
            [.threeZero, .digit(.zero), .decimal, .equals]
        ]
    }
    
    // MARK: - ACTIONS
    
    func performAction(for buttonType: ButtonType) {
        switch buttonType {
        case .threeZero:
            calculator.setThreeZero()
            calculator.stateOn = .digit
        case .digit(let digit):
            calculator.setDigit(digit)
            calculator.stateOn = .digit
        case .operation(let operation):
            calculator.setOperation(operation)
            calculator.stateOn = .operation
        case .negative:
            calculator.toggleSign()
        case .percent:
            calculator.setPercent()
        case .decimal:
            calculator.setDecimal()
        case .equals:
            calculator.evaluate()
            calculator.stateOn = .equal
        case .allClear:
            calculator.allClear()
        case .clear:
            calculator.clear()
        }
    }
    
    func gtAction() {
        self.calculator.gt()
    }
    
    func backRemove() {
        self.calculator.chervonBackRemove()
    }
    
    // MARK: - HELPERS
    
    /// Checks if current buttonType of type .arithmeticOperation is active
    func buttonTypeIsHighlighted(buttonType: ButtonType) -> Bool {
        guard case .operation(let operation) = buttonType else { return false}
        return calculator.operationIsHighlighted(operation)
    }
}
