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
            self.data = processData(records: records)
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
        return "Salary - \(Decimal(salary ?? 0.0))"
    }
    
    func expensesText() -> String {
        
        return "Expenses - \(records.reduce(0, { $0 + $1.amount}))"
    }
    
    func balanceText() -> String {
        let balance = Decimal(self.salary ?? 0.0) - records.reduce(0, { $0 + $1.amount})
        return "Balance - \(balance)"
    }
    
}
extension Array where Element: Equatable {
    mutating func remove(elementsToRemove: [Element]) {
        self = self.filter { !elementsToRemove.contains($0) }
    }
}

struct filterView: View {
    
    @State private var selectedMonth = 0
    @State private var selectedYear = 0
    @Binding var isPresented: Bool
    var onDataReceived: (String) -> Void
    
    var body: some View {
        
        VStack{
            HStack {
                Picker("Select an option", selection: $selectedMonth) {
                    ForEach(months.indices, id: \.self) { index in
                        Text(months[index]).tag(index)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                
                Picker("Select an option", selection: $selectedYear) {
                    ForEach(years.indices, id: \.self) { index in
                        Text(years[index]).tag(index)
                    }
                }
                .pickerStyle(MenuPickerStyle())
            }
            HStack {
                Button("Show Data") {
                    onDataReceived("\(months[selectedMonth])-\(years[selectedYear])")
                    isPresented.toggle()
                }
            }
        }
        .padding()
    }
}
