//
//  BaseAdaptor.swift
//  CalculatorX
//
//  Created by HauNguyen on 05/10/2565 BE.
//

import SwiftUI

enum BaseAdaptorType: Int8, Codable {
    case Create = 0
    case Update = 1
    case Delete = 2
    case GetList = 3
    case GetObject = 4
}

public class BaseAdaptor {
    
    public init(onSucceed: @escaping (AnyObject, Int, AnyObject) -> Void) {
        BaseAdaptor.onSucceed = onSucceed
    }
    
    static var onSucceed: ((_ data: AnyObject,_ statusCode: Int , _ type: AnyObject) -> Void)?
    
    static var dataDidFailed: ((_ statusCode: Int) -> Void)?
    
    static func callAPI(urlString: String, method: EHttpMethod, type: AnyObject, data:Data? = nil) {
        var apiUrlRequest = Config.getRequestAPI(url: urlString, method: method)
        
        if (data != nil) {
            apiUrlRequest.httpBody = data
        }
        URLSession.shared.dataTask(with: apiUrlRequest) {
            (data, response, error) in
            DispatchQueue.global(qos: .background).async {
                guard error == nil else {
                    DispatchQueue.main.async {
                        NavigationUtil.showAlert(title: "Lỗi", msg: "Có lỗi xảy ra. Vui lòng kiểm tra internet.", button: "OK")
                    }
                    print("\(urlString) >>>Error3: \(error.debugDescription)")
                    return
                }
                let response = response as! HTTPURLResponse
                if !(200...299).contains(response.statusCode) {
                    // handle HTTP server-side error
                    self.dataDidFailed?(response.statusCode)
                    print("\(urlString) >>>Error4.1: statusCode: \(response.statusCode)")
                    DispatchQueue.main.async {
                        NavigationUtil.showAlert(title: "Lỗi \(response.statusCode)", msg: "Có lỗi xảy ra. Vui lòng kiểm tra internet hoặc liên hệ quản trị viên.", button: "OK")
                    }
                    return
                }
                guard let responseData = data else {
                    DispatchQueue.main.async {
                        NavigationUtil.showAlert(title: "Lỗi", msg: "Có lỗi xảy ra. Vui lòng kiểm tra internet hoặc liên hệ quản trị viên.", button: "OK")
                    }
                    print("\(urlString) >>>Error5: did not receive data")
                    return
                }
                DispatchQueue.main.async {
                    self.onSucceed?(responseData as AnyObject, response.statusCode, type)
                }
            }
        }
        .resume()
    }
}
