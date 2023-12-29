//
//  RecordModel.swift
//  AllInOne
//
//  Created by Suri Manikanth on 01/12/23.
//
import Foundation

public struct RecordModel: Equatable, Codable, Hashable{

    public var amount: Decimal
    public var fromAccount: String
    public var toAccount: String
    public var reason: String?
    public var date: String
    public var month: String
    public var year: String
    public var sent: Bool
    public var createdOn: String?
    public var uniqueId: String?
   
    public init(
        amount: Decimal,
        fromAccount: String,
        toAccount: String,
        reason:String? = "",
        date: String,
        month:String,
        year:String,
        sent: Bool,
        createdOn:String? = nil,
        uniqueId:String? = nil) {

        self.amount = amount
        self.fromAccount = fromAccount
        self.toAccount = toAccount
        self.date = date
        self.reason = reason
        self.month = month
        self.year = year
        self.sent = sent
        self.createdOn = createdOn
        self.uniqueId = uniqueId
    }

}
