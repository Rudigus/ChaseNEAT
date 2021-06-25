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

enum IndividualRank {
    case regular, champion
}

// Genetic Algorithm's basic unit
class Individual: Identifiable, ObservableObject {
    var brain: Brain!
    var initialPosition: Vector
    var position: Vector {
        willSet {
            self.objectWillChange.send()
        }
    }
    var size: Double
    var speed: Double
    var state: IndividualState {
        willSet {
            self.objectWillChange.send()
        }
    }
    var rank: IndividualRank
    
    init(brain: Brain? = nil, initialPosition: Vector, size: Double, speed: Double, state: IndividualState = .currentlyOnTask, rank: IndividualRank = .regular) {
        self.initialPosition = initialPosition
        self.position = initialPosition
        self.size = size
        self.speed = speed
        self.state = state
        self.rank = rank
        if let brain = brain {
            self.brain = brain
        } else {
            generateBrain()
        }
    }
    
    init(copy: Individual, position: Vector) {
        self.brain = Brain(copy: copy.brain)
        self.initialPosition = copy.initialPosition
        self.position = copy.initialPosition
        self.size = copy.size
        self.speed = copy.speed
        self.state = .currentlyOnTask
        self.rank = .champion
    }
    
    func update(targetPosition: Vector) {
        if self.state == .hasCompletedTask {
            return
        }
        let nextDirection = brain.nextDirection(individualPosition: position, targetPosition: targetPosition)
        self.position.x += nextDirection.x * self.speed
        self.position.y += nextDirection.y * self.speed
        if self.position.distance(to: targetPosition) < 10 {
            self.state = .hasCompletedTask
        }
    }
    
    func generateBrain() {
        let inputNeurons = [Neuron(id: 1, synapses: [], bias: 0), Neuron(id: 2, synapses: [], bias: 0), Neuron(id: 3, synapses: [], bias: 0), Neuron(id: 4, synapses: [], bias: 0)]
        let outputSynapses = [Synapse(startNeuronID: 1), Synapse(startNeuronID: 2), Synapse(startNeuronID: 3), Synapse(startNeuronID: 4)]
        var outputNeurons = [Neuron(id: 5, synapses: outputSynapses, bias: 0), Neuron(id: 6, synapses: outputSynapses, bias: 0)]
        for i in 0 ..< outputNeurons.count {
            outputNeurons[i].randomizeSynapseWeights()
        }
        let layers: [Layer] = [Layer(id: 1, neurons: inputNeurons), Layer(id: 2, neurons: outputNeurons)]
        self.brain = Brain(layers: layers)
    }
    
    func fitness(target: Vector) -> Double {
        if (self.state == .hasCompletedTask) {
//            let step = Float(self.brain.step)
            let targetFitness = 1.0 / (self.size * self.size)
//            let stepFitness = 10000.0 / (step * step)
            let stepFitness = 100.0
            let fitness = targetFitness + stepFitness

            return fitness
        } else {
            let fitness = 1.0 / self.position.squaredDistance(to: target)
            return fitness
        }
    }
    
}
