//
//  ChatView.swift
//  SideMenuSwiftUI
//
//  Created by Zeeshan Suleman on 04/03/2023.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = BasicPieChartViewModel()
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
            }
            GeometryReader { proxy in
                Group {
                    ZStack(alignment: Alignment.topLeading) {
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
                            DYFractionChartInfoView(title: "", data: viewModel.data, selectedSlice: $viewModel.selectedSlice) { (value) -> String in
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
            DYFractionChartLegendView(data: viewModel.data, font: font, textColor: .white)
                .frame(width: 300, height: calculateLegendHeight())
                .padding(10)
                .infoBoxBackground()
                .padding(10)
        }.onAppear {
            withAnimation(.spring()) {
                self.pieScale = CGSize(width: 1, height: 1)
            }
        }
    }
    func calculateLegendHeight() -> CGFloat {
        let rows = viewModel.data.count / 3 + (viewModel.data.count % 3 == 0 ? 0 : 1)
        let rowHeight = 30 // Adjust this based on your LegendItem height
        let spacing = 10 // Adjust this based on your LegendItem spacing
        return CGFloat(rows) * CGFloat(rowHeight) + CGFloat((rows - 1) * spacing) + 20 // Adjust for additional padding
    }
    func sliceLabelView(fraction: DYPieFraction, data: [DYPieFraction])->some View {
        Group {
            if fraction.value / data.reduce(0, { $0 + $1.value}) >= 0.11  {
                VStack {
                    Text(fraction.title).font(font).bold().lineLimit(2).frame(maxWidth: 185)
                    Text(fraction.value.toCurrencyString()).font(font).bold()
                }
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
        self.background(RoundedRectangle(cornerRadius: 10, style: .continuous).fill(LinearGradient(gradient: Gradient(colors: [Color.red, Color.white.opacity(0.4)]), startPoint: .topLeading, endPoint: .bottomTrailing)).shadow(radius: 5))
    }
}

final class BasicPieChartViewModel: ObservableObject {
    
    @Published var data: [DYPieFraction]
    @Published var selectedSlice: DYPieFraction?
    
    init() {
        self.data = DYPieFraction.exampleData()
        
    }
    
}
