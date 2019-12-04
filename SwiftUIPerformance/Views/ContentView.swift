//
//  ContentView.swift
//  SwiftUIPerformance
//
//  Created by Alexey Naumov on 29.11.2019.
//  Copyright © 2019 Alexey Naumov. All rights reserved.
//

import SwiftUI

struct Constants {
    static let largeGridSize = DiscretePair(dx: 40, dy: 40)
    static let smallGridSize = DiscretePair(dx: 15, dy: 15)
    static let toggledElementIndexPath = IndexPath(row: 5, column: 5)
    static let refreshFrequency: Int = 60
}

struct ContentView: View {
    
    private let updateTimer = Timer.timer(frequency: Constants.refreshFrequency)
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
        #elseif TOGGLE_CONTENT_CONDITIONAL
        return testToggleStaticContentConditionalView
        #elseif TOGGLE_CONTENT_ANYVIEW
        return testToggleStaticContentAnyView
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
        return GridView<TextElementView>(size: Constants.largeGridSize, update: update)
    }
    
    var testToggleStaticContentConditionalView: some View {
        let update = Binding<Bool>(get: { true }, set: { _ in })
        let size = Constants.smallGridSize
        return Group {
            if updateTrigger {
                GridView<TextElementView>(size: size, update: update)
            } else {
                GridView<ImageElementView>(size: size, update: update)
            }
        }
    }
    
    var testToggleStaticContentAnyView: some View {
        let update = Binding<Bool>(get: { true }, set: { _ in })
        let size = Constants.smallGridSize
        if updateTrigger {
            return AnyView(GridView<TextElementView>(size: size, update: update))
        } else {
            return AnyView(GridView<ImageElementView>(size: size, update: update))
        }
    }
    
    var testRegularViewUpdate: some View {
        GridView<ToggledElementView>(size: Constants.largeGridSize, update: $updateTrigger)
    }
    
    var testEquatableViewUpdate: some View {
        GridView<ToggledElementView>(size: Constants.largeGridSize, update: $updateTrigger)
    }
    
    var testTypeErasedViewUpdate: some View {
        GridView<TypeErasedToggledElementView>(size: Constants.largeGridSize, update: $updateTrigger)
    }
}
