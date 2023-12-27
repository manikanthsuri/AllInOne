//
//  Constants.swift
//  AllInOne
//
//  Created by Suri Manikanth on 01/12/23.
//

import Foundation
import UIKit


let months = [
    "January", "February", "March", "April",
    "May", "June", "July", "August",
    "September", "October", "November", "December"
]
let dates = (1...31).map { String($0) }
let years = ["2023","2024","2025","2026"]
let bools = ["True","False"]
let fromAccounts = ["BAJAJ FINSERV", "HDFC BANK", "HDFC CREDIT CARD", "ICICI BANK", "ICICI CREDIT CARD", "SBI", "UNION BANK"]
let toAccounts = ["BAJAJ FINSERV", "DMART", "FATHER", "FUEL", "HDFC BANK", "HDFC CREDIT CARD", "ICICI", "ICICI CREDIT CARD", "JIO MART", "PPF", "POST OFFICE", "RENT", "SHANNU RD", "SBI", "STORE", "UNION BANK", "VEGITABLES"]

enum ExpenseColor {
    
    case BajajFinserv
    case Dmart
    case Father
    case Fuel
    case HdfcBank
    case HdfcCreditCard
    case Icici
    case IciciCreditCard
    case JioMart
    case Ppf
    case PostOffice
    case Rent
    case ShannuRd
    case Sbi
    case Store
    case UnionBank
    case Vegetables
    
    var uiColor: UIColor {
        switch self {
        case .BajajFinserv:
            return UIColor(hex: 0xFF5733)
        case .Dmart:
            return UIColor(hex: 0x4CAF50)
        case .Father:
            return UIColor(hex: 0xFF4081)
        case .Fuel:
            return UIColor(hex: 0x3498DB)
        case .HdfcBank:
            return UIColor(hex: 0xFFD700)
        case .HdfcCreditCard:
            return UIColor(hex: 0x9C27B0)
        case .Icici:
            return UIColor(hex: 0xE91E63)
        case .IciciCreditCard:
            return UIColor(hex: 0x00BCD4)
        case .JioMart:
            return UIColor(hex: 0xFF9800)
        case .Ppf:
            return UIColor(hex: 0x8BC34A)
        case .PostOffice:
            return UIColor(hex: 0x673AB7)
        case .Rent:
            return UIColor(hex: 0xFFC107)
        case .ShannuRd:
            return UIColor(hex: 0x3F51B5)
        case .Sbi:
            return UIColor(hex: 0x795548)
        case .Store:
            return UIColor(hex: 0x009688)
        case .UnionBank:
            return UIColor(hex: 0x009666)
        case .Vegetables:
            return UIColor(hex: 0xFFD790)

        }
    }
}
extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}
