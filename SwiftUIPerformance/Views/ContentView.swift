//
//  ContentView.swift
//  SwiftUIPerformance
//
//  Created by Alexey Naumov on 29.11.2019.
//  Copyright © 2019 Alexey Naumov. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    private let gridSize = DiscretePair(dx: 40, dy: 40)
    private let updateTimer = Timer.timer(frequency: 60)
    @State private var updateTrigger = false
    
    var body: some View {
        VStack {
            FPSView(update: $updateTrigger).equatable()
            testView
        }
        .onReceive(self.updateTimer) { elapsed in
            self.updateTrigger.toggle()
        }
    }
    
    var testView: some View {
        #if STATIC_CONTENT
        return testStaticContent
        #endif
        #if TOGGLE_CONDITIONAL
        return testToggledContentWithConditionalView
        #endif
        #if TOGGLE_ANYVIEW
        return testToggledContentWithAnyView
        #endif
        #if COMPARE_TYPED
        return testComparisonWithTypedView
        #endif
        #if COMPARE_TYPE_ERASED
        return testComparisonWithTypeErasedView
        #endif
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
        ZStackGridView<ToggledElementView>(size: gridSize, update: $updateTrigger)
//        DynamicTypedGridView<TextElementView>(size: gridSize, update: $updateTrigger)
    }
    
    var testComparisonWithTypeErasedView: some View {
        DynamicTypeErasedGridView<TextElementView>(size: gridSize, update: $updateTrigger)
    }
}
