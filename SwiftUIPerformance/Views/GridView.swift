//
//  GridView.swift
//  SwiftUIPerformance
//
//  Created by Alexey Naumov on 29.11.2019.
//  Copyright © 2019 Alexey Naumov. All rights reserved.
//

import SwiftUI

struct GridView<Cell>: View where Cell: GridElementView {

    let size: DiscretePair
    let update: Binding<Bool>

    var body: some View {
        return GeometryReader { proxy in
            ZStack {
                ForEach(self.size.dy.indices) { row in
                    ForEach(self.size.dx.indices) { column in
                        self.cell(indexPath: IndexPath(row: row, column: column), size: proxy.size)
                    }
                }
            }
        }
    }
    
    private func cell(indexPath: IndexPath, size: CGSize) -> some View {
        let alignment = AlignmentModifier(
            dimensions: self.size, indexPath: indexPath, size: size)
        #if EQUATABLE_VIEW_UPDATE
        return Cell(indexPath: indexPath, update: self.update)
            .equatable()
            .modifier(alignment)
        #elseif TYPE_ERASED_VIEW_UPDATE
        return AnyView(Cell(indexPath: indexPath, update: self.update))
            .modifier(alignment)
        #else
        return Cell(indexPath: indexPath, update: self.update)
            .modifier(alignment)
        #endif
    }
}

private struct AlignmentModifier: ViewModifier {
    
    let dimensions: DiscretePair
    let indexPath: IndexPath
    let size: CGSize
    
    func body(content: Content) -> some View {
        content
            .alignmentGuide(.leading) { _ in
                self.size.width * (0.5 - (CGFloat(self.indexPath.section) + 0.5)
                    / CGFloat(self.dimensions.dx))
            }
            .alignmentGuide(.top) { _ in
                self.size.height * (0.5 - (CGFloat(self.indexPath.row) + 0.5)
                    / CGFloat(self.dimensions.dy))
            }
            .frame(alignment: Alignment(horizontal: .leading, vertical: .top))
    }
}
