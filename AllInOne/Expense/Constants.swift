//
//  Constants.swift
//  AllInOne
//
//  Created by Suri Manikanth on 01/12/23.
//

import Foundation
import SwiftUI
import UIKit


let months = [
    "January", "February", "March", "April",
    "May", "June", "July", "August",
    "September", "October", "November", "December"
]
let dates = (1...31).map { String($0) }
let years = ["2024","2025","2026","2027"]
let bools = ["True","False"]
var fromAccounts = ["BAJAJ FINSERV", "HDFC BANK", "HDFC CREDIT CARD", "ICICI BANK", "ICICI CREDIT CARD", "SBI", "UNION BANK"]
var toAccounts = ["BAJAJ FINSERV", "DMART", "FATHER", "FUEL", "HDFC BANK", "HDFC CREDIT CARD", "ICICI BANK", "ICICI CREDIT CARD", "JIO MART", "LIC", "MILK", "PPF", "POST OFFICE", "RENT", "RESTAURANT", "SHANNU RD", "SBI", "STORE", "UNION BANK", "VEGITABLES"]
var bankAccounts = ["HDFC BANK","ICICI BANK","SBI","UNION BANK"]
var showAutoAdd = false
var sampleRecords = [[String:Any]]()
let colorMapper: [String: Color] = [
    
    "BAJAJ FINSERV": Color(hex: 0x091B3F),
    "HDFC CREDIT CARD": Color(hex: 0x091F3F),
    "ICICI CREDIT CARD": Color(hex: 0x071D3F),
    "SBI": Color(hex: 0x4149E1),
    "UNION BANK": Color(hex: 0x4169E1),
    "ICICI BANK": Color(hex: 0x4179E1),
    "HDFC BANK": Color(hex: 0x4159E1),
    "DMART": Color(hex: 0xFF2020),
    "JIO MART": Color(hex: 0xFF2010),
    "STORE": Color(hex: 0xFF2030),
    "VEGITABLES":Color(hex: 0xFF2040),
    "RESTAURANT": Color(hex: 0xFF2050),
    "FATHER": Color(hex: 0x000080),
    "FUEL": Color(hex: 0xFFBF00),
    "PPF": Color(hex: 0x008000),
    "POST OFFICE": Color(hex: 0x009000),
    "SHANNU RD":Color(hex: 0x007000),
    "RENT":  Color(hex: 0x8B4513),
    "LIC": Color(hex: 0x007900),
    "BALANCE": Color(hex: 0xC197D2)
]

extension Color {
    init(hex: UInt32, alpha: Double = 1.0) {
        let red = Double((hex & 0xFF0000) >> 16) / 255.0
        let green = Double((hex & 0x00FF00) >> 8) / 255.0
        let blue = Double(hex & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue, opacity: alpha)
    }
}
