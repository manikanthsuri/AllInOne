//
//  File.swift
//  AllInOne
//
//  Created by Suri Mani kanth on 26/12/23.
//

import Foundation
class HomeViewModel {
    
    @Published var data: [DYPieFraction]
    @Published var selectedSlice: DYPieFraction?
   
    init() {
       getData()
    }
    
}
extension HomeViewModel: dataDelegate {
   
    func getData () {
        let viewModel = ExpensesViewModel()
        viewModel.delegate = self
        viewModel.getExpenseList()
    }
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

