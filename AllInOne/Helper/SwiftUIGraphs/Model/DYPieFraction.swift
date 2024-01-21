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
    public var record: RecordModel?
    public var detailFractions:[DYPieFraction]
    
    public init(
        id: String? = UUID().uuidString,
        value: Double,
        color: Color = Color.random(),
        title: String,
        record: RecordModel? = nil,
        detailFractions: [DYPieFraction] = []) {
            self.id = id ?? UUID().uuidString
            self.value = value
            self.color = color
            self.title = title
            self.record = record
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
}
