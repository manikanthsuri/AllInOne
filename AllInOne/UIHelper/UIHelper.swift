//
//  UIHelper.swift
//  AllInOne
//
//  Created by Suri Manikanth on 01/12/23.
//

import Foundation
import UIKit

class UIHelper {
    
    static func applyTileLayerEffects(to views: [UIView]) {
        for view in views {
            view.layer.shadowColor = UIColor.red.cgColor
            view.layer.shadowOpacity = 0.4
            view.layer.shadowOffset = CGSize(width: 2, height: 2)
            view.layer.shadowRadius = 5
            view.layer.borderWidth = 2
            view.layer.borderColor = UIColor.white.cgColor
            view.layer.cornerRadius = 10
            view.layer.masksToBounds = true
        }
    }
    static func applyBorderToView(to views: [UIView]) {
        for view in views {
            view.layer.borderWidth = 2
            view.layer.borderColor = UIColor.systemMint.cgColor
            view.layer.cornerRadius = 5
        }
    }
    
    static func setDropDownTextField(to textField: DropDown, options: [String]) {
        textField.isSearchEnable = false
        textField.optionArray = options
        textField.checkMarkEnabled = false
    }
}
