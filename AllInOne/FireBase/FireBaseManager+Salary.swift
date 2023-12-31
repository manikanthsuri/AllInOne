//
//  File.swift
//  AllInOne
//
//  Created by Suri Manikanth on 13/12/23.
//

import Foundation

extension FireBaseManager {
    
    public func insertSalaryRecord(record: SalayModel,completion: @escaping (Result<Bool, Error>) -> Void) {
        
        let recordDict = [
            "salary": record.salary,
            "createdOn": record.createdOn,
            "uniqueId": record.uniqueId
        ] as [String : Any]
        
        let dataRecord = ["data": recordDict] as [String : Any]
        
        tableRef.child(salaryTable).child(record.uniqueId).setValue(dataRecord) { (error, ref) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    public func getSalaryDetailsList(
        id:String? = nil,
        completion: @escaping (Result<String, Error>) -> Void) {
        
        tableRef.child(salaryTable).observeSingleEvent(of: .value) { (snapshot, error) in
            
            if let error = error {
                completion(.failure(error as! Error))
            } else {
                let uniqueKey = id ?? DataHelper.getMonthYearString()

                if let data = snapshot.value as? [String: Any] {
                    guard let dataValues = data[uniqueKey] as? [String : [String:Any]] else {
                        completion(.failure(DataError.notFoundError))
                        return
                    }
                    let salaryArray = dataValues.values.compactMap { entry in
                        do {
                            let jsonData = try JSONSerialization.data(withJSONObject: entry)
                            let transaction = try JSONDecoder().decode(SalayModel.self, from: jsonData)
                            return transaction
                        } catch {
                            return nil
                        }
                    }
                    completion(.success(salaryArray[0].salary))
                    
                } else {
                    completion(.failure(DataError.notFoundError))
                }
            }
        }
    }
}
