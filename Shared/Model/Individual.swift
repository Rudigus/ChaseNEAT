//
//  Individual.swift
//  ChaseNEAT
//
//  Created by Rudigus on 21/06/21.
//

import Foundation

enum IndividualState {
    case currentlyOnTask, hasFailedTask, hasCompletedTask
}

// Genetic Algorithm's basic unit
class Individual: Identifiable, ObservableObject {
    var brain: Brain
    var position: Vector {
        willSet {
            self.objectWillChange.send()
        }
    }
    var size: Double
    var state: IndividualState
    
    init(brain: Brain, position: Vector, size: Double, state: IndividualState = .currentlyOnTask) {
        self.brain = brain
        self.position = position
        self.size = size
        self.state = state
    }
    
    func update(targetPosition: Vector) {
        let nextDirection = brain.nextDirection(individualPosition: position, targetPosition: targetPosition)
        self.position.x += nextDirection.x
        self.position.y += nextDirection.y
    }
}
