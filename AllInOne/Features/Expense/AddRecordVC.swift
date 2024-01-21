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
    @IBOutlet weak var autoAddBtn: UIButton!
    
    @IBOutlet weak var optionsView: UIView!
    @IBOutlet weak var optionsCollectionView: UICollectionView!
    @IBOutlet weak var optionsViewHeightConstant: NSLayoutConstraint!
    
    var isfromEdit = false
    var selectedRecord: RecordModel? = nil
    var addUpdateDelegate: dataAddUpdateProtocol?
    
    var selectedFiled = ""
    
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
            titleLbl.text = "Update Expense"
        } else {
            titleLbl.text = "Add Expense"
        }
        setValues()
        if showAutoAdd {
            autoAddBtn.isHidden = false
        }
        configOptions()
    }
    func configOptions() {
        optionsCollectionView.register(UINib(nibName: FilterCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: FilterCollectionViewCell.reuseIdentifier)
        
        optionsView.layer.borderWidth = 2.0
        optionsView.layer.borderColor = UIColor.systemMint.cgColor
        optionsView.layer.cornerRadius = 5.0
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
        
        selectedFiled = "To Account"
        optionsView.isHidden = false
        optionsCollectionView.reloadData()
        optionsViewHeightConstant.constant = 450
    }
    @IBAction func dateBtnAction(_ sender: Any) {
        
        selectedFiled = "Date"
        optionsView.isHidden = false
        optionsCollectionView.reloadData()
        optionsViewHeightConstant.constant = 320
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
        if isfromEdit {
            guard let record = selectedRecord else {
                return
            }
            amountTF.text = "\(record.amount)"
            fromAccountTF.text = record.fromAccount
            toAccountTF.text = record.toAccount
            forTF.text = record.reason
            dateTF.text = record.date
            monthTF.text = record.month
            yearTF.text = record.year
            sentTF.text = "\(record.sent)"
        } else {
            dateTF.text = DataHelper.getCurrentDayString()
            monthTF.text = DataHelper.getCurrentMonthString()
            yearTF.text = DataHelper.getCurrentYearString()
        }
       
    }
    @IBAction func autoAddBtnAction(_ sender: Any) {
        fetchDataFromJson()
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
                                NotificationCenter.default.post(name: .dataNotification, object: nil)
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
                                NotificationCenter.default.post(name: .dataNotification, object: nil)
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
        if sender.tag == 1 {
            optionsView.isHidden = true
        } else {
            dismiss(animated: true)
        }
        
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
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == amountTF {
            textField.keyboardType = .numberPad
        }
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
