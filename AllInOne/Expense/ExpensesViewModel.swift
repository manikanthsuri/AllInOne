//
//  ExpensesViewModel.swift
//  AllInOne
//
//  Created by Suri Mani kanth on 21/12/23.
//

import Foundation
import Combine

class ExpensesViewModel {
    
    @Published var expenses: [RecordModel] = []
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        getExpenseList()
    }
    
    func getExpenseList() {
        self.$expenses
            .sink{ _ in }
            .store(in: &self.cancellables)
        FireBaseManager.shared.getExpensesList(completion: { result in
            switch result {
            case .success(let data):
                self.expenses = data.values.compactMap { entry in
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
                
                
            case .failure(let error):
                Loadder.shared.hideLoader()

            }
        })
    }}
