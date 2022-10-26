//
//  Config.swift
//  CalculatorX
//
//  Created by HauNguyen on 05/10/2565 BE.
//

import Foundation

public class Config {
    static let apiUrl = "https://calcapi.maytech.app/api/"
    
    static var getApiUrl: String {
        get {
            return self.apiUrl
        }
    }
    
    static func getRequestAPI(url:String, method: EHttpMethod) -> URLRequest {
        var urlRequest = URLRequest(url: URL(string: url)!)
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("IOS", forHTTPHeaderField: "Device")
        urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        return urlRequest
    }
}
