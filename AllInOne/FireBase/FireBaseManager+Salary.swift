//
//  File.swift
//  AllInOne
//
//  Created by Suri Manikanth on 13/12/23.
//

import Foundation

extension FireBaseManager {
    
    public func insertSalaryRecord(record: SalayModel,completion: @escaping (Result<Bool, Error>) -> Void) {
        
        let uniqueId = "\(record.month)-\(record.year)"
        let recordDict = [
            "salary": record.salary,
            "createdOn": DataHelper.getCurrentDateString(),
            "uniqueId": uniqueId
        ] as [String : Any]
        
        let record = ["data": recordDict] as [String : Any]
        
        tableRef.child(salaryTable).child(uniqueId).setValue(record) { (error, ref) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
        
    public func getSalaryDetailsList(completion: @escaping (Result<Bool, Error>) -> Void) {
        
        tableRef.child(salaryTable).observeSingleEvent(of: .value) { (snapshot, error) in
            
            if let error = error {
                completion(.failure(error as! Error))
            } else {
               
                let uniqueKey = DataHelper.getMonthYearString()
                if let data = snapshot.value as? [String: Any] {
                    guard (data[uniqueKey] != nil) else {
                        completion(.failure(DataError.notFoundError))
                        return
                    }
                    completion(.success(true))
                } else {
                    completion(.failure(DataError.notFoundError))
                }
            }
        }
    }
}
