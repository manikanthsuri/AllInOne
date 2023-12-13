//
//  ViewController.swift
//  AllInOne
//
//  Created by Suri Manikanth on 20/11/23.
//

import UIKit

class ExpenseListVC: UIViewController {

    @IBOutlet weak var expenseListTblView: UITableView!
    
    var expenses = [RecordModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        expenseListTblView.register(UINib(nibName: "ExpenseCell", bundle: nil), forCellReuseIdentifier: "ExpenseCell")
        getExpenseList()
        // Do any additional setup after loading the view.
        
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
                print(self.expenses.count)
                self.expenseListTblView.reloadData()
            case .failure(let error):
                print("Failure: \(error)")
            }
        })
    }

    @IBAction func fetchButtonaction(_ sender: Any) {
     
        
    }
    
}
extension ExpenseListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
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
            addRecordVC.selectedRecord = record
            self.present(addRecordVC, animated: true, completion: nil)
        }
    }
}
extension ExpenseListVC {
    
    func getImagesForTransaction(record: RecordModel) -> [UIImage] {
        var images = [UIImage]()
        guard let fromImg = getToAccountImage(account: record.fromAccount.lowercased()) else {
            return []
        }
        images.append(fromImg)
        images.append(UIImage(named: "ic_arrow")!)
        guard let toImage = getToAccountImage(account: record.toAccount.lowercased()) else {
            return []
        }
        images.append(toImage)
        return images
    }
    
    func getToAccountImage(account:String) -> UIImage? {
        var  image: UIImage?
       
        if account.contains("hdfc") {
            image = UIImage(named: "hdfc")!
        } else if account.contains("icici") {
            image = UIImage(named: "icici")!
        } else if account.contains("sbi") {
            image = UIImage(named: "sbi")!
        } else if account.contains("union") {
            image = UIImage(named: "unionbank")!
        } else if account.contains("father") {
            image = UIImage(named: "father")!
        } else if account.contains("rent") {
            image = UIImage(named: "rent")!
        } else if account.contains("shannu rd") {
            image = UIImage(named: "srd")!
        } else if account.contains("vegitables") {
            image = UIImage(named: "vegitables")!
        } else if account.contains("milk") {
            image = UIImage(named: "milk")!
        } else if account.contains("post office") {
            image = UIImage(named: "postoffice")!
        } else if account.contains("ppf") {
            image = UIImage(named: "ppf")!
        } else if account.contains("bajaj") {
            image = UIImage(named: "bajaj")!
        } else if account.contains("hdfc credit card") {
            image = UIImage(named: "hdfccredit")!
        } else if account.contains("icici credit card") {
            image = UIImage(named: "icicicredit")!
        } else if account.contains("shop") {
            image = UIImage(named: "shop")!
        }
        return image
    }
}
