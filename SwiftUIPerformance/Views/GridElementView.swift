//
//  GridElementView.swift
//  SwiftUIPerformance
//
//  Created by Alexey Naumov on 29.11.2019.
//  Copyright © 2019 Alexey Naumov. All rights reserved.
//

import SwiftUI

protocol GridElementView: View {
    init(indexPath: IndexPath)
}

struct TextElementView: GridElementView {
    
    let indexPath: IndexPath
    
    init(indexPath: IndexPath) {
        self.indexPath = indexPath
    }
    
    var body: some View {
        return Text("$")
            .font(Font.custom("Courier", size: 10))
    }
}
