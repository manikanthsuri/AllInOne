//
//  File.swift
//  AllInOne
//
//  Created by Suri Mani kanth on 26/12/23.
//

import Foundation
import UIKit

class HomeViewModel: ObservableObject {
    
    @Published var data: [DYPieFraction] = []
    @Published var selectedSlice: DYPieFraction?
   
    init() {
        let viewModel = ExpensesViewModel()
        viewModel.delegate = self
        viewModel.getExpenseList()
    }
    
}
extension HomeViewModel: dataDelegate {
   
    func dataDidUpdate(newData: [Any], ofType type: fetchDataType, error: Error?) {
        if error == nil && type == .expenses{
            guard let records = newData as? [RecordModel] else {
                return
            }
            self.data = processData(records: records)
        }
    }
    
    public func processData(records: [RecordModel])->[DYPieFraction] {
    
        var fractions : [DYPieFraction] = []
        for item in records {
            let value = (item.amount as NSDecimalNumber).doubleValue
            let fracrion = DYPieFraction(value: value, title: item.toAccount, detailFractions: [])
            fractions.append(fracrion)
        }
    
        return fractions
    }
}
