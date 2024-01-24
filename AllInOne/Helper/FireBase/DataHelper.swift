//
//  File.swift
//  AllInOne
//
//  Created by Suri Manikanth on 13/12/23.
//

import Foundation

enum DataError: Error {
    case notFoundError
}


final class DataHelper {
    
    static let shared = DataHelper()
    
    private init (){}
  
    static func getCurrentDateString() -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy HH:mm a"
        let dateString = dateFormatter.string(from: currentDate)
        return dateString
    }
    
    static func getCurrentDayString() -> String {
       
        let currentDate = Date()
        let calendar = Calendar.current
        let dayComponent = calendar.component(.day, from: currentDate)
        return "\(dayComponent)"
    }
    
    static func getCurrentMonthString() -> String {
        
        let currentDate = Date()
        let calendar = Calendar.current
        let currentMonth = calendar.component(.month, from: currentDate)
        let dateFormatter = DateFormatter()
        let monthName = dateFormatter.monthSymbols[currentMonth - 1]
        
        return monthName
    }
    
   static func getCurrentYearString() -> String {
       
       let currentDate = Date()
       let calendar = Calendar.current
       let currentYear = calendar.component(.year, from: currentDate)
    
       return "\(currentYear)"
    }
    
   static func generate8DigitRandomNumber() -> String {
        let lowerBound = 00000001
        let upperBound = 99999999
        let randomValue = Int(arc4random_uniform(UInt32(upperBound - lowerBound + 1))) + lowerBound
        return String(randomValue)
    }
    
    static func getMonthYearString() -> String {
        let month = getCurrentMonthString()
        let year = getCurrentYearString()
        return "\(month)-\(year)"
    }
    
}
