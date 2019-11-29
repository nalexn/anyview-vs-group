//
//  Helpers.swift
//  SwiftUIPerformance
//
//  Created by Alexey Naumov on 29.11.2019.
//  Copyright © 2019 Alexey Naumov. All rights reserved.
//

import Foundation
import Combine

extension Timer {
    static func timer(frequency: Int) -> AnyPublisher<TimeInterval, Never> {
        var lastUpdate = Date().timeIntervalSinceReferenceDate
        return Timer.publish(every: 1.0 / TimeInterval(frequency), on: .main, in: .common)
            .autoconnect()
            .map { date -> TimeInterval in
                let timestamp = date.timeIntervalSinceReferenceDate
                let elapsed = timestamp - lastUpdate
                lastUpdate = timestamp
                return elapsed
            }
            .eraseToAnyPublisher()
    }
}

extension Date {
    var snapshot: TimeInterval { timeIntervalSinceReferenceDate }
}
