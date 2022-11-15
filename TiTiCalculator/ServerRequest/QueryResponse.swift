//
//  QueryResponse.swift
//  TiTiCalculator
//
//  Created by HauNguyen on 06/10/2565 BE.
//

import Foundation
import SwiftUI

protocol Jsonable {}

extension Jsonable {
    func toDict() -> [String:Any] {
        var dict = [String:Any]()
        let otherSelf = Mirror(reflecting: self)
        for child in otherSelf.children {
            if let key = child.label {
                if child.value is Date {
                    //dict[key] = DateFormatter.iso8601MT.string(from: date)
                }else{
                    dict[key] = child.value
                }
            }
        }
        return dict
    }
}

public struct QueryResponse<T : Codable> : Codable {
    public var items = [] as [T]
    public var total : Int = 0
    public var errorCode : String?
    public var errorMessage : String?
}

public struct QueryResponseNullable<T : Decodable> : Decodable {
    public var items = [] as [T]?
    public var total : Int = 0
    public var errorCode : String?
    public var errorMessage : String?
}
