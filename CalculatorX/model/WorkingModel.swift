//
//  WorkingModel.swift
//  CalculatorX
//
//  Created by HauNguyen on 10/10/2565 BE.
//

import Foundation

struct WorkingModel : Codable {
    var id: UUID { return UUID() }
    var value: String
    var type: WorkingType
}
