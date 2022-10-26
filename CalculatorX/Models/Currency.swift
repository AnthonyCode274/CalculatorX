//
//  Currency.swift
//  CalculatorX
//
//  Created by HauNguyen on 05/10/2565 BE.
//

import Foundation

public struct Currency: Identifiable, Codable, Hashable {
    public init(currencyId: Int64 = 0, currencyStatus: Int16 = 0, currencyCode: String = "", currencyName: String = "", currencyRate: Double = 0, isMainCurrency: Bool = false, createdDate: String = "", createdBy: Int64? = 0, updatedDate: String = "", updatedBy: Int64? = 0) {
        self.currencyId = currencyId
        self.currencyStatus = currencyStatus
        self.currencyCode = currencyCode
        self.currencyName = currencyName
        self.currencyRate = currencyRate
        self.isMainCurrency = isMainCurrency
        self.createdDate = createdDate
        self.createdBy = createdBy
        self.updatedDate = updatedDate
        self.updatedBy = updatedBy
    }
    
    public var id : Int64 {
        return self.currencyId
    }
    public var currencyId: Int64 = 0
    public var currencyStatus: Int16 = 0
    public var currencyCode: String = ""
    public var currencyName: String = ""
    public var currencyRate: Double = 0
    public var isMainCurrency: Bool = false
    public var createdDate: String = ""
    public var createdBy: Int64? = 0
    public var updatedDate: String = ""
    public var updatedBy: Int64? = 0
}
