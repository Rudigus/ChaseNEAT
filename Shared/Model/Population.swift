//
//  Population.swift
//  ChaseNEAT
//
//  Created by Rudigus on 21/06/21.
//

import Foundation

// A bunch of individuals
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
        let inputNeurons = [Neuron(id: 1, synapses: [], bias: 0), Neuron(id: 2, synapses: [], bias: 0), Neuron(id: 3, synapses: [], bias: 0), Neuron(id: 4, synapses: [], bias: 0)]
        let outputSynapses = [Synapse(startNeuronID: 1), Synapse(startNeuronID: 2), Synapse(startNeuronID: 3), Synapse(startNeuronID: 4)]
        var outputNeurons = [Neuron(id: 5, synapses: outputSynapses, bias: 0), Neuron(id: 6, synapses: outputSynapses, bias: 0)]
        for _ in 0..<individualCount {
            for i in 0 ..< outputNeurons.count {
                outputNeurons[i].randomizeSynapseWeights()
            }
            let layers: [Layer] = [Layer(id: 1, neurons: inputNeurons), Layer(id: 2, neurons: outputNeurons)]
            individuals.append(Individual(brain: Brain(layers: layers), position: individualInitialPosition, size: individualSize))
        }
    }
    
    func update(targetPosition: Vector) {
        self.individuals.forEach { $0.update(targetPosition: targetPosition) }
    }
}
