//
//  FavoriteView.swift
//  SideMenuSwiftUI
//
//  Created by Zeeshan Suleman on 04/03/2023.
//

import SwiftUI

struct FavoriteView: View {
    
    @Binding var presentSideMenu: Bool
    @State private var isPresentingHome = false

    
    var body: some View {
        VStack{
            HStack{
                Button{
                    presentSideMenu.toggle()
                    isPresentingHome.toggle()
                } label: {
                    Image("menu")
                        .resizable()
                        .frame(width: 32, height: 32)
                }
                Spacer()
                Text("sfsdf")
                    .background(.red)
                    .frame(height: 32)
                Spacer()
            }.foregroundColor(.purple)
            Spacer()
            ExpenseListVCWrapper()
            Spacer()
        }
    }
}
