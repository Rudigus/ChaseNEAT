//
//  Target.swift
//  ChaseNEAT
//
//  Created by Rudigus on 22/06/21.
//

import Foundation

class Target: ObservableObject {
    var position: Vector {
        willSet {
            self.objectWillChange.send()
        }
    }
    var size: Double
    
    init(population: Population, size: Double) {
        self.position = .zero
        self.size = size
        randomizePosition(population: population)
    }
    
    // Generates a random position for the target. It's a scary function, since it could loop forever if you're unlucky enough.
    // Still, it works.
    func randomizePosition(population: Population) {
        while true {
            let randomX = Vector.simulationSize.x * Double.random(in: -0.35 ... 0.3)
            let randomY = Vector.simulationSize.y * Double.random(in: -0.4 ... 0.35)
            let randomPosition = Vector(x: randomX, y: randomY)
            if randomPosition.squaredDistance(to: population.individualInitialPosition) >= 50000 {
                self.position = Vector(x: randomX, y: randomY)
                break
            }
        }
    }
}
