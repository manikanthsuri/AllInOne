//
//  File.swift
//  AllInOne
//
//  Created by Suri Manikanth on 13/12/23.
//

import Foundation

public struct SalayModel:Codable {

    public var createdOn: String
    public var uniqueId: String
    public var salary: String
   
    public init(
        createdOn: String,
        uniqueId: String,
        salary:String) {
        self.createdOn = createdOn
        self.uniqueId = uniqueId
        self.salary = salary
    }

}
