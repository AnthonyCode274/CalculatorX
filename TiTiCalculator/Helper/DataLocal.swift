//
//  DataLocal.swift
//  CalculatorX
//
//  Created by HauNguyen on 31/10/2565 BE.
//

import Foundation

public class DataLocal {
    public static var shared: DataLocal = DataLocal()
    
    public init() {
        
    }
    
    public func getCurrencies(filename fileName: String) -> [Currency] {
        do {
            if let jsonData = self.readLocalFile(filename: fileName) {
                let decodedData = try JSONDecoder().decode([Currency].self, from: jsonData)
                return decodedData
            } else {
                return [Currency]()
            }
        } catch {
            print("error: \(error)")
        }
        return [Currency]()
    }
     
    private func readLocalFile(filename fileName: String) -> Data? {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else{ return nil }
        debugPrint(path)
        let url = URL(fileURLWithPath: path)
        debugPrint(url)
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch{
            debugPrint(error)
        }
        return nil
    }
}
