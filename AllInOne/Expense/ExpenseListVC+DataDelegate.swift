//
//  File.swift
//  AllInOne
//
//  Created by Suri Mani kanth on 26/12/23.
//

import Foundation
import UIKit

extension ExpenseListVC: dataDelegate {
    
    func dataDidUpdate(newData: [Any], ofType type: fetchDataType, error: Error?) {
        if error != nil {
            if type == .salary {
                UIHelper.applyTileLayerEffects(to: [self.monthView,
                                                    self.yearView,
                                                    self.salaryView])
                UIHelper.applyBorderToView(to: [self.monthTFView,
                                                self.yearTFView,
                                                self.salaryTFView
                                               ])
                Loadder.shared.hideLoader()
                self.salaryPopupView.isHidden = false
            } else {
                Loadder.shared.hideLoader()
                if let error = error as? DataError,
                   error == .notFoundError{
                    let params = Parameters(
                        title: "Expenses not found",
                        message: "Do you want add Expense",
                        cancelButton: "No",
                        otherButtons: ["Yes"]
                    )
                    AlertHelperKit().showAlertWithHandler(self, parameters: params) { buttonIndex in
                        switch buttonIndex {
                        case 0:
                            self.dismiss(animated: true)
                        default:
                            
                            let storyboard = UIStoryboard(name: "Expense", bundle: nil)
                            
                            guard let addRecordVC = storyboard.instantiateViewController(withIdentifier: "AddRecordVC") as? AddRecordVC else {
                                break
                            }
                            self.present(addRecordVC, animated: true)
                        }
                    }
                } else {
                    if let error = error {
                        AlertHelperKit().showAlert(self, title: "Something went wrong", message: "\(error)", button: "Ok")
                    }
                    
                }
            }
        } else {
            if type == .salary {
                salaryPopupView.isHidden = true
                viewModel.getExpenseList()
                lbl1.text = "Salary: \(viewModel.salary ?? "")"
            } else {
                Loadder.shared.hideLoader()
                guard let records = newData as? [RecordModel] else {
                    return
                }
                var sortedRecords = records.sorted { record1, record2 in
                    return record1.createdOn ?? "" < record2.createdOn ?? ""
                }
                expenses = sortedRecords
                
                let filteredRecords = self.expenses.filter { record in
                    if bankAccounts.contains(record.toAccount){
                        return true
                    }
                    return false
                }
                sortedRecords.remove(elementsToRemove: filteredRecords)
                
                let balance = (Decimal(string: viewModel.salary ?? "0") ?? 0.0) - sortedRecords.reduce(0, { $0 + $1.amount})
                lbl3.text = "Balance: \(balance)"
                expenseListTblView.reloadData()
            }
        }
    }
}
