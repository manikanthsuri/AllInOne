//
//  ExpensesView.swift
//  SideMenuSwiftUI
//

import SwiftUI

struct ExpensesView: View {
    
    @Binding var presentSideMenu: Bool
    @State private var isSheetPresented = false
    
    var body: some View {
        VStack(){
            HStack(alignment: .top,spacing: 0) {
                Button(action: {
                    presentSideMenu.toggle()
                }) {
                    Image("menu").resizable()
                        .frame(width: 36, height: 36)
                        .background(Color(UIColor(hex: "00C7BE")))
                      
                }
                Text("Expense List")
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 40)
                    .background(Color(UIColor(hex: "00C7BE")))
                    .foregroundColor(.white)
                    .font(.system(size: 26, weight: .bold))
                    
                Button(action: {
                    isSheetPresented.toggle()
                }) {
                    Image("ic_add_expense").resizable()
                        .frame(width: 36, height: 36)
                        .background(Color(UIColor(hex: "00C7BE")))
                }
                Spacer(minLength: 10)
            }
            .fullScreenCover(isPresented: $isSheetPresented, content: {
                AddRecordVCWrapper()
                    .background(Color(UIColor(hex: "00C7BE")))
            })
            Spacer()
            ExpenseListVCWrapper()
        }
        .background(Color(UIColor(hex: "00C7BE")))
    }
}



extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
