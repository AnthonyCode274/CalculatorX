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
        self.loadDataCurrency(self.dataSorted(self.currencies))
        self.clear()
    }
    
    public func clear() {
        self.resultExchange = nil
    }
    
    public var displayDescription: String {
        let convertString = NSDecimalNumber(decimal: self.resultExchange ?? .zero).stringValue
        let spellout = convertString.spellOut() + " \(self.currencyNameRight)"
        
        return self.displayTotalResultExchange + "\n" + spellout
    }
    
    public var displayTotalResultExchange: String {
        let convertDecimal = (self.resultExchange ?? .zero).formatted(.number)
        let convertString = NSDecimalNumber(decimal: self.resultExchange ?? .zero).stringValue
        return convertDecimal + " \(self.currencyCodeRight)"
    }
    
    public var resultExchange: Decimal?
    
    public func evaluateResultExchange(_ number: Decimal) {
        let unit = self.currencyRateLeft / self.currencyRateRight
        if unit.isNormal {
            let total = number * Decimal(unit)
            self.resultExchange = total
        } else {
            self.resultExchange = .zero
        }
    }
    
    public var displayCurrentRateSelected: String {
        
        var result: String = ""
        
        let exchange = self.currencyRateRight / self.currencyRateLeft
        
        if exchange.isNormal {
            let exchangeFormat = Decimal(exchange).formatted(.number)
            result = "Tỉ giá: \(exchangeFormat) \(self.currencyCodeLeft) = 1 \(self.currencyCodeRight)"
        } else {
            result = "Tỉ giá: "
        }
        
        return result
    }
        
    public var currencyNameLeft: String {
        return self.leftCurrency?.currencyName ?? " --- "
    }
    
    public var currencyNameRight: String {
        return self.rightCurrency?.currencyName ?? " --- "
    }
    
    public var currencyCodeLeft: String {
        return self.leftCurrency?.currencyCode ?? " --- "
    }
    
    public var currencyCodeRight: String {
        return self.rightCurrency?.currencyCode ?? " --- "
    }
    
    public var currencyRateLeft: Double {
        return self.leftCurrency?.currencyRate ?? 0
    }
    
    public var currencyRateRight: Double {
        return self.rightCurrency?.currencyRate ?? 0
    }
    
    public func loadData() {
        let adapter = ExchangeRateAdaptor(onSucceed: self.dataDidSuccess, dataDidFailed: self.dataDidFailed)
        adapter.getCurrencies()
    }
    
    private func dataDidSuccess(data: AnyObject, statusCode: Int, type: AnyObject) {
        DispatchQueue.main.async {
            let uType = type as? BaseAdaptorType
            do {
                switch uType {
                case .GetList:
                    do {
                        let result = try MTUtils.getJSONDecoder().decode([Currency].self, from: data as! Data)
                        let sorted = self.dataSorted(result)
                        self.currencies = sorted
                        self.loadDataCurrency(sorted)
                        
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
    
    private func dataDidFailed(requestError: RequestApiError, message: String?) {
        DispatchQueue.main.async {
            self.requestError = requestError
            let data = DataLocal.getCurrencies(filename: "CurrentRateOffline")
            let sorted = self.dataSorted(data)
            self.currencies = sorted
            self.loadDataCurrency(sorted)
        }
    }
    
    private func loadDataCurrency(_ data: [Currency]) {
        if !data.isEmpty && self.leftCurrency == nil && self.rightCurrency == nil {
            for item in data {
                if item.isMainCurrency {
                    self.leftCurrency = item
                } else {
                    self.rightCurrency = item
                }
            }
        }
    }
    
    private func dataSorted(_ data: [Currency]) -> [Currency] {
        return data.sorted(by: {$0.currencyId < $1.currencyId})
    }
}
