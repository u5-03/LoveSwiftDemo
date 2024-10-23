//
//  CustomHStack.swift
//  LoveSwift
//
//  Created by Yugo Sugiyama on 2024/10/24.
//

import SwiftUI

struct CustomHStack: Layout {

    var spacing: CGFloat

    init(spacing: CGFloat = 8) {
        self.spacing = spacing
    }

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        var totalWidth: CGFloat = 0
        var maxHeight: CGFloat = 0

        for subview in subviews {
            let size = subview.sizeThatFits(ProposedViewSize(width: nil, height: proposal.height))
            totalWidth += size.width
            maxHeight = max(maxHeight, size.height)
        }

        totalWidth += CGFloat(subviews.count - 1) * spacing

        return CGSize(width: totalWidth, height: maxHeight)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var xOffset: CGFloat = bounds.minX

        for subview in subviews {
            let size = subview.sizeThatFits(ProposedViewSize(width: nil, height: bounds.height))
            let yOffset = (bounds.height - size.height) / 2
            let subviewSize = subview.sizeThatFits(.unspecified)
            subview.place(
                at: CGPoint(
                    x: xOffset,
                    y: bounds.minY + yOffset),
                proposal: ProposedViewSize(width: subviewSize.width, height: subviewSize.height) )
            xOffset += size.width + spacing
        }
    }
}

#Preview {
    CustomHStack(spacing: 30) {
        Text("Hello")
            .padding()
            .background(Color.red)
        Text("World")
            .padding()
            .background(Color.blue)
        Text("!")
            .padding()
            .background(Color.green)
    }
    .padding()
    .background(.black)
}
