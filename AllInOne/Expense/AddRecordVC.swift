//
//  AddRecordVC.swift
//  AllInOne
//
//  Created by Suri Manikanth on 01/12/23.
//

import UIKit

class AddRecordVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var amountView: UIView!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var amountTFView: UIView!
    @IBOutlet weak var amountTF: UITextField!
    
    @IBOutlet weak var fromAccountView: UIView!
    @IBOutlet weak var fromAccountLabel: UILabel!
    @IBOutlet weak var fromAccountTFView: UIView!
    @IBOutlet weak var fromAccountTF: UITextField!
    @IBOutlet weak var fromAccountBtn: UIButton!
    
    @IBOutlet weak var toAccountView: UIView!
    @IBOutlet weak var toAccountLabel: UILabel!
    @IBOutlet weak var toAccountTFView: UIView!
    @IBOutlet weak var toAccountTF: UITextField!
    @IBOutlet weak var toAccountBtn: UIButton!
    
    @IBOutlet weak var forView: UIView!
    @IBOutlet weak var forLabel: UILabel!
    @IBOutlet weak var forTFView: UIView!
    @IBOutlet weak var forTF: UITextField!
    
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dateTFView: UIView!
    @IBOutlet weak var dateTF: UITextField!
    @IBOutlet weak var dateBtn: UIButton!
    @IBOutlet weak var monthTF: UITextField!
    @IBOutlet weak var monthBtn: UIButton!
    @IBOutlet weak var yearTF: UITextField!
    @IBOutlet weak var yearBtn: UIButton!
    
    @IBOutlet weak var sentView: UIView!
    @IBOutlet weak var sentLabel: UILabel!
    @IBOutlet weak var sentTFView: UIView!
    @IBOutlet weak var sentTF: UITextField!
    @IBOutlet weak var sentBtn: UIButton!
    
    @IBOutlet weak var submitBtn: UIButton!
    
    var isfromEdit = false
    var selectedRecord: RecordModel? = nil
    var addUpdateDelegate: dataAddUpdateProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIHelper.applyTileLayerEffects(to: [amountView,
                                            fromAccountView,
                                            toAccountView,
                                            dateView,
                                            sentView,
                                            forView])
        UIHelper.applyBorderToView(to: [amountTFView,
                                        fromAccountTFView,
                                        sentTFView,
                                        toAccountTFView,
                                        sentTFView,
                                        submitBtn,
                                        dateTF,
                                        monthTF,
                                        yearTF,
                                        forTFView])
        
        if isfromEdit {
            setValues()
            titleLbl.text = "Update Expense"
        } else {
            titleLbl.text = "Add Expense"
        }
        
    }
    @IBAction func fromAccountBtnAction(_ sender: Any) {
        let params = Parameters(
            message: "Select from which account you want transfer",
            cancelButton: "Cancel",
            otherButtons: fromAccounts
        )
        AlertHelperKit().showAlertWithHandler(self, parameters: params) { buttonIndex in
            switch buttonIndex {
            case 0:
                return
            default:
                self.fromAccountTF.text = fromAccounts[buttonIndex - 1]
            }
        }
    }
    @IBAction func toAccountBtnAction(_ sender: Any) {
        let params = Parameters(
            message: "Select to which account you want transfer",
            cancelButton: "Cancel",
            otherButtons: toAccounts
        )
        AlertHelperKit().showAlertWithHandler(self, parameters: params) { buttonIndex in
            switch buttonIndex {
            case 0:
                return
            default:
                self.toAccountTF.text = toAccounts[buttonIndex - 1]
            }
        }
    }
    @IBAction func dateBtnAction(_ sender: Any) {
        let params = Parameters(
            message: "Select Date",
            cancelButton: "Cancel",
            otherButtons: dates
        )
        AlertHelperKit().showAlertWithHandler(self, parameters: params) { buttonIndex in
            switch buttonIndex {
            case 0:
                return
            default:
                self.dateTF.text = dates[buttonIndex - 1]
            }
        }
    }
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
    @IBAction func sentBtnAction(_ sender: Any) {
        let params = Parameters(
            message: "Is amount sent already?",
            cancelButton: "Cancel",
            otherButtons: bools
        )
        AlertHelperKit().showAlertWithHandler(self, parameters: params) { buttonIndex in
            switch buttonIndex {
            case 0:
                return
            default:
                self.sentTF.text = bools[buttonIndex - 1]
            }
        }
    }

    func setValues(){
        
        guard let record = selectedRecord else {
            return
        }
        amountTF.text = "\(record.amount)"
        amountTF.isUserInteractionEnabled = false
        amountTFView.backgroundColor = .lightGray
        
        fromAccountTF.text = record.fromAccount
        fromAccountTF.isUserInteractionEnabled = false
        fromAccountTFView.backgroundColor = .lightGray
        
        toAccountTF.text = record.toAccount
        toAccountTF.isUserInteractionEnabled = false
        toAccountTFView.backgroundColor = .lightGray
        
        forTF.text = record.reason
        dateTF.text = record.date
        
        monthTF.text = record.month
        monthTF.isUserInteractionEnabled = false
        monthTF.backgroundColor = .lightGray
        
        yearTF.text = record.year
        yearTF.isUserInteractionEnabled = false
        yearTF.backgroundColor = .lightGray
        
        sentTF.text = "\(record.sent)"
        
    }
    @IBAction func submitButtonAction(_ sender: UIButton) {
        
        guard let amount = Decimal(string: amountTF.text ?? ""),
              let fromAccount = fromAccountTF.text,
              let toAccount = toAccountTF.text,
              let reson = forTF.text,
              let date = dateTF.text,
              let month = monthTF.text,
              let year = yearTF.text,
              let sent = sentTF.text else {
            print("fill all details")
            return
        }
        
        let record = RecordModel(
            amount: amount,
            fromAccount: fromAccount,
            toAccount: toAccount,
            reason: reson,
            date: date,
            month: month,
            year: year,
            sent: Bool(sent.lowercased()) ?? false,
            uniqueId: selectedRecord?.uniqueId)
        
        if isfromEdit {
            FireBaseManager.shared.updateExpenseRecord(
                record: record){ result in
                    switch result {
                    case .success(_):
                        let params = Parameters(
                            title: "Message",
                            message: "Expense updated successfully",
                            otherButtons: ["Ok"]
                        )
                        AlertHelperKit().showAlertWithHandler(self, parameters: params) { buttonIndex in
                            switch buttonIndex {
                            default:
                                self.addUpdateDelegate?.dataAdded()
                                self.dismiss(animated: true)
                            }
                        }
                    case .failure(let error):
                        AlertHelperKit().showAlert(self, title: "Expense update failed", message: "\(error)", button: "Ok")
                    }
                }
        } else {
            FireBaseManager.shared.insertExpenseRecord(
                record: record){ result in
                    switch result {
                    case .success (_):
                        let params = Parameters(
                            title: "",
                            message: "Do you want add one more Expense",
                            cancelButton: "No",
                            otherButtons: ["Yes"]
                        )
                        AlertHelperKit().showAlertWithHandler(self, parameters: params) { buttonIndex in
                            switch buttonIndex {
                            case 0:
                                self.addUpdateDelegate?.dataAdded()
                                self.dismiss(animated: true)
                            default:
                                self.resetTextFields()
                            }
                        }
                    case .failure(let error):
                        AlertHelperKit().showAlert(self, title: "Something went wrong", message: "\(error)", button: "Ok")
                    }
                }
        }
    }
    func resetTextFields(){
        amountTF.text = ""
        fromAccountTF.text = ""
        toAccountTF.text = ""
        forTF.text = ""
        dateTF.text = ""
        monthTF.text = ""
        yearTF.text = ""
        sentTF.text = ""
    }
    @IBAction func closeButtonAction(_ sender: UIButton) {
        dismiss(animated: true)
    }
    //UITextField Delegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == amountTF {
            let allowedCharacterSet = CharacterSet.decimalDigits
            let replacementStringCharacterSet = CharacterSet(charactersIn: string)
            return allowedCharacterSet.isSuperset(of: replacementStringCharacterSet)
        } else {
            return true
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    // Called just before the text field becomes active
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Perform actions when the text field becomes active
    }
    
    // Called just after the text field becomes inactive
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Perform actions when the text field becomes inactive
    }
}