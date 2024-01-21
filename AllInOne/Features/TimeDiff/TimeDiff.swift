//
//  FavoriteView.swift
//  SideMenuSwiftUI
//
//  Created by Zeeshan Suleman on 04/03/2023.
//

import SwiftUI

struct TimeDiff: View {
    
    @Binding var presentSideMenu: Bool
    
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
                Text("Time Diff")
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 40)
                    .background(Color(UIColor(hex: "00C7BE")))
                    .foregroundColor(.white)
                    .font(.system(size: 26, weight: .bold))
            }
        }
        .background(Color(UIColor(hex: "00C7BE")))
    }
}
