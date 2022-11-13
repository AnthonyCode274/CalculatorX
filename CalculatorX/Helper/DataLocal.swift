//
//  DataLocal.swift
//  CalculatorX
//
//  Created by HauNguyen on 31/10/2565 BE.
//

import Foundation

public class DataLocal {    
    public init() {
        
    }
    
    public static func getCurrencies(filename fileName: String) -> [Currency] {
        do {
            if let jsonData = DataLocal.readLocalFile(filename: fileName) {
                let currencies = try JSONDecoder().decode([Currency].self, from: jsonData)
                return currencies
            } else {
                return [Currency]()
            }
        } catch {
            print("error: \(error)")
        }
        return [Currency]()
    }
     
    static func readLocalFile(filename fileName: String) -> Data? {
        guard let file = Bundle.main.path(forResource: fileName, ofType: "json") else {
            fatalError("Unable to locate file \"\(fileName)\" in main bundle.")
        }
        do {
            let data = try String(contentsOfFile: file).data(using: .utf8)
            return data
        } catch{
            debugPrint(error)
        }
        return nil
    }
}
