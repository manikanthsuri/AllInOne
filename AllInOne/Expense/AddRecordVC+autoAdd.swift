//
//  File.swift
//  AllInOne
//
//  Created by Suri Mani kanth on 29/12/23.
//

import Foundation

extension AddRecordVC {
    
    func fetchDataFromJson() {
        
        let jsonData: Data
        do {
            jsonData = try JSONSerialization.data(withJSONObject: sampleRecords, options: .prettyPrinted)
            let recordData = try JSONDecoder().decode([RecordModel].self, from: jsonData)
            for item in recordData {
                insertDataIntoFireBase(record: item)
            }
        } catch {
            fatalError("Error converting to JSON data: \(error)")
        }
        
    }
    
    func insertDataIntoFireBase(record: RecordModel) {
        
        FireBaseManager.shared.insertExpenseRecord(
            record: record){ result in
                switch result {
                case .success (_):
                    print("Record added")
                case .failure(_):
                    print("error while adding record")
                }
            }
    }
}
