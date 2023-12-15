//
//  iActivityIndicator.swift
//  iActivityIndicator
//
//  Created by Seyed Mojtaba Hosseini Zeidabadi on 9/27/20.
//  Copyright © 2020 Chenzook. All rights reserved.
//
//  StackOverflow: https://stackoverflow.com/story/mojtabahosseini
//  Linkedin: https://linkedin.com/in/MojtabaHosseini
//  GitHub: https://github.com/MojtabaHs
//

import SwiftUI

public struct iActivityIndicator: View {

    @State var animate: Bool = false
    private let style: AStyle

    public var body: some View {
        Group {
            switch style {
            
            case let .rotatingShapes(count, size, content):
                RotatingShapes(
                    animate: $animate,
                    count: count,
                    size: size,
                    content: { content.frame(width: size, height: size) }
                )
            case let .rowOfShapes(count, spacing, scaleRange, opacityRange, content):
                RowOfShapes(
                    animate: $animate,
                    count: count,
                    spacing: spacing,
                    scaleRange: scaleRange,
                    opacityRange: opacityRange,
                    content: { content }
                )
            }
        }
            .onAppear { animate = true }
            .onDisappear { animate = false }
            .aspectRatio(contentMode: .fit)
    }

    public init(style: AStyle = .rotatingShapes()) {
        self.style = style
    }
}

public enum AStyle {
  
    case rotatingShapes(count: UInt = 6, size: CGFloat = 10, content: AnyView = AnyView(Circle()))
    case rowOfShapes(count: UInt = 5,
                     spacing: CGFloat = 8,
                     scaleRange: ClosedRange<Double> = (0.75...1),
                     opacityRange: ClosedRange<Double> = (0.25...1),
                     content: AnyView = AnyView(Circle()))

}

