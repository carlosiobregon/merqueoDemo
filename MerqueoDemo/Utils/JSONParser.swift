//
//  JSONParser.swift
//  MerqueoDemo
//
//  Created by Carlos Obregón on 7/02/21.
//

import Foundation

class JSONParser {
    static func object2Dictionary<T: Encodable>(object: T?) -> [String : Any]?{
        let data = try! JSONEncoder().encode(object)
        return try! JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
    }
    
    static func object2QueryParams<T: Encodable>(object: T?) -> String? {
        let stringMinimalAcceptSize = 2
        let data = try? JSONEncoder().encode(object)
        let queryParams: String?
        if let encodedSender = data,
            let dataString = String(data: encodedSender, encoding: .utf8),
            dataString.count > stringMinimalAcceptSize {
            queryParams = dataString
                .replacingOccurrences(of: "{", with: "")
                .replacingOccurrences(of: "}", with: "")
                .replacingOccurrences(of: ",\"", with: "&")
                .replacingOccurrences(of: "\":", with: "=")
                .replacingOccurrences(of: "\"", with: "")
                .replacingOccurrences(of: "\\/", with: "%2F")
        } else {
            queryParams = nil
        }
        return queryParams
    }
    
    class DecodeObject<T: Decodable> {
        static func string2Object(string: String) -> T? {
            guard let data = string.data(using: .utf8) else { return nil }
            return try? JSONDecoder().decode(T.self, from: data)
        }
    }
}
