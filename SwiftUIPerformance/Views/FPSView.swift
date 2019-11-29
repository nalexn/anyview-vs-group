//
//  FPSView.swift
//  SwiftUIPerformance
//
//  Created by Alexey Naumov on 29.11.2019.
//  Copyright © 2019 Alexey Naumov. All rights reserved.
//

import SwiftUI
import Combine

extension FPSView: Equatable {
    static func == (lhs: FPSView, rhs: FPSView) -> Bool {
        return lhs.frequency == rhs.frequency
    }
}

struct FPSView: View {
    
    private let update: Binding<Bool>
    private var calculator = FPSCalculator()
    private let timer = Timer.timer(frequency: 2)
    @State private var frequency: Int = 0
    
    init(update: Binding<Bool>) {
        self.update = update
    }
    
    var body: some View {
        _ = update.wrappedValue
        calculator.updateFrequency()
        return Text("\(frequency) FPS")
            .font(.largeTitle)
            .onReceive(timer) { _ in
                self.frequency = self.calculator.frequency
            }
    }
}

extension FPSView {
    private class FPSCalculator {
        
        private var lastUpdate: TimeInterval = 0
        private(set) var frequency: Int = 0
        
        func updateFrequency() {
            let currentUpdate = Date().snapshot
            defer { lastUpdate = currentUpdate }
            frequency = Int(1.0 / (currentUpdate - lastUpdate))
        }
    }
}
