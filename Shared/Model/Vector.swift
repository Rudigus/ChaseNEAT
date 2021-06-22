//
//  Vector.swift
//  ChaseNEAT
//
//  Created by Rudigus on 21/06/21.
//

import Foundation

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
}
