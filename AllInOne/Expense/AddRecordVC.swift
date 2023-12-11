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
    @IBOutlet weak var fromAccountTF: DropDown!
    
    @IBOutlet weak var toAccountView: UIView!
    @IBOutlet weak var toAccountLabel: UILabel!
    @IBOutlet weak var toAccountTFView: UIView!
    @IBOutlet weak var toAccountTF: UITextField!
    
    @IBOutlet weak var forView: UIView!
    @IBOutlet weak var forLabel: UILabel!
    @IBOutlet weak var forTFView: UIView!
    @IBOutlet weak var forTF: UITextField!
    
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dateTFView: UIView!
    @IBOutlet weak var dateTF: DropDown!
    @IBOutlet weak var monthTF: DropDown!
    @IBOutlet weak var yearTF: DropDown!
    
    @IBOutlet weak var sentView: UIView!
    @IBOutlet weak var sentLabel: UILabel!
    @IBOutlet weak var sentTFView: UIView!
    @IBOutlet weak var sentTF: DropDown!
    
    @IBOutlet weak var submitBtn: UIButton!
    
    var isfromEdit = false
    var selectedRecord: RecordModel? = nil
    
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
        
        UIHelper.setDropDownTextField(to: sentTF, options: bools)
        UIHelper.setDropDownTextField(to: dateTF, options: dates)
        UIHelper.setDropDownTextField(to: monthTF, options: months)
        UIHelper.setDropDownTextField(to: yearTF, options: years)
        UIHelper.setDropDownTextField(to: fromAccountTF, options: fromAccounts)
        if isfromEdit {
            setValues()
            titleLbl.text = "Update Expense"
        } else {
            titleLbl.text = "Add Expense"
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
            sent: Bool(sent.lowercased()) ?? false)
        if isfromEdit {
            FireBaseManager.shared.updateExpenseRecord(
                record: record){ result in
                    switch result {
                    case .success(_):
                        print("mk")
                    case .failure(let error):
                        print("Failure: \(error)")
                    }
                }
        } else {
            FireBaseManager.shared.insertExpenseRecord(
                record: record){ result in
                    switch result {
                    case .success (_):
                        print("mk")
                        self.resetTextFields()
                    case .failure(let error):
                        print("Failure: \(error)")
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


//if let trueBool = Bool("True") { print("Converted to Bool:", trueBool)} else { print("Conversion to Bool failed")}
