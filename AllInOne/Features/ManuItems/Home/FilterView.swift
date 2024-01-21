//
//  FilterVIew.swift
//  AllInOne
//
//  Created by Suri Mani kanth on 01/01/24.
//

import Foundation
import SwiftUI

struct filterView: View {
    
    @State private var selectedMonth = 0
    @State private var selectedYear = 0
    @Binding var isPresented: Bool
    var onDataReceived: (String) -> Void
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Picker("Select an option", selection: $selectedMonth) {
                    ForEach(months.indices, id: \.self) { index in
                        Text(months[index]).tag(index)
                    }
                }
                .padding(6)
                .background(Color(hex: 0xFFBF00))
                .cornerRadius(10)
                .pickerStyle(MenuPickerStyle())
                
                Picker("Select an option", selection: $selectedYear) {
                    ForEach(years.indices, id: \.self) { index in
                        Text(years[index]).tag(index)
                    }
                }
                .padding(6)
                .background(Color(hex: 0xFFBF00))
                .cornerRadius(10)
                .pickerStyle(MenuPickerStyle())
            }
            .frame(height: 35)
            .padding(20)
            
            Button("Apply Filter") {
                onDataReceived("\(months[selectedMonth])-\(years[selectedYear])")
                isPresented.toggle()
            }
            .padding(10)
            .foregroundColor(.white)
            .background(.blue)
            .cornerRadius(20)
            
        }
    }
}
