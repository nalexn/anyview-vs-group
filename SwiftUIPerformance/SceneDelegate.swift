//
//  SceneDelegate.swift
//  SwiftUIPerformance
//
//  Created by Alexey Naumov on 29.11.2019.
//  Copyright © 2019 Alexey Naumov. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
//      let contentView = EmptyView()
//      testViewCreationPerformance()
        let contentView = ContentView()
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    
    func testViewCreationPerformance() {
        let update = Binding<Bool>(get: { true }, set: { _ in })
        let size = Constants.largeGridSize
        let iterations = 1000000
        
        var timeStamp1 = Date().snapshot
        for _ in 0 ... iterations {
            let view = GridView<TextElementView>(size: size, update: update)
            _ = view.body
        }
        var timeStamp2 = Date().snapshot
        print("GridView<TextElementView> init + body \(iterations) times: \(timeStamp2 - timeStamp1) seconds")
        
        timeStamp1 = Date().snapshot
        for _ in 0 ... iterations {
            let view = GridView<ImageElementView>(size: size, update: update)
            _ = view.body
        }
        timeStamp2 = Date().snapshot
        print("GridView<ImageElementView> init + body \(iterations) times: \(timeStamp2 - timeStamp1) seconds")
        
        timeStamp1 = Date().snapshot
        for _ in 0 ... iterations {
            let view = GridView<ToggledElementView>(size: size, update: update)
            _ = view.body
        }
        timeStamp2 = Date().snapshot
        print("GridView<ToggledElementView> init + body \(iterations) times: \(timeStamp2 - timeStamp1) seconds")
        
        timeStamp1 = Date().snapshot
        for _ in 0 ... iterations {
            let view = GridView<TypeErasedToggledElementView>(size: size, update: update)
            _ = view.body
        }
        timeStamp2 = Date().snapshot
        print("GridView<TypeErasedToggledElementView> init + body \(iterations) times: \(timeStamp2 - timeStamp1) seconds")
    }
}
