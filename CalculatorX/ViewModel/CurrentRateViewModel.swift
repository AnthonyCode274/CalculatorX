//
//  CurrencyViewModel.swift
//  CalculatorX
//
//  Created by HauNguyen on 06/10/2565 BE.
//

import Foundation
import SwiftUI

public class CurrentRateViewModel: ObservableObject {
    
    @Published public var requestError: RequestApiError?
    
    @Published public var currentDateUpdate: Date = Date.now
        
    @Published public var currencies: [Currency] = [Currency]()
    
    @Published public var leftCurrency: Currency?
    
    @Published public var rightCurrency: Currency?
    
    public func clearAll() {
        if !currencies.isEmpty {
            leftCurrency = currencies[0]
            rightCurrency = currencies[1]
        }
        clear()
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
        let convertString = NSDecimalNumber(decimal: resultExchange ?? .zero).stringValue
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
        let adapter = ExchangeRateAdaptor(onSucceed: dataDidSuccess, dataDidFailed: dataDidFailed)
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
                    
                    if !self.currencies.isEmpty && self.leftCurrency == nil {
                        self.leftCurrency = self.currencies[0]
                    }
                    
                    if !self.currencies.isEmpty && self.rightCurrency == nil {
                        self.rightCurrency = self.currencies[1]
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
    
    private func dataDidFailed(requestError: RequestApiError, message: String?) {
        DispatchQueue.main.async {
            self.requestError = requestError
        }
    }
}
