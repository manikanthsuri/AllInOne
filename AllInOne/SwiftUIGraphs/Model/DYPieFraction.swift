//
//  DYChartFraction.swift
//  
//
//  Created by Dominik Butz on 25/3/2021.
//

import Foundation
import SwiftUI

/// DYChartFraction
public struct DYPieFraction: Identifiable, Equatable,Hashable {
    
    public var id: String
    public var value: Double
    public var color: Color
    public var title: String
    public var detailFractions:[DYPieFraction]
    
    public init(id: String? = UUID().uuidString, value: Double, color: Color = Color.random(), title: String, detailFractions: [DYPieFraction]) {
        self.id = id ?? UUID().uuidString
        self.value = value
        self.color = color
        self.title = title
        self.detailFractions = detailFractions
        if detailFractions.count > 0 {
            if self.detailFractions.count == 1 {
                assertionFailure("You can either add none or at least two detail fractions.")
            }
            let valueSum = detailFractions.map{$0.value}.reduce(0,+)
            if valueSum != self.value {
                assertionFailure("The sum of all detail fraction values needs to be equal to the parent chart fraction value!")
            }
        }
    }
    
    /// example data: source https://www.statista.com/statistics/247407/average-annual-consumer-spending-in-the-us-by-type/
    /// - Returns: an array of DYChart Fractions.
    public static func exampleData()->[DYPieFraction] {
        
        let housing = DYPieFraction(value: 20679, title: "1", detailFractions: [])
        let transportation = DYPieFraction(value: 10742, title: "2", detailFractions: [])
        let food = DYPieFraction(value:8169, title: "3", detailFractions: [])
        let insurance = DYPieFraction(value: 7165,  title: "4", detailFractions: [])
        let health = DYPieFraction(value: 5193, title: "5", detailFractions: [])
        let entertainment = DYPieFraction(value: 3050, title: "6", detailFractions: [])
        let cash = DYPieFraction(value: 1995, title: "7", detailFractions: [])
        let other = DYPieFraction(value: 1891, title: "8", detailFractions: [])
        let apparel = DYPieFraction(value: 1883, title: "9", detailFractions: [])
        
        
        return [housing, transportation, food, insurance, health, entertainment, cash, other, apparel]
    }
    

}
