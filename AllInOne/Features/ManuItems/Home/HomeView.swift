//
//  ChatView.swift
//  SideMenuSwiftUI
//
//  Created by Zeeshan Suleman on 04/03/2023.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    @Namespace var animationNamespace
    @State private var pieScale:CGSize = .zero
    @Binding var presentSideMenu: Bool
    @State private var isFilterVisible = false
    @State private var isAddrecordVisible = false
    @State private var dataFromFilterView: String?
    @State private var filterUpdated = false
    var body: some View {
        VStack{
            HStack{
                Button{
                    presentSideMenu.toggle()
                } label: {
                    Image("menu")
                        .resizable()
                        .frame(width: 36, height: 36)
                }
                Spacer()
                Text(filterUpdated ? "\(viewModel.id ?? "")" : DataHelper.getMonthYearString())
                    .font(.title)
                    .foregroundColor(.white)
                    .bold()
                Spacer()
                Button{
                    isFilterVisible.toggle()
                } label: {
                    Image("filter")
                        .resizable()
                        .frame(width: 28, height: 28)
                }
                .padding()
                .sheet(isPresented: $isFilterVisible) {
                    VStack {
                        filterView(isPresented: $isFilterVisible, onDataReceived: { data in
                            viewModel.updateDetails(id: data)
                            filterUpdated.toggle()
                        })
                        .presentationDetents([.height(200)]) // here!
                    }
                    .frame(width: 400, height: 200)
                    .background(
                        LinearGradient(
                            gradient: Gradient(
                                colors: [.white,
                                         .mint.opacity(0.4),
                                         .white,
                                         .mint.opacity(0.4),
                                         .white,
                                         .mint.opacity(0.4),
                                         .white,]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing)
                    )
                    
                }
            }
            .background(.mint)
            GeometryReader { proxy in
                Group {
                    ZStack(alignment: Alignment.topLeading) {
                        if proxy.size.height > proxy.size.width {
                            HStack{
                                Spacer()
                                Button{
                                    isAddrecordVisible.toggle()
                                } label: {
                                    Image("ic_add_expense")
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                }
                                .padding()
                                .sheet(isPresented: $isAddrecordVisible) {
                                    AddRecordVCWrapper()
                                }
                            }
                            VStack {
                                self.content()
                            }
                        } else {
                            HStack(alignment: .center) {
                                self.content()
                            }
                        }
                        if self.viewModel.selectedSlice != nil {
                            DYFractionChartInfoView(
                                title: "",
                                data: viewModel.data,
                                total: viewModel.salary ?? 0.0,
                                selectedSlice: $viewModel.selectedSlice) { (value) -> String in
                                    value.toCurrencyString()
                                }.padding(5).infoBoxBackground()
                                .padding(infoBoxPadding)
                        }
                    }
                }
            }
        }.background(
            LinearGradient(
                gradient: Gradient(
                    colors: [Color.white.opacity(0.9),Color.mint.opacity(0.5)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
        )
    }
    func content()->some View {
        Group {
            Spacer(minLength: 50)
            DYPieChartView(data: viewModel.data, selectedSlice: $viewModel.selectedSlice, sliceLabelView: {fraction in
                self.sliceLabelView(fraction: fraction, data: viewModel.data)
            }, animationNamespace: animationNamespace)
            .background(Circle().fill(Color.defaultPlotAreaBackgroundColor)
                .shadow(radius: 8))
            .scaleEffect(self.pieScale)
            .padding(10)
            Spacer()
            VStack(alignment: .leading, spacing: 5) {
                HStack(alignment: .center, spacing: 40) {
                    Text(viewModel.salaryText()).font(.headline).bold()
                    Text(viewModel.expensesText()).font(.headline).bold()
                }
                HStack(alignment: .center, spacing: 40) {
                    Text(viewModel.balanceText()).font(.headline).bold()
                    Text(viewModel.paidUnPaidText()).font(.headline).bold()
                }
            }
            .padding()
            Spacer()
        }.onAppear {
            withAnimation(.spring()) {
                self.pieScale = CGSize(width: 1, height: 1)
            }
        }
    }
    
    func sliceLabelView(fraction: DYPieFraction, data: [DYPieFraction])->some View {
        Group {
            if fraction.value / (viewModel.salary ?? 0.0) >= 0.11  {
                VStack {
                    Text(fraction.title).font(font).bold().lineLimit(2).frame(maxWidth: 185)
                    Text(fraction.value.toCurrencyString()).font(font).bold()
                }.foregroundColor(.white)
            }
        }
    }
    
    var font: Font {
        var font: Font?
#if os(iOS)
        font = UIDevice.current.userInterfaceIdiom == .phone ? .caption : .callout
#else
        font = .body
#endif
        return font!
    }
    
    var infoBoxPadding: CGFloat {
#if os(iOS)
        return UIDevice.current.userInterfaceIdiom == .pad ? 20 : 10
#else
        return 20
#endif
    }
    
}

extension View {
    
    func infoBoxBackground()->some View {
        self.background(
            RoundedRectangle(
                cornerRadius: 10,
                style: .continuous)
            .fill(
                LinearGradient(
                    gradient: Gradient(
                        colors: [Color.mint, Color.white.opacity(0.9)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing)
            )
            .shadow(radius: 5))
    }
}
