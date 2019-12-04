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

// MARK: - Static Views

struct TextElementView: GridElementView {
    
    init(indexPath: IndexPath, update: Binding<Bool>) { }
    
    var body: some View {
        Text("$")
            .font(Font.custom("Courier", size: 10))
    }
}

struct ImageElementView: GridElementView {
    
    private static var image = UIColor.white.image(CGSize(width: 6, height: 10))

    init(indexPath: IndexPath, update: Binding<Bool>) { }

    var body: some View {
        Image(uiImage: ImageElementView.image)
            .padding(.zero)
    }
}

// MARK: - Dynamic Views

struct ToggledElementView: GridElementView {
    
    let indexPath: IndexPath
    let update: Binding<Bool>
    
    init(indexPath: IndexPath, update: Binding<Bool>) {
        self.indexPath = indexPath
        self.update = update
    }
    
    var body: some View {
        Group {
            if indexPath == Constants.toggledElementIndexPath && update.wrappedValue {
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
        if indexPath == Constants.toggledElementIndexPath && update.wrappedValue {
            return AnyView(ImageElementView(indexPath: indexPath, update: update))
        } else {
            return AnyView(TextElementView(indexPath: indexPath, update: update))
        }
    }
}

// MARK: - Equatable

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
    fatalError("Must not be called")
}
