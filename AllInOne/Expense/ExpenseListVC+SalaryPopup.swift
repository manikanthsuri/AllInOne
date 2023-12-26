//
//  File.swift
//  AllInOne
//
//  Created by Suri Manikanth on 13/12/23.
//

import Foundation
import UIKit

extension ExpenseListVC {
    
    @IBAction func monthBtnAction(_ sender: Any) {
        let params = Parameters(
            message: "Select Month",
            cancelButton: "Cancel",
            otherButtons: months
        )
        AlertHelperKit().showAlertWithHandler(self, parameters: params) { buttonIndex in
            switch buttonIndex {
            case 0:
                return
            default:
                self.monthTF.text = months[buttonIndex - 1]
            }
        }
    }
    @IBAction func yearBtnAction(_ sender: Any) {
        let params = Parameters(
            message: "Select Year",
            cancelButton: "Cancel",
            otherButtons: years
        )
        AlertHelperKit().showAlertWithHandler(self, parameters: params) { buttonIndex in
            switch buttonIndex {
            case 0:
                return
            default:
                self.yearTF.text = years[buttonIndex - 1]
            }
        }
    }
    @IBAction func saveBtnAction(_ sender: Any) {
        
        guard let month = monthTF.text,
              let year = yearTF.text,
              let salary = salaryTF.text else {
            print("fill all details")
            return
        }
        let record = SalayModel(
            month: month,
            year: year,
            salary: salary)
        
            FireBaseManager.shared.insertSalaryRecord(
                record: record){ result in
                    switch result {
                    case .success (_):
                        AlertHelperKit().showAlert(self, title: nil, message: "Added successfully", button: "Ok")
                        self.viewModel.getExpenseList()
                        self.salaryPopupView.removeFromSuperview()
                    case .failure(let error):
                        AlertHelperKit().showAlert(self, title: "Something went wrong", message: "\(error)", button: "Ok")
                    }
                }
    }
    @IBAction func cancelBtnAction(_ sender: Any) {
        salaryPopupView.removeFromSuperview()
    }
}
extension ExpenseListVC: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == salaryTF {
            let allowedCharacterSet = CharacterSet.decimalDigits
            let replacementStringCharacterSet = CharacterSet(charactersIn: string)
            return allowedCharacterSet.isSuperset(of: replacementStringCharacterSet)
        } else {
            return true
        }
    }
}

extension Notification.Name {
    static let dataNotification = Notification.Name("dataAdded")
}
