//
//  File.swift
//  AllInOne
//
//  Created by Suri.Manikanth on 07/01/24.
//

import Foundation
import UIKit

class FilterVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var filterTitleLabel: UILabel!
    @IBOutlet weak var filterCollectionView: UICollectionView!
    @IBOutlet weak var filterSaveBtn: UIButton!
    @IBOutlet weak var filterCancelBtn: UIButton!
    var selectedFilterDict = [String: [String]]()
    
    var filterDelegate: filterProtocol?
    
    override func viewDidLoad() {
        
        filterCollectionView.register(UINib(nibName: FilterCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: FilterCollectionViewCell.reuseIdentifier)
        filterCollectionView.register(UINib(nibName: "FilterCollectionViewHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "FilterCollectionViewHeader")
    }
    
    @IBAction func filterCancelBtnAction(_ sender: Any) {
      dismiss(animated: true)
    }
    
    @IBAction func filterSaveBtnAction(_ sender: Any) {
        filterDelegate?.filter(with: selectedFilterDict)
        self.dismiss(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width - 20, height: 40)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FilterCollectionViewHeader", for: indexPath) as! FilterCollectionViewHeader
            headerView.titleLabel.text = filterSections[indexPath.section]
            return headerView
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCollectionViewCell.reuseIdentifier, for: indexPath as IndexPath) as! FilterCollectionViewCell
       
        let value : String?
        let section = filterSections[indexPath.section]
        if section == "From Account" {
            value = fromAccounts[indexPath.row]
        } else if section == "To Account" {
            value = toAccounts[indexPath.row]
        } else if section == "Transaction Status" {
            value = bools[indexPath.row]
        } else if section == "Date" {
            value = dates[indexPath.row]
        } else if section == "Month" {
            value = months[indexPath.row]
        } else {
            value = years[indexPath.row]
        }
        
        let arr = selectedFilterDict[section] ?? []
       
        if arr.contains(value?.uppercased() ?? "") {
            cell.backGroundView.backgroundColor = .systemMint
        } else {
            cell.backGroundView.backgroundColor = UIColor(hex: "#F4F4F4")
        }
        
        cell.setData(name: value?.camelCase() ?? "")
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return filterSections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let section = filterSections[section]
        
        if section == "From Account" {
            return fromAccounts.count
        } else if section == "To Account" {
            return toAccounts.count
        } else if section == "Transaction Status" {
            return bools.count
        } else if section == "Date" {
            return dates.count
        } else if section == "Month" {
            return months.count
        } else {
            return years.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath) as?  FilterCollectionViewCell {
            
            let value : String?
            let section = filterSections[indexPath.section]
            if section == "From Account" {
                value = fromAccounts[indexPath.row]
            } else if section == "To Account" {
                value = toAccounts[indexPath.row]
            } else if section == "Transaction Status" {
                value = bools[indexPath.row]
            } else if section == "Date" {
                value = dates[indexPath.row]
            } else if section == "Month" {
                value = months[indexPath.row]
            } else {
                value = years[indexPath.row]
            }
            
            guard let finalValue = value else {
                return
            }
            var arr = selectedFilterDict[section] ?? []
            
            if !arr.contains(finalValue.uppercased()) {
                arr.append(finalValue.uppercased())
                cell.backGroundView.backgroundColor = .systemMint
            } else {
                arr.remove(finalValue.uppercased())
                cell.backGroundView.backgroundColor = .systemGray6
            }
            selectedFilterDict[section] = arr
        }
    }
    
}

extension Array where Element: Equatable {
   mutating func remove(_ element: Element) {
      self = filter { $0 != element }
   }
}
extension String {
    func capitalizeFirstLetter() -> String {
        guard !isEmpty else { return self }
        let firstLetter = String(prefix(1)).capitalized
        let remainingLetters = String(dropFirst()).lowercased()
        return firstLetter + remainingLetters
    }
    func camelCase() -> String {
        let words = self.components(separatedBy: " ")
        let capitalizedWords = words.map { $0.capitalizeFirstLetter() }
        return capitalizedWords.joined(separator: " ")
    }
}
