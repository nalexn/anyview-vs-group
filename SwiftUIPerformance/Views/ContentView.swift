//
//  ContentView.swift
//  SwiftUIPerformance
//
//  Created by Alexey Naumov on 29.11.2019.
//  Copyright © 2019 Alexey Naumov. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    private let updateTimer = Timer.timer(frequency: 60)
    @State private var updateTrigger = false
    
    var body: some View {
        VStack {
            FPSView(update: $updateTrigger).equatable()
            Text("Hello, World!")
        }
        .onReceive(self.updateTimer) { elapsed in
            self.updateTrigger.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
