//
//  CurrencyViewModel.swift
//  CalculatorX
//
//  Created by HauNguyen on 06/10/2565 BE.
//

import Foundation
import SwiftUI

public class CurrencyViewModel: ObservableObject {
    
    init() {
        self.loadCurrencies()
    }
    
    @Published var currency: Currency?
    @Published var currencies = [Currency]()
    @Published var currentDateUpdate: Date = Date.now
    
    func loadCurrencies() {
        let adator = ExchangeRateAdaptor(onSucceed: dataDidSucceed)
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
                        
                        if self.currency == nil {
                            self.currency = self.currencies[0]
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
    
}
