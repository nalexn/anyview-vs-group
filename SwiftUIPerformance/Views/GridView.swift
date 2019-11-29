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

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            ForEach(self.size.dy.indices) { row in
                HStack(alignment: .center, spacing: 0) {
                    ForEach(self.size.dx.indices) { column in
                        Cell(indexPath: IndexPath(row: row, column: column))
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
                        Cell(indexPath: IndexPath(row: row, column: column))
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
                        AnyView(Cell(indexPath: IndexPath(row: row, column: column)))
                    })
                })
            })
        })
    }
}
