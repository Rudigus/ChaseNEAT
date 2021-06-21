//
//  Individual.swift
//  ChaseNEAT
//
//  Created by Rudigus on 21/06/21.
//

import Foundation

class Individual: Identifiable {
    var brain: Brain
    var position: Vector
    var size: Double
    
    init(brain: Brain, position: Vector, size: Double) {
        self.brain = brain
        self.position = position
        self.size = size
    }
}
