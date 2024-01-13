//
//  File.swift
//  AllInOne
//
//  Created by Suri.Manikanth on 12/01/24.
//

import Foundation
import UIKit

extension AddRecordVC: UICollectionViewDelegate, 
                        UICollectionViewDataSource,
                        UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCollectionViewCell.reuseIdentifier, for: indexPath as IndexPath) as! FilterCollectionViewCell
        
        let value : String?
        
        if selectedFiled == "From Account" {
            value = fromAccounts[indexPath.row]
        } else if selectedFiled == "To Account" {
            value = toAccounts[indexPath.row]
        } else if selectedFiled == "Transaction Status" {
            value = bools[indexPath.row]
        } else if selectedFiled == "Date" {
            value = dates[indexPath.row]
        } else if selectedFiled == "Month" {
            value = months[indexPath.row]
        } else {
            value = years[indexPath.row]
        }

        cell.setData(name: value ?? "")
        cell.backGroundView.backgroundColor = .white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if selectedFiled == "From Account" {
            return fromAccounts.count
        } else if selectedFiled == "To Account" {
            return toAccounts.count
        } else if selectedFiled == "Transaction Status" {
            return bools.count
        } else if selectedFiled == "Date" {
            return dates.count
        } else if selectedFiled == "Month" {
            return months.count
        } else {
            return years.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if selectedFiled == "From Account" {
            self.fromAccountTF.text = fromAccounts[indexPath.row]
        } else if selectedFiled == "To Account" {
            self.toAccountTF.text = toAccounts[indexPath.row]
        } else if selectedFiled == "Transaction Status" {
            self.toAccountTF.text = bools[indexPath.row]
        } else if selectedFiled == "Date" {
            self.dateTF.text = dates[indexPath.row]
        } else if selectedFiled == "Month" {
            self.monthTF.text = months[indexPath.row]
        } else {
            self.yearTF.text = years[indexPath.row]
        }
        optionsView.isHidden = true
    }
}
