//
//  File.swift
//  AllInOne
//
//  Created by Suri Mani kanth on 26/12/23.
//

import Foundation
import UIKit

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
//        let images = getImagesForTransaction(record: record)
//        if images.count == 3 {
//            cell.arrowImgView.image = images[1]
//            cell.fromImgView.image = images[0]
//            cell.toImgView.image = images[2]
//        } else {
//            cell.arrowImgView.isHidden = true
//            cell.fromImgView.isHidden = true
//            cell.toImgView.isHidden = true
//        }
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
                    self.expenses.remove(elementsToRemove: [record])
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
