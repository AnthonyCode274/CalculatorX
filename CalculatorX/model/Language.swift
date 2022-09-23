//
//  Language.swift
//  CalculatorX
//
//  Created by Hau Nguyen on 20/09/2022.
//

import Foundation

struct Language : Codable, Identifiable {
    enum CodingKeys: String, CodingKey {
        case key = "mr"
        case country = "Marathi"
    }
    var id = UUID()
    var country: String
    var key: String
}
