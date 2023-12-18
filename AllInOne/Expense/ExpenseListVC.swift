//
//  ViewController.swift
//  AllInOne
//
//  Created by Suri Manikanth on 20/11/23.
//

import UIKit

class ExpenseListVC: UIViewController {

    @IBOutlet weak var expenseListTblView: UITableView!
    
    @IBOutlet weak var salaryPopupView: UIView!
    @IBOutlet weak var salaryTitleLabel: UILabel!
    
    @IBOutlet weak var monthView: UIView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var monthTFView: UIView!
    @IBOutlet weak var monthTF: UITextField!
    @IBOutlet weak var monthBtn: UIButton!
    
    @IBOutlet weak var yearView: UIView!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var yearTFView: UIView!
    @IBOutlet weak var yearTF: UITextField!
    @IBOutlet weak var yearBtn: UIButton!
    
    @IBOutlet weak var salaryView: UIView!
    @IBOutlet weak var salaryLabel: UILabel!
    @IBOutlet weak var salaryTFView: UIView!
    @IBOutlet weak var salaryTF: UITextField!
    
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!

    
    
    var expenses = [RecordModel]()
    var salary = [SalayModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Loadder.shared.showLoader(view: view)
        expenseListTblView.register(UINib(nibName: "ExpenseCell", bundle: nil), forCellReuseIdentifier: "ExpenseCell")
        getSalaryDetails()
        
    }
    func getSalaryDetails() {
        
        FireBaseManager.shared.getSalaryDetailsList(completion: { result in
            switch result {
            case .success(_):
                self.salaryPopupView.isHidden = true
                self.getExpenseList()
            case .failure(_):
                UIHelper.applyTileLayerEffects(to: [self.monthView,
                                                    self.yearView,
                                                    self.salaryView])
                UIHelper.applyBorderToView(to: [self.monthTFView,
                                                self.yearTFView,
                                                self.salaryTFView
                                                ])
                Loadder.shared.hideLoader()
                self.salaryPopupView.isHidden = false
            }
        })
    }
    func getExpenseList() {
        
        FireBaseManager.shared.getExpensesList(completion: { result in
            switch result {
            case .success(let data):
                self.expenses = data.values.compactMap { entry in
                    do {
                        if let hexString = entry["data"] as? String,
                           let dictString = FireBaseManager.shared.hexToString(hexString),
                           let dict = FireBaseManager.shared.convertStringToDictionary(dictString){
                            let jsonData = try JSONSerialization.data(withJSONObject: dict)
                            let transaction = try JSONDecoder().decode(RecordModel.self, from: jsonData)
                            return transaction
                        } else {
                            return nil
                        }
                    } catch {
                        return nil
                    }
                }
                self.expenseListTblView.reloadData()
                Loadder.shared.hideLoader()
            case .failure(let error):
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
                    AlertHelperKit().showAlert(self, title: "Something went wrong", message: "\(error)", button: "Ok")
                }

            }
        })
    }
    
}
extension ExpenseListVC: UITableViewDelegate, dataAddUpdateProtocol {
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    
    func dataAdded() {
        self.getExpenseList()
    }

}

extension ExpenseListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.expenses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExpenseCell", for: indexPath) as! ExpenseCell
        let record = self.expenses[indexPath.row]
        cell.amountLbl.text = "\(record.amount)"
        cell.fromlbl.text = "From : \(record.fromAccount)"
        cell.toLbl.text = "To : \(record.toAccount)"
        cell.dateLbl.text = "\(record.date)-\(record.month)-\(record.year)"
        cell.createdDateLbl.text = record.createdOn
        cell.reasonLbl.text = "For : \(record.reason ?? "")"
        let images = getImagesForTransaction(record: record)
        if images.count == 3 {
            cell.arrowImgView.image = images[1]
            cell.fromImgView.image = images[0]
            cell.toImgView.image = images[2]
        } else {
            cell.arrowImgView.isHidden = true
            cell.fromImgView.isHidden = true
            cell.toImgView.isHidden = true
        }
        if record.sent {
            cell.paidImgView.isHidden = false
        } else {
            cell.paidImgView.isHidden = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let record = self.expenses[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, completionHandler) in
            FireBaseManager.shared.deleteExpenseRecord(record: record) { result in
                switch result {
                case .success(_):
                    self.expenseListTblView.reloadData()
                case .failure(let error):
                    print("Failure: \(error)")
                }
            }
            completionHandler(true)
        }
        deleteAction.image = UIImage(systemName: "trash.circle.fill")
        
        let archiveAction = UIContextualAction(style: .normal, title: "edit") { (_, _, completionHandler) in
           
            self.editRecord(record: record)
            completionHandler(true)
        }
        archiveAction.backgroundColor = .blue
        archiveAction.image = UIImage(systemName: "pencil.circle.fill")
        
    
        if record.sent == false {
            
            return UISwipeActionsConfiguration(actions: [deleteAction, archiveAction])
            
        } else {
            
            return UISwipeActionsConfiguration(actions: [])
        }
    }
    func editRecord(record: RecordModel) {
        if let addRecordVC = storyboard!.instantiateViewController(withIdentifier: "AddRecordVC") as? AddRecordVC {
            addRecordVC.isfromEdit = true
            addRecordVC.addUpdateDelegate = self
            addRecordVC.selectedRecord = record
            self.present(addRecordVC, animated: true, completion: nil)
        }
    }
}
extension ExpenseListVC {
    
    func getImagesForTransaction(record: RecordModel) -> [UIImage] {
        var images = [UIImage]()
        guard let fromImg = getAccountImage(account: record.fromAccount.lowercased()) else {
            return []
        }
        images.append(fromImg)
        images.append(UIImage(named: "ic_arrow")!)
        guard let toImage = getAccountImage(account: record.toAccount.lowercased()) else {
            return []
        }
        images.append(toImage)
        return images
    }
    
    func getAccountImage(account:String) -> UIImage? {
        
        var accountType = account
        accountType = accountType.replacingOccurrences(of: " ", with: "_")
        guard let image = UIImage(named: accountType) else {
            return nil
        }
        return image
    }
}
