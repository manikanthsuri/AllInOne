//
//  FavoriteView.swift
//  SideMenuSwiftUI
//
//  Created by Zeeshan Suleman on 04/03/2023.
//

import SwiftUI

struct AgeDiff: View {
    
    @Binding var presentSideMenu: Bool
    
    var body: some View {
        VStack{
            HStack{
                Button{
                    presentSideMenu.toggle()
                } label: {
                    Image("menu")
                        .resizable()
                        .frame(width: 32, height: 32)
                }
                Spacer()
            }.foregroundColor(.pink)
            
            Spacer()
            Text("Age Diff")
            Spacer()
        }
        .padding(.horizontal, 24)
    }
}