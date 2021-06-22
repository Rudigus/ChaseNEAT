//
//  Population.swift
//  ChaseNEAT
//
//  Created by Rudigus on 21/06/21.
//

import Foundation

class Population {
    var members: [Individual]
    var size: Int
    var hasFinishedTask: Bool {
        for individual in members {
            if individual.state == .currentlyOnTask {
                return false
            }
        }
        return true
    }
    
    init(size: Int) {
        self.size = size
        members = []
        for i in 0..<size {
            members.append(Individual(brain: Brain(neuronGenes: [], connectionGenes: []), position: Vector(x: Double(i * 20), y: 0), size: 10))
        }
    }
    
    func update(target: Vector) {
        self.members.forEach { $0.update(target: target) }
    }
}
