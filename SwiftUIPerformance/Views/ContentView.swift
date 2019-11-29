//
//  ContentView.swift
//  SwiftUIPerformance
//
//  Created by Alexey Naumov on 29.11.2019.
//  Copyright © 2019 Alexey Naumov. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    private let gridSize = DiscretePair(dx: 30, dy: 30)
    private let updateTimer = Timer.timer(frequency: 60)
    @State private var updateTrigger = false
    
    var body: some View {
        VStack {
            FPSView(update: $updateTrigger).equatable()
            testStaticContent
        }
        .onReceive(self.updateTimer) { elapsed in
            self.updateTrigger.toggle()
        }
    }
    
    var testStaticContent: some View {
        StaticGridView<TextElementView>(size: gridSize)
    }
    
    var testToggledContentWithConditionalView: some View {
        Group {
            if updateTrigger {
                StaticGridView<TextElementView>(size: gridSize)
            } else {
                StaticGridView<ImageElementView>(size: gridSize)
            }
        }
    }
    
    var testToggledContentWithAnyView: some View {
        if updateTrigger {
            return AnyView(StaticGridView<TextElementView>(size: gridSize))
        } else {
            return AnyView(StaticGridView<ImageElementView>(size: gridSize))
        }
    }
    
    var testComparisonWithTypedView: some View {
        DynamicTypedGridView<TextElementView>(size: gridSize, update: $updateTrigger)
    }
    
    var testComparisonWithTypeErasedView: some View {
        DynamicTypeErasedGridView<TextElementView>(size: gridSize, update: $updateTrigger)
    }
}
