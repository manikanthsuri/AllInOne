//
//  myViewController.swift
//  AllInOne-SwiftUI
//
//  Created by Suri Manikanth on 11/12/23.
//

import SwiftUI
import UIKit

struct ExpenseListVCWrapper: UIViewControllerRepresentable {
   
    typealias UIViewControllerType = ExpenseListVC

    func makeUIViewController(context: Context) -> ExpenseListVC {
      
        let storyboard = UIStoryboard(name: "Expense", bundle: nil)
        
        let expenseListVc = (storyboard.instantiateViewController(withIdentifier: "ExpenseListVC") as? ExpenseListVC)!

        return expenseListVc
    }

    func updateUIViewController(_ uiViewController: ExpenseListVC, context: Context) {
        // Update the UIViewController if needed
    }
}

struct AddRecordVCWrapper: UIViewControllerRepresentable {
   
    typealias UIViewControllerType = AddRecordVC

    func makeUIViewController(context: Context) -> AddRecordVC {
      
        let storyboard = UIStoryboard(name: "Expense", bundle: nil)
        
        let addRecordVC = (storyboard.instantiateViewController(withIdentifier: "AddRecordVC") as? AddRecordVC)!
        return addRecordVC
    }

    func updateUIViewController(_ uiViewController: AddRecordVC, context: Context) {
        // Update the UIViewController if needed
    }
}
