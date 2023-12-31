//
//  SideMenuView.swift
//  DripJobsTeams
//
//  Created by Zeeshan Suleman on 28/02/2023.
//

import SwiftUI

enum SideMenuRowType: Int, CaseIterable{
    case home = 0
    case expenses
    case dairy
    case ageDiff
    case reminder
    
    var title: String{
        switch self {
        case .home:
            return "Home"
        case .expenses:
            return "Expenses"
        case .dairy:
            return "Record Dairy"
        case .ageDiff:
            return "Time Calculator"
        case .reminder:
            return "Remind Me"
        }
    }
    
    var iconName: String{
        switch self {
        case .home:
            return "home"
        case .expenses:
            return "expenses"
        case .dairy:
            return "dairy"
        case .ageDiff:
            return "calculator"
        case .reminder:
            return "remindme"
        }
    }
}

struct SideMenuView: View {
    
    @Binding var selectedSideMenuTab: Int
    @Binding var presentSideMenu: Bool
    
    var body: some View {
        HStack {
            
            ZStack{
                Rectangle()
                    .fill(.white)
                    .frame(width: 270)
                    .shadow(color: .mint, radius: 5, x: 0, y: 3)
                
                VStack(alignment: .leading, spacing: 0) {
                    ProfileImageView()
                        .frame(height: 140)
                        .padding(.bottom, 30)
                    
                    ForEach(SideMenuRowType.allCases, id: \.self){ row in
                        RowView(isSelected: selectedSideMenuTab == row.rawValue, imageName: row.iconName, title: row.title) {
                            selectedSideMenuTab = row.rawValue
                            presentSideMenu.toggle()
                        }
                    }
                    
                    Spacer()
                }
                .padding(.top, 100)
                .frame(width: 270)
                .background(
                    Color.white
                )
            }
            
            
            Spacer()
        }
        .background(.clear)
    }
    
    func ProfileImageView() -> some View{
        VStack(alignment: .center){
            HStack{
                Spacer()
                Image("profile-image")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(.mint, lineWidth: 10)
                    )
                    .cornerRadius(50)
                Spacer()
            }
            
            Text("Manikanth")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.black)
            
            Text("Suri")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.black.opacity(0.5))
        }
    }
    
    func RowView(isSelected: Bool, imageName: String, title: String, hideDivider: Bool = false, action: @escaping (()->())) -> some View{
        Button{
            action()
        } label: {
            VStack(alignment: .leading){
                HStack(spacing: 20){
                    Rectangle()
                        .fill(isSelected ? .red : .white)
                        .frame(width: 5)
                    
                    ZStack{
                        Image(imageName)
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.black)
                            .frame(width: 26, height: 26)
                    }
                    .frame(width: 30, height: 30)
                    Text(title)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.black)
                    Spacer()
                }
            }
        }
        .frame(height: 50)
        .background(
            LinearGradient(
                colors: [isSelected ? .mint : .clear],
                startPoint: .leading,
                endPoint: .trailing)
        )
    }
}

