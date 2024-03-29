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
    @Published var id: String?
    var records = [RecordModel]()
    let viewModel = ExpensesViewModel()
    init() {
        viewModel.delegate = self
        viewModel.getSalaryDetails()
    }
    func updateDetails(id:String) {
        self.id = id
        viewModel.getSalaryDetails(id: id)
    }
}
extension HomeViewModel: dataDelegate {
    
    func dataDidUpdate(newData: [Any], ofType type: fetchDataType, error: Error?) {
        if error == nil && type == .salary {
            guard let salary = Double("\(newData[0])") else {
                return
            }
            self.salary = salary
            self.viewModel.getExpenseList(id: self.id)
        } else if error == nil && type == .expenses{
            guard let records = newData as? [RecordModel] else {
                return
            }
            self.records = records
            
            let filteredRecords = self.records.filter { record in
                if bankAccounts.contains(record.toAccount){
                    return true
                }
                return false
            }
            self.records.remove(elementsToRemove: filteredRecords)
            self.data = processData(records: self.records)
        } else if type == .expenses {
            self.records = []
            self.data = processData(records: [])
        } else {
            self.salary = 0.0
            self.records = []
            self.data = processData(records: [])
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
    
    func salaryText() -> String {
        let salaray = Decimal(salary ?? 0.0)
        return !salaray.isZero ? "Salary - \(salaray)" : ""
    }
    
    func expensesText() -> String {
        let expenses = records.reduce(0, { $0 + $1.amount})
        return !expenses.isZero ? "Expenses - \(expenses)" : ""
    }
    
    func balanceText() -> String {
        let balance = Decimal(self.salary ?? 0.0) - records.reduce(0, { $0 + $1.amount})
        return !balance.isZero ? "Balance - \(balance)" : ""
    }
    
    func paidUnPaidText() -> String {
        let paidRecords = records.filter{$0.sent == true}.reduce(0, { $0 + $1.amount})
        let unpaidrecords = records.filter{$0.sent == false}.reduce(0, { $0 + $1.amount})
        if !paidRecords.isZero && !unpaidrecords.isZero {
            return "Paid / Unpaid - \(paidRecords) / \(unpaidrecords)"
        } else if !paidRecords.isZero {
            return "Paid - \(paidRecords)"
        } else if !unpaidrecords.isZero {
            return "Unpaid - \(unpaidrecords)"
        } else {
            return ""
        }
        
    }
}
extension Array where Element: Equatable {
    mutating func remove(elementsToRemove: [Element]) {
        self = self.filter { !elementsToRemove.contains($0) }
    }
}

