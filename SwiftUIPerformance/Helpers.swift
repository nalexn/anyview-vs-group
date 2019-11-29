//
//  Helpers.swift
//  SwiftUIPerformance
//
//  Created by Alexey Naumov on 29.11.2019.
//  Copyright © 2019 Alexey Naumov. All rights reserved.
//

import Foundation
import Combine
import UIKit

struct DiscretePair {
    let dx: Int
    let dy: Int
}

extension Int {
    var indices: [Int] {
        guard self > 0 else { return [] }
        return Array(stride(from: 0, to: self, by: 1))
    }
}

extension Int: Identifiable {
    public var id: Int { self }
}

extension IndexPath {
    init(row: Int, column: Int) {
        self.init(row: row, section: column)
    }
}

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

extension UIColor {
    func image(_ size: CGSize) -> UIImage {
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        return UIGraphicsImageRenderer(size: size, format: format).image { rendererContext in
            setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}
