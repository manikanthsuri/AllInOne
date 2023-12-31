//
//  File.swift
//  AllInOne
//
//  Created by Suri Manikanth on 13/12/23.
//

import Foundation

extension FireBaseManager {
    
    public func insertExpenseRecord(record: RecordModel,completion: @escaping (Result<Bool, Error>) -> Void) {
        
        let uniqueId = "\(DataHelper.generate8DigitRandomNumber())"
        let recordDict = [
            "amount": record.amount,
            "fromAccount": record.fromAccount,
            "toAccount": record.toAccount,
            "reason": record.reason ?? "",
            "date": record.date,
            "month": record.month,
            "year": record.year,
            "sent": record.sent,
            "createdOn": DataHelper.getCurrentDateString(),
            "uniqueId": uniqueId
        ] as [String : Any]
        
        let childTable = "\(record.month)-\(record.year)"
        guard let recordDictJson = convertDictionaryToString(recordDict) else { return  }
        let hexString = stringToHex(recordDictJson)
        let record = ["data": hexString] as [String : Any]
        
        tableRef.child(expensesTable).child(childTable).child(uniqueId).setValue(record) { (error, ref) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
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
            "createdOn": DataHelper.getCurrentDateString(),
            "uniqueId": record.uniqueId ?? ""
            
        ] as [String : Any]
        
        guard let recordDictJson = convertDictionaryToString(recordDict) else { return  }
        let hexString = stringToHex(recordDictJson)
        let record = ["data": hexString] as [String : Any]
        
        tableRef.child(expensesTable).child(monthTable).child(uniqueId).updateChildValues(record) { (error, _) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    public func deleteExpenseRecord(record: RecordModel,completion: @escaping (Result<Bool, Error>) -> Void) {
        let uniqueId = record.uniqueId ?? ""
        let childTable = "\(record.month)-\(record.year)"
        tableRef.child(expensesTable).child(childTable).child(uniqueId).removeValue { (error, _) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    public func getExpensesList(
        id:String? = nil,
        completion: @escaping (Result<[String: [String:Any]], Error>) -> Void) {
       
        let table = id ?? monthTable
        
        tableRef.child(expensesTable).child(table).observeSingleEvent(of: .value) { (snapshot, error) in
            if let error = error {
                completion(.failure(error as! Error))
            } else if let data = snapshot.value as? [String: Any] {
                completion(.success(data as! [String : [String:Any]]))
            } else{
                completion(.failure(DataError.notFoundError))
            }
        }
    }
    
}
