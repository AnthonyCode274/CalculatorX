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
    case multiply = "x"
    case divide = "/"
    case equals = "="
}

class CalculatorViewModel: ObservableObject {
    
    // Lưu trữ giá trị hiện tại
    @Published var currentWorking: String = ""
    // Vế trái
    @Published var leftSide: Double = 0
    // Vế phải
    @Published var rightSide: Double = 0
    // Phép tính
    @Published var operation: Operation?
    // Kết quả phép tính
    @Published var resultValue: Double = 0
    // Vế phải
    @Published var workingOn: WorkingOn = .leftSide
    
    
    func appendNumber(_ number: String) {
        
    }
    
}
