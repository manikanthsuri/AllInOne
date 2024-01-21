//
//  File.swift
//  AllInOne
//
//  Created by Suri Manikanth on 13/12/23.
//

import Foundation

extension FireBaseManager {
    
    func stringToHex(_ input: String) -> String {
        let utf8 = input.utf8
        var hexString = ""
        for byte in utf8 {
            hexString += String(format: "%02X", byte)
        }
        hexString.insert(contentsOf: "F", at: hexString.postion())
       
        return hexString
    }
    
    func hexToString(_ hexString: String) -> String? {
        var hex = hexString
        hex.remove(at: hex.postion())
        var string = ""
        while hex.count > 0 {
            let startIndex = hex.startIndex
            let endIndex = hex.index(hex.startIndex, offsetBy: 2)
            let byte = hex[startIndex..<endIndex]
            
            if let num = UInt8(byte, radix: 16) {
                string.append(Character(UnicodeScalar(num)))
            } else {
                return nil // Invalid hex string
            }
            hex = String(hex[endIndex...])
        }
        return string
    }
    
    func convertDictionaryToString(_ dictionary: [String: Any]) -> String? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: [])
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                return jsonString
            }
        } catch {
            print("Error converting dictionary to string: \(error.localizedDescription)")
        }
        return nil
    }
    
    func convertStringToDictionary(_ jsonString: String) -> [String: Any]? {
        if let jsonData = jsonString.data(using: .utf8) {
            do {
                if let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                    return jsonObject
                }
            } catch {
                print("Error converting string to dictionary: \(error.localizedDescription)")
            }
        }
        return nil
    }
}
extension String {
    func postion() -> String.Index {
       return self.index(self.startIndex, offsetBy: 9)
    }
}
