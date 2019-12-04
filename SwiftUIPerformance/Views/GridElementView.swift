//
//  GridElementView.swift
//  SwiftUIPerformance
//
//  Created by Alexey Naumov on 29.11.2019.
//  Copyright © 2019 Alexey Naumov. All rights reserved.
//

import SwiftUI

protocol GridElementView: View, Equatable {
    init(indexPath: IndexPath, update: Binding<Bool>)
}

struct TextElementView: GridElementView {
    
    let indexPath: IndexPath
    
    init(indexPath: IndexPath, update: Binding<Bool>) {
        self.indexPath = indexPath
    }
    
    var body: some View {
        return Text("$")
            .font(Font.custom("Courier", size: 10))
    }
}

struct ImageElementView: GridElementView {
    
    private static var image = UIColor.white.image(CGSize(width: 6, height: 10))

    let indexPath: IndexPath
    
    init(indexPath: IndexPath, update: Binding<Bool>) {
        self.indexPath = indexPath
    }

    var body: some View {
        Image(uiImage: ImageElementView.image)
            .padding(.zero)
    }
}

struct ToggledElementView: GridElementView {
    
    let indexPath: IndexPath
    let update: Binding<Bool>
    
    init(indexPath: IndexPath, update: Binding<Bool>) {
        self.indexPath = indexPath
        self.update = update
    }
    
    var body: some View {
        Group {
            if update.wrappedValue && indexPath == IndexPath(row: 5, column: 5) {
                ImageElementView(indexPath: indexPath, update: update)
            } else {
                TextElementView(indexPath: indexPath, update: update)
            }
        }
    }
}

struct TypeErasedToggledElementView: GridElementView {
    
    let indexPath: IndexPath
    let update: Binding<Bool>
    
    init(indexPath: IndexPath, update: Binding<Bool>) {
        self.indexPath = indexPath
        self.update = update
    }
    
    var body: some View {
        if update.wrappedValue && indexPath == IndexPath(row: 5, column: 5) {
            return AnyView(ImageElementView(indexPath: indexPath, update: update))
        } else {
            return AnyView(TextElementView(indexPath: indexPath, update: update))
        }
    }
}

func == (lhs: TextElementView, rhs: TextElementView) -> Bool {
    return true
}

func == (lhs: ImageElementView, rhs: ImageElementView) -> Bool {
    return true
}

func == (lhs: ToggledElementView, rhs: ToggledElementView) -> Bool {
    return true
}

func == (lhs: TypeErasedToggledElementView, rhs: TypeErasedToggledElementView) -> Bool {
    return false
}
