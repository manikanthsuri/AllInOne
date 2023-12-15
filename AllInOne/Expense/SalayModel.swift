//
//  File.swift
//  AllInOne
//
//  Created by Suri Manikanth on 13/12/23.
//

import Foundation

public struct SalayModel:Codable {

    public var month: String
    public var year: String
    public var salary: String
   
    public init(
        month: String,
        year: String,
        salary:String) {
        self.month = month
        self.year = year
        self.salary = salary
    }

}
