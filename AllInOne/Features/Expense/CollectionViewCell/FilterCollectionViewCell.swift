//
//  FilterCollectionViewCell.swift
//  FilterCollectionViewCell
//


import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    
    static var reuseIdentifier: String = "FilterCollectionViewCell"
    
    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var labelCollectionViewTitle: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(name: String) {
        self.labelCollectionViewTitle.text = name
    }
}
