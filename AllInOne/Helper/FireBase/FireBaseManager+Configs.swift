//
//  File.swift
//  AllInOne
//
//  Created by Suri Mani kanth on 29/12/23.
//

import Foundation

extension FireBaseManager {
    
    public func getConfigsList(completion: @escaping (Result<[String: Any], Error>) -> Void) {
        
        tableRef.child(configsTable).observeSingleEvent(of: .value) { (snapshot, error) in
            if let error = error {
                completion(.failure(error as! Error))
            } else if let data = snapshot.value as? [String: Any] {
                completion(.success(data))
            } else{
                completion(.failure(DataError.notFoundError))
            }
        }
    }
}
