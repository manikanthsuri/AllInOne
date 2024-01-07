//
//  File.swift
//  AllInOne
//
//  Created by Suri.Manikanth on 02/01/24.
//

import Foundation
import UIKit

extension ExpenseListVC {
    
    @IBAction func filterBtnAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            
            filterCollectionView.delegate = self
            filterCollectionView.dataSource = self
            filterView.isHidden = false
            
            filterCollectionView.register(UINib(nibName: FilterCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: FilterCollectionViewCell.reuseIdentifier)
            filterCollectionView.register(UINib(nibName: "FilterCollectionViewHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "FilterCollectionViewHeader")
            filterCollectionView.reloadData()
        } else {
            filterCollectionView.delegate = nil
            filterCollectionView.dataSource = nil
            filterView.isHidden = true
        }
    }
    
    @IBAction func filterCancelBtnAction(_ sender: Any) {
        selectedFilterDict = [String: [String]]()
        filterView.isHidden = true
    }
    
    @IBAction func filterSaveBtnAction(_ sender: Any) {
        
    }
}
    
