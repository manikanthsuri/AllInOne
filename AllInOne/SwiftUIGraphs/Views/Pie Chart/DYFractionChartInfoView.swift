//
//  DYFractionChartHeaderView.swift
//  
//
//  Created by Dominik Butz on 25/3/2021.
//

import SwiftUI

/// DYFractionChartInfoView. a view that displays details of the selected DYChartFraction. 
public struct DYFractionChartInfoView: View {
    
    let title: String
    let data: [DYPieFraction]
    let total: Double
    @Binding var selectedSlice: DYPieFraction?
    let valueConverter: (Double)->String
    
    public init(
        title: String,
        data: [DYPieFraction],
        total: Double,
        selectedSlice: Binding<DYPieFraction?>,
        valueConverter: @escaping (Double)->String) {
            self.title = title
            self.data = data
            self.total = total
            self._selectedSlice = selectedSlice
            self.valueConverter = valueConverter
            
        }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            if self.title != "" {
                Text(self.title).font(.headline).bold()
            }
            if let fraction = selectedSlice {
                Text(self.valueConverter(fraction.value)).font(.headline).bold()
                Text("\(fraction.value.percentageString(totalValue: total)) In Salary").font(.subheadline).bold()
                if let record = fraction.record {
                    Text("To - \(record.toAccount)").font(.subheadline)
                    Text("Status - \(record.sent ? "Paid" : "Unpaid")").font(.subheadline)
                }
            }
        }
    }
    
    func fractionFor(id: String)->DYPieFraction? {
        return self.data.filter({$0.id == id}).first
    }
}
