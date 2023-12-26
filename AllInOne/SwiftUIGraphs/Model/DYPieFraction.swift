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
   
    

}
