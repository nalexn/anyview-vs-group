//
//  GridView.swift
//  SwiftUIPerformance
//
//  Created by Alexey Naumov on 29.11.2019.
//  Copyright © 2019 Alexey Naumov. All rights reserved.
//

import SwiftUI

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
