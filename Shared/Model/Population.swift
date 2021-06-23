//
//  Population.swift
//  ChaseNEAT
//
//  Created by Rudigus on 21/06/21.
//

import Foundation

class Population {
    var individuals: [Individual] = []
    var individualCount: Int
    var individualInitialPosition: Vector
    var individualSize: Double
    var hasFinishedTask: Bool {
        for individual in individuals {
            if individual.state == .currentlyOnTask {
                return false
            }
        }
        return true
    }
    
    init(individualCount: Int, individualInitialPosition: Vector = .zero, individualSize: Double) {
        self.individualCount = individualCount
        self.individualInitialPosition = individualInitialPosition
        self.individualSize = individualSize
        self.generate()
    }
    
    func generate() {
        for _ in 0..<individualCount {
            individuals.append(Individual(brain: Brain(neuronGenes: [], connectionGenes: []), position: individualInitialPosition, size: individualSize))
        }
    }
    
    func update(target: Vector) {
        self.individuals.forEach { $0.update(target: target) }
    }
}
