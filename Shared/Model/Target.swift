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
    var margin: Double
    
    init(population: Population, size: Double, margin: Double) {
        self.position = .zero
        self.size = size
        self.margin = margin
        randomizePosition(population: population)
    }
    
    // Generates a random position for the target. It's a scary function, since it could loop forever if you're unlucky enough.
    // Still, it works.
    func randomizePosition(population: Population) {
        while true {
            let randomX = Double.random(in: -Vector.simulationSize.x / 2 + margin ... (Vector.simulationSize.x / 2 - population.individualSize / 2 - margin))
            let randomY = Double.random(in: -Vector.simulationSize.y / 2 + margin ... (Vector.simulationSize.y / 2 - population.individualSize / 2 - margin))
            let randomPosition = Vector(x: randomX, y: randomY)
            if randomPosition.squaredDistance(to: population.individualInitialPosition) >= 50000 {
                self.position = Vector(x: randomX, y: randomY)
                break
            }
        }
    }
}
