//
//  CurrencyViewModel.swift
//  CalculatorX
//
//  Created by HauNguyen on 06/10/2565 BE.
//

import Foundation
import SwiftUI

class CurrentRateViewModel: ObservableObject {
    
    public init() {
        self.loadData()
    }
        
    @Published public var currentDateUpdate: Date = Date.now
        
    @Published public var currencies: [Currency] = [Currency]()
    
    @Published public var leftCurrency: Currency?
    
    @Published public var rightCurrency: Currency?
    
    public func clearAll() {
        leftCurrency = nil
        rightCurrency = nil
        currencies.removeAll()
        resultExchange = nil
    }
    
    public func clear() {
        resultExchange = nil
    }
    
    public var displayDescription: String {
        let convertString = NSDecimalNumber(decimal: resultExchange ?? .zero).stringValue
        let spellout = convertString.spellOut() + " \(self.currencyNameRight)"
        
        return displayTotalResultExchange + "\n" + spellout
    }
    
    public var displayTotalResultExchange: String {
        let convertDecimal = (resultExchange ?? .zero).formatted(.number)
        return convertDecimal + " \(self.currencyCodeRight)"
    }
    
    public var resultExchange: Decimal?
    
    public func evaluateResultExchange(_ number: Decimal) {
        let unit = currencyRateLeft / currencyRateRight
        if unit.isNormal {
            let total = number * Decimal(unit)
            resultExchange = total
        } else {
            resultExchange = .zero
        }
    }
    
    public var displayCurrentRateSelected: String {
        
        var result: String = ""
        
        let exchange = currencyRateRight / currencyRateLeft
        
        if exchange.isNormal {
            let exchangeFormat = Decimal(exchange).formatted(.number)
            result = "Tỉ giá: \(exchangeFormat) \(currencyCodeLeft) = 1 \(currencyCodeRight)"
        } else {
            result = "Tỉ giá: "
        }
        
        return result
    }
        
    public var currencyNameLeft: String {
        return leftCurrency?.currencyName ?? " --- "
    }
    
    public var currencyNameRight: String {
        return rightCurrency?.currencyName ?? " --- "
    }
    
    public var currencyCodeLeft: String {
        return leftCurrency?.currencyCode ?? " --- "
    }
    
    public var currencyCodeRight: String {
        return rightCurrency?.currencyCode ?? " --- "
    }
    
    public var currencyRateLeft: Double {
        return leftCurrency?.currencyRate ?? 0
    }
    
    public var currencyRateRight: Double {
        return rightCurrency?.currencyRate ?? 0
    }
    
    public func loadData() {
        let adapter = ExchangeRateAdaptor(onSucceed: dataDidSuccess)
        adapter.getCurrencies()
    }
    
    private func dataDidSuccess(data: AnyObject, statusCode: Int, type: AnyObject) {
        let uType = type as? BaseAdaptorType
        do {
            switch uType {
            case .GetList:
                do {
                    let result = try MTUtils.getJSONDecoder().decode([Currency].self, from: data as! Data)
                    self.currencies = result
                    
                    if !currencies.isEmpty && leftCurrency == nil {
                        leftCurrency = currencies[0]
                    }
                    
                    if !currencies.isEmpty && rightCurrency == nil {
                        rightCurrency = currencies[1]
                    }
                }
                catch let jsonError {
                    print("Erorr Customer > GetObject at: >>> \(jsonError.localizedDescription)")
                }
                break

            default:
                break
            }
        }
    }
}
