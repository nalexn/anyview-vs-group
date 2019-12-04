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
        #elseif REGULAR_VIEW_UPDATE
        return testRegularViewUpdate
        #elseif TYPE_ERASED_VIEW_UPDATE
        return testTypeErasedViewUpdate
        #elseif EQUATABLE_VIEW_UPDATE
        return testEquatableViewUpdate
        #endif
    }
    
    var testStaticContent: some View {
        let update = Binding<Bool>(get: { true }, set: { _ in })
        return GridView<TextElementView>(size: gridSize, update: update)
    }
    
    var testRegularViewUpdate: some View {
        GridView<ToggledElementView>(size: gridSize, update: $updateTrigger)
    }
    
    var testTypeErasedViewUpdate: some View {
        GridView<TypeErasedToggledElementView>(size: gridSize, update: $updateTrigger)
    }
    
    var testEquatableViewUpdate: some View {
        GridView<ToggledElementView>(size: gridSize, update: $updateTrigger)
    }
}
