//
//  File.swift
//  AllInOne
//
//  Created by Suri Mani kanth on 26/12/23.
//

import Foundation
import SwiftUI
import UIKit

class HomeViewModel: ObservableObject {
    
    @Published var data: [DYPieFraction] = []
    @Published var selectedSlice: DYPieFraction?
    @Published var salary: Double?
    let viewModel = ExpensesViewModel()
    init() {
        viewModel.delegate = self
        viewModel.getSalaryDetails()
    }
    
}
extension HomeViewModel: dataDelegate {
    
    func dataDidUpdate(newData: [Any], ofType type: fetchDataType, error: Error?) {
        if error == nil && type == .salary {
            guard let salary = Double("\(newData[0])") else {
                return
            }
            self.salary = salary
            self.viewModel.getExpenseList()
        } else if error == nil && type == .expenses{
            guard let records = newData as? [RecordModel] else {
                return
            }
            self.data = processData(records: records)
        }
    }
    
    public func processData(records: [RecordModel])->[DYPieFraction] {
        var fractions : [DYPieFraction] = []
        var recodeArray = records
        
        for item in recodeArray {
            let duplicateItems = recodeArray.filter{$0.toAccount == item.toAccount}
            if duplicateItems.count > 1 {
                recodeArray.remove(elementsToRemove: duplicateItems)
                let subFractions = getSubFractions(records: duplicateItems)
                let fracrion = DYPieFraction(
                    value:  subFractions.1,
                    color: colorMapper[item.toAccount] ?? Color.random(),
                    title: item.toAccount,
                    record: item,
                    detailFractions: subFractions.0)
                fractions.append(fracrion)
            }
        }
        for item in recodeArray {
            let fracrion = DYPieFraction(
                value:  (item.amount as NSDecimalNumber).doubleValue,
                color: colorMapper[item.toAccount] ?? Color.random(),
                title: item.toAccount,
                record: item)
            fractions.append(fracrion)
        }
        let balance = Decimal(self.salary ?? 0.0) - records.reduce(0, { $0 + $1.amount})
        let fracrion = DYPieFraction(
            value:  (balance as NSDecimalNumber).doubleValue,
            color: colorMapper["BALANCE"] ?? Color.random(),
            title: "Balance")
        fractions.append(fracrion)
        
        return fractions
    }
    public func getSubFractions(records: [RecordModel])-> ([DYPieFraction],Double){
        var fractions : [DYPieFraction] = []
        var total: Double = 0.0
        for item in records {
            total = total + (item.amount as NSDecimalNumber).doubleValue
            let fracrion = DYPieFraction(
                value:  (item.amount as NSDecimalNumber).doubleValue,
                color: colorMapper[item.toAccount] ?? Color.random(),
                title: item.toAccount,
                record: item)
            fractions.append(fracrion)
        }
        return (fractions,total)
    }
}
extension Array where Element: Equatable {
    mutating func remove(elementsToRemove: [Element]) {
        self = self.filter { !elementsToRemove.contains($0) }
    }
}
