//
//  File.swift
//  AllInOne
//
//  Created by Suri.Manikanth on 07/01/24.
//

import Foundation
import UIKit

extension ExpenseListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        // Return the size for your section header
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // Return the inset for each section
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FilterCollectionViewHeader", for: indexPath) as! FilterCollectionViewHeader
            headerView.titleLabel.text = sections[indexPath.section]
            return headerView
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCollectionViewCell.reuseIdentifier, for: indexPath as IndexPath) as! FilterCollectionViewCell
        cell.backGroundView.backgroundColor = .systemGray6
        let value : String?
    
        if indexPath.section == 0 {
            value = fromAccounts[indexPath.row]
        } else if indexPath.section == 1 {
            value = toAccounts[indexPath.row]
        } else if indexPath.section == 2 {
            value = bools[indexPath.row]
        } else if indexPath.section == 3 {
            value = dates[indexPath.row]
        } else if indexPath.section == 4 {
            value = months[indexPath.row]
        } else {
            value = years[indexPath.row]
        }
        cell.setData(name: value ?? "")
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        if section == 0 {
            return fromAccounts.count
        } else if section == 1 {
            return toAccounts.count
        } else if section == 2 {
            return bools.count
        } else if section == 3 {
            return dates.count
        } else if section == 4 {
            return months.count
        } else {
            return years.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath) as?  FilterCollectionViewCell {
            
            let value : String?
            let section = sections[indexPath.section]
            if indexPath.section == 0 {
                value = fromAccounts[indexPath.row]
            } else if indexPath.section == 1 {
                value = toAccounts[indexPath.row]
            } else if indexPath.section == 2 {
                value = bools[indexPath.row]
            } else if indexPath.section == 3 {
                value = dates[indexPath.row]
            } else if indexPath.section == 4 {
                value = months[indexPath.row]
            } else {
                value = years[indexPath.row]
            }
            
            guard let finalValue = value else {
                return
            }
            var arr = selectedFilterDict[section] ?? []
            
            if !arr.contains(finalValue) {
                arr.append(finalValue)
                cell.backGroundView.backgroundColor = .systemMint
            } else {
                arr.remove(finalValue)
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
