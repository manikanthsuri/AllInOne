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
var filterSections = ["From Account", "To Account", "Transaction Status", "Date", "Month", "Year"]
var showAutoAdd = false
var allowSentItemDelete = false
var allowSentItemEdit = false
var sampleRecords = [[String:Any]]()

let colorMapper: [String: Color] = [
    "BAJAJ FINSERV": Color(hex: 0x091B3F),         // Midnight Blue
    "HDFC CREDIT CARD": Color(hex: 0x091F3F),      // Dark Jungle Green
    "ICICI CREDIT CARD": Color(hex: 0x071D3F),     // Prussian Blue
    "SBI": Color(hex: 0x4149E1),                   // Royal Blue
    "UNION BANK": Color(hex: 0x4169E1),             // Steel Blue
    "ICICI BANK": Color(hex: 0x4179E1),             // Dodger Blue
    "HDFC BANK": Color(hex: 0x4159E1),             // Sapphire Blue
    "DMART": Color(hex: 0xFF2020),                 // Red
    "JIO MART": Color(hex: 0xFF2010),              // Orange Red
    "STORE": Color(hex: 0xFF2030),                 // Coral Red
    "VEGITABLES": Color(hex: 0xFF2040),            // Salmon Red
    "RESTAURANT": Color(hex: 0xFF2050),            // Indian Red
    "FATHER": Color(hex: 0x000080),                // Navy Blue
    "FUEL": Color(hex: 0xFFBF00),                  // Amber
    "PPF": Color(hex: 0x008000),                   // Green
    "POST OFFICE": Color(hex: 0x009000),           // Green (a different shade)
    "SHANNU RD": Color(hex: 0x007000),             // Dark Green
    "RENT": Color(hex: 0x8B4513),                  // Saddle Brown
    "LIC": Color(hex: 0x007900),                   // British Racing Green
    "BALANCE": Color(hex: 0xC197D2),               // Thistle
    "CASH": Color(hex: 0xFF5733),                  // Dark Orange
    "WITHDRAWN": Color(hex: 0xD35400),             // Pumpkin
    "ENTERTAINMENT": Color(hex: 0xC0392B),        // Alizarin
    "HOSPITAL": Color(hex: 0xE74C3C),              // Light Red
    "MOVIE": Color(hex: 0x884EA0),                 // Studio
    "PAYTM": Color(hex: 0xE67E22),                 // Carrot
    "PHONE PAY": Color(hex: 0x3498DB),             // Belize Hole
    "RECHARGE": Color(hex: 0x9B59B6),              // Amethyst
    "TRAVEL": Color(hex: 0x2980B9),                // Belize Hole
    "VASU ACCOUNT": Color(hex: 0x2E86C1)           // Light Navy Blue
]
extension Color {
    init(hex: UInt32, alpha: Double = 1.0) {
        let red = Double((hex & 0xFF0000) >> 16) / 255.0
        let green = Double((hex & 0x00FF00) >> 8) / 255.0
        let blue = Double(hex & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue, opacity: alpha)
    }
}
