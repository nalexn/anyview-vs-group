//
//  GridView.swift
//  SwiftUIPerformance
//
//  Created by Alexey Naumov on 29.11.2019.
//  Copyright © 2019 Alexey Naumov. All rights reserved.
//

import SwiftUI

// MARK: - StaticGridView

struct StaticGridView<Cell>: View where Cell: GridElementView {

    let size: DiscretePair
    @State private var update = false

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            ForEach(self.size.dy.indices) { row in
                HStack(alignment: .center, spacing: 0) {
                    ForEach(self.size.dx.indices) { column in
                        Cell(indexPath: IndexPath(row: row, column: column),
                             update: self.$update)
                    }
                }
            }
        }
    }
}

// MARK: - DynamicTypedGridView

struct DynamicTypedGridView<Cell>: View where Cell: GridElementView {

    let size: DiscretePair
    let update: Binding<Bool>

    var body: some View {
        _ = update.wrappedValue
        return VStack(alignment: .center, spacing: 0) {
            ForEach(self.size.dy.indices) { row in
                HStack(alignment: .center, spacing: 0) {
                    ForEach(self.size.dx.indices) { column in
                        Cell(indexPath: IndexPath(row: row, column: column),
                             update: self.update)
                    }
                }
            }
        }
    }
}

// MARK: - OptimizedLayoutGridView

struct ZStackGridView<Cell>: View where Cell: GridElementView {

    let size: DiscretePair
    let update: Binding<Bool>

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                ForEach(self.size.dy.indices) { row in
                    ForEach(self.size.dx.indices) { column in
                        Cell(indexPath: IndexPath(row: row, column: column), update: self.update)
                            .equatable()
                            .alignmentGuide(.leading) { _ in
                                proxy.size.width * (0.5 - (CGFloat(column) + 0.5) / CGFloat(self.size.dx))
                            }
                            .alignmentGuide(.top) { _ in
                                proxy.size.height * (0.5 - (CGFloat(row) + 0.5) / CGFloat(self.size.dy))
                            }
                            .frame(alignment: Alignment(horizontal: .leading, vertical: .top))
                    }
                }
            }
        }
    }
}

// MARK: - DynamicTypeErasedGridView

struct DynamicTypeErasedGridView<Cell>: View where Cell: GridElementView {

    let size: DiscretePair
    let update: Binding<Bool>

    var body: some View {
        _ = update.wrappedValue
        return AnyView(VStack(alignment: .center, spacing: 0) {
            AnyView(ForEach(self.size.dy.indices) { row in
                AnyView(HStack(alignment: .center, spacing: 0) {
                    AnyView(ForEach(self.size.dx.indices) { column in
                        AnyView(Cell(indexPath: IndexPath(row: row, column: column), update: self.update))
                    })
                })
            })
        })
    }
}
