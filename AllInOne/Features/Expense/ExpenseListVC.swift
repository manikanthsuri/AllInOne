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
    @IBOutlet weak var filterBtn: UIButton!
    
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    @IBOutlet weak var lbl4: UILabel!
    
    var expenses = [RecordModel]()
    var filteredExpenses = [RecordModel]()
    var salary = [SalayModel]()
    let viewModel = ExpensesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Loadder.shared.showLoader(view: view)
        viewModel.delegate = self
        expenseListTblView.register(UINib(nibName: "ExpenseCell", bundle: nil), forCellReuseIdentifier: "ExpenseCell")
        viewModel.getSalaryDetails()
        NotificationCenter.default.addObserver(self, selector: #selector(dataAdded), name: .dataNotification, object: nil)
    }
}
extension ExpenseListVC: dataAddUpdateProtocol {
    
    func dataAdded() {
        self.viewModel.getExpenseList()
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
