//
//  DYChartLegendView.swift
//  
//
//  Created by Dominik Butz on 25/3/2021.
//

import SwiftUI

/// DYFractionChartLegendView. A legend view showing all DYChartFractions colors and titles. can be used in conjunction with DYPieChartView or potentially other visualizations of fractions.
public struct DYFractionChartLegendView: View {
 var data: [DYPieFraction]
    var verticalAlignment: Bool = true
    var font: Font
    var textColor: Color
    
    public init(data:  [DYPieFraction], font: Font, textColor: Color) {
        self.data = data
        self.font = font
        self.textColor = textColor
    }
    
    let itemsPerRow = 3
    public var body: some View {
        GeometryReader { geometry in
            VStack {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(data.chunked(into: itemsPerRow),id: \.self) { rowItems in
                        HStack{
                            ForEach(rowItems,id: \.self) { fraction in
                                self.content(fraction: fraction)
                            }
                        }
                    }
                }.padding()
            }
        }
    }
    
    func calculateLegendHeight() -> CGFloat {
        let rows = data.count / itemsPerRow + (data.count % itemsPerRow == 0 ? 0 : 1)
        let rowHeight = 30 // Adjust this based on your LegendItem height
        let spacing = 10 // Adjust this based on your LegendItem spacing
        return CGFloat(rows) * CGFloat(rowHeight) + CGFloat((rows - 1) * spacing) + 20 // Adjust for additional padding
    }
    
   private func content(fraction: DYPieFraction)->some View {
        Group {
            Circle().fill(fraction.color).frame(width: 30, height: 30)
            Text(fraction.title).font(self.font).foregroundColor(self.textColor)
        }
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        DYFractionChartLegendView(data: DYPieFraction.exampleData(), font: Font.caption, textColor: .primary)
            .frame(width: 250, height: 250)
    }
}
