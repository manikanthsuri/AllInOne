//
//  manager.swift
//  AllInOne
//
//  Created by Suri Manikanth on 20/11/23.
//

import Foundation
import FirebaseDatabase

final class FireBaseManager {
    
    static let shared = FireBaseManager()
    
    private let database = Database.database().reference()

}
enum DataError: Error {
    case notFoundError
}

// MARK: - Account management
extension FireBaseManager {
    
    public func insertExpenseRecord(record: RecordModel,completion: @escaping (Result<Bool, Error>) -> Void) {
        
        let uniqueId = "\(generate8DigitRandomNumber())"
        let recordDict = [
            "amount": record.amount,
            "fromAccount": record.fromAccount,
            "toAccount": record.toAccount,
            "reason": record.reason ?? "",
            "date": record.date,
            "month": record.month,
            "year": record.year,
            "sent": record.sent,
            "createdOn": getCurrentDateString(),
            "uniqueId": uniqueId
            
        ] as [String : Any]
        
        guard let recordDictJson = convertDictionaryToString(recordDict) else { return  }
        let hexString = stringToHex(recordDictJson)
        let record = ["data": hexString] as [String : Any]
        
        let ref = database.child("Expenses")
        ref.child("suri").child(uniqueId).setValue(record) { (error, ref) in
            if let error = error {
                completion(.failure(error))
                print("Error inserting data: \(error.localizedDescription)")
            } else {
                completion(.success(true))
                print("Data inserted successfully!")
            }
        }
    }
    
    public func updateExpenseRecord(record: RecordModel,completion: @escaping (Result<Bool, Error>) -> Void) {
        
        let uniqueId = record.uniqueId ?? ""
        
        let recordDict = [
            "amount": record.amount,
            "fromAccount": record.fromAccount,
            "toAccount": record.toAccount,
            "reason": record.reason ?? "",
            "date": record.date,
            "month": record.month,
            "year": record.year,
            "sent": record.sent,
            "createdOn": getCurrentDateString(),
            "uniqueId": record.uniqueId ?? ""
            
        ] as [String : Any]
        
        guard let recordDictJson = convertDictionaryToString(recordDict) else { return  }
        let hexString = stringToHex(recordDictJson)
        let record = ["data": hexString] as [String : Any]
        
        let ref = database.child("Expenses")
        
        ref.child("suri").child(uniqueId).updateChildValues(record) { (error, _) in
            if let error = error {
                completion(.failure(error))
                print("Failed to update data: \(error)")
            } else {
                completion(.success(true))
                print("Data updated successfully")
            }
        }
    }
    
    public func deleteExpenseRecord(record: RecordModel,completion: @escaping (Result<Bool, Error>) -> Void) {
        let uniqueId = record.uniqueId ?? ""
        let ref = database.child("Expenses")
        ref.child("suri").child(uniqueId).removeValue { (error, _) in
            if let error = error {
                completion(.failure(error))
                print("Failed to delete data: \(error)")
            } else {
                completion(.success(true))
                print("Data deleted successfully")
            }
        }
    }
    
    public func getExpensesList(completion: @escaping (Result<[String: [String:Any]], Error>) -> Void) {
        
        let usersRef = database.child("Expenses")
    
        usersRef.observeSingleEvent(of: .value) { (snapshot, error) in
            
            if let error = error {
                print("Error fetching data: \(error)")
                completion(.failure(error as! Error))
            } else if let data = snapshot.value as? [String: Any] {
                guard let details = data["suri"] else {
                   return
                }
                completion(.success(details as! [String : [String:Any]]))
                print("Fetched data: \(data)")
            } else{
                completion(.failure(DataError.notFoundError))
            }
        }
    }
    
    func getCurrentDateString() -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy HH:mm:ss"
        let dateString = dateFormatter.string(from: currentDate)
        return dateString
    }
    
    func generate8DigitRandomNumber() -> String {
        let lowerBound = 00000001
        let upperBound = 99999999
        let randomValue = Int(arc4random_uniform(UInt32(upperBound - lowerBound + 1))) + lowerBound
        return String(randomValue)
    }
}
extension FireBaseManager {
    
    func stringToHex(_ input: String) -> String {
        let utf8 = input.utf8
        var hexString = ""
        for byte in utf8 {
            hexString += String(format: "%02X", byte)
        }
        return hexString
    }
    
    func hexToString(_ hexString: String) -> String? {
        var hex = hexString
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
