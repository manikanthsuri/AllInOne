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
                Text(DataHelper.getMonthYearString())
                    .font( .title)
                    .foregroundColor(Color(hex: 0xAF52DE))
                    .bold()
                Spacer()
                // For filter
                //                Button{
                //                    presentSideMenu.toggle()
                //                } label: {
                //                    Image("")
                //                        .resizable()
                //                        .frame(width: 32, height: 32)
                //                }
            }
            .background(.mint)
            
            GeometryReader { proxy in
                Group {
                    ZStack(alignment: Alignment.top) {
                        if proxy.size.height > proxy.size.width {
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
        }
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
