//
//  CurrencyViewModel.swift
//  CalculatorX
//
//  Created by HauNguyen on 06/10/2565 BE.
//

import Foundation
import SwiftUI

class CurrencyViewModel: ObservableObject {
    
    init() {
        self.loadCurrencies()
    }
    
    @Published var fromCurrency: Currency = Currency()
    
    @Published var toCurrency: Currency = Currency()
    
    @Published var currencies: [Currency] = [Currency]()
    
    @Published var currentDateUpdate: Date = Date.now
    
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    func loadCurrencies() {
        let adator = ExchangeRateAdaptor(onSucceed: self.dataDidSucceed)
        adator.getCurrencies()
    }
    
    func dataDidSucceed(data: AnyObject, statusCode: Int, type: AnyObject) {
        DispatchQueue.main.async {
            let uType = type as? BaseAdaptorType
            do {
                switch uType {
                case .GetList:
                    do {
                        let results = try MTUtils.getJSONDecoder().decode([Currency].self, from: data as! Data)
                        self.currencies = results
                        self.currentDateUpdate = Date.now
                        
                        self.fromCurrency = self.currencies[0]
                        self.toCurrency = self.currencies[1]
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
}
