//
//  ExpensesViewModel.swift
//  AllInOne
//
//  Created by Suri Mani kanth on 21/12/23.
//

enum fetchDataType {
    case salary
    case expenses
}

protocol dataDelegate: AnyObject {
    func dataDidUpdate(newData: [Any], ofType type: fetchDataType, error: Error?)
}

import Foundation


class ExpensesViewModel {
    
    weak var delegate: dataDelegate?
    var salary: String?

    func getSalaryDetails(id: String? = nil) {
        
        FireBaseManager.shared.getSalaryDetailsList(
            id:id,
            completion: {[weak self] result in
            switch result {
            case .success(let data):
                self?.salary = data
                self?.delegate?.dataDidUpdate(newData: [data], ofType: .salary, error: nil)
            case .failure(let error):
                self?.delegate?.dataDidUpdate(newData: [], ofType: .salary, error: error)
            }
        })
    }
    
    func getExpenseList(id: String? = nil) {
        
        FireBaseManager.shared.getExpensesList(
            id: id,
            completion: { result in
            switch result {
            case .success(let data):
                let expenses = data.values.compactMap { entry in
                    do {
                        if let hexString = entry["data"] as? String,
                           let dictString = FireBaseManager.shared.hexToString(hexString),
                           let dict = FireBaseManager.shared.convertStringToDictionary(dictString){
                            let jsonData = try JSONSerialization.data(withJSONObject: dict)
                            let transaction = try JSONDecoder().decode(RecordModel.self, from: jsonData)
                            return transaction
                        } else {
                            return nil
                        }
                    } catch {
                        return nil
                    }
                }
                self.delegate?.dataDidUpdate(newData: expenses, ofType: .expenses, error: nil)
            case .failure(let error):
                self.delegate?.dataDidUpdate(newData: [], ofType: .expenses, error: error)
            }
        })
    }
}
