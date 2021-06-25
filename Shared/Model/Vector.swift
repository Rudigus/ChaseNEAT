//
//  Vector.swift
//  ChaseNEAT
//
//  Created by Rudigus on 21/06/21.
//

import Foundation
#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

struct Vector: CustomStringConvertible {
    var x: Double
    var y: Double
    
    var description: String {
        return "(\(x), \(y))"
    }
    
    init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
    
    func squaredDistance(to other: Vector) -> Double {
        let diffX = self.x - other.x
        let diffY = self.y - other.y
        return (diffX * diffX) + (diffY * diffY)
    }
    
    func distance(to other: Vector) -> Double {
        let diffX = self.x - other.x
        let diffY = self.y - other.y
        let productSum = (diffX * diffX) + (diffY * diffY)
        return sqrt(productSum)
    }
    
}

extension Vector {
    static let zero = Vector(x: 0, y: 0)
    #if os(iOS)
    static let screenSize = Vector(x: UIScreen.main.bounds.size.width, y: UIScreen.main.bounds.size.height)
    static let simulationSize = screenSize
    #elseif os(macOS)
    static let screenSize: Vector = {
        if let screenSize = NSScreen.main?.frame.size {
            return Vector(x: screenSize.width, y: screenSize.height)
        }
        else {
            return Vector.zero
        }
    }()
    static let simulationSize = Vector(x: screenSize.x / 2, y: screenSize.y / 2)
    #endif
    static let simulationMiddle = Vector(x: simulationSize.x / 2, y: simulationSize.y / 2)
}
