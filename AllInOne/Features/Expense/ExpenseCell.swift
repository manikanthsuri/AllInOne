//
//  ExpenseCell.swift
//  AllInOne
//
//  Created by Suri Manikanth on 01/12/23.
//

import UIKit

class ExpenseCell: UITableViewCell {

    
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var fromImgView: UIImageView!
    @IBOutlet weak var toImgView: UIImageView!
    @IBOutlet weak var fromlbl: UILabel!
    @IBOutlet weak var toLbl: UILabel!
    @IBOutlet weak var createdDateLbl: UILabel!
    @IBOutlet weak var amountLbl: UILabel!
    @IBOutlet weak var reasonLbl: UILabel!
    @IBOutlet weak var paidImgView: UIImageView!
    @IBOutlet weak var arrowImgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        subView.layer.cornerRadius = 5.0
        subView.layer.borderWidth = 3
        subView.layer.borderColor = UIColor.orange.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    
    }
    
}
