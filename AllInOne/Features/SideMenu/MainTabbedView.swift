//
//  MainTabbedView.swift
//  SideMenuSwiftUI
//
//  Created by Zeeshan Suleman on 04/03/2023.
//

import SwiftUI

struct MainTabbedView: View {
    
    @State var presentSideMenu = false
    @State var selectedSideMenuTab = 0
    
    var body: some View {
        ZStack{
            
            TabView(selection: $selectedSideMenuTab) {
                HomeView(presentSideMenu: $presentSideMenu)
                    .tag(0)
                ExpensesView(presentSideMenu: $presentSideMenu)
                    .tag(1)
                DairyView(presentSideMenu: $presentSideMenu)
                    .tag(2)
                AgeDiff(presentSideMenu: $presentSideMenu)
                    .tag(3)
                TimeDiff(presentSideMenu: $presentSideMenu)
                    .tag(4)
            }
            
            SideMenu(isShowing: $presentSideMenu, content: AnyView(SideMenuView(selectedSideMenuTab: $selectedSideMenuTab, presentSideMenu: $presentSideMenu)))
        }
    }
}
