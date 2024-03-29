//
//  File.swift
//  AllInOne
//
//  Created by Suri.Manikanth on 02/01/24.
//

import Foundation
import UIKit

extension ExpenseListVC : filterProtocol {
        
    @IBAction func filterBtnAction(_ sender: UIButton) {

        if !sender.isSelected {
            if let filterVC = storyboard!.instantiateViewController(withIdentifier: "FilterVC") as? FilterVC {
                filterVC.filterDelegate = self
                self.present(filterVC, animated: true, completion: nil)
            }
        } else {
            sender.isSelected = false
            filteredExpenses = expenses
            expenseListTblView.reloadData()
        }
        
    }
    
    func filter(with filterDict: [String : [String]]) {
        applyFilter(with: filterDict)
    }
    
    func applyFilter(with filterDict: [String : [String]]) {
       
        var predicateArray = [NSPredicate]()
    
        for (key, value) in filterDict {
            if value.count > 0 {
                var format: String
                switch key {
                case "Year":
                    format = "year IN %@"
                case "To Account":
                    format = "toAccount IN %@"
                case "Transaction Status":
                    format = "sent IN %@"
                case "From Account":
                    format = "fromAccount IN %@"
                case "Date":
                    format = "date IN %@"
                case "Month":
                    format = "month IN %@"
                default:
                    continue
                }
                let predicate = NSPredicate(format: format, argumentArray: [value])
                predicateArray.append(predicate)
            }
        }
        if predicateArray.count > 0 {
            let finalPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicateArray)
            let filteredArray = expenses.filter { finalPredicate.evaluate(with: $0) }
            if filteredArray.count > 0{
                self.filterBtn.isSelected = true
                filteredExpenses = filteredArray
            } else {
                filteredExpenses = expenses
            }
            expenseListTblView.reloadData()
        }
    }
}
    
