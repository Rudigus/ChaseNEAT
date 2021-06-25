//
//  Layer.swift
//  ChaseNEAT
//
//  Created by Rudigus on 23/06/21.
//

import Foundation

// Represents a layer of the Neural Network
class Layer: CustomStringConvertible {
    var id: Int
    var neurons: [Neuron]
    
    var description: String {
        return "Layer(id: \(id), neurons: \(neurons))"
    }
    
    init(id: Int, neurons: [Neuron]) {
        self.id = id
        self.neurons = neurons
    }
    
    init(copy: Layer) {
        self.id = copy.id
        self.neurons = copy.neurons
    }
    
    func forward(input: [Int: Double]) -> [Int: Double]? {
        var output: [Int: Double] = [:]
        for neuron in neurons {
            var sum = 1 * neuron.bias
            for synapse in neuron.synapses.filter({ $0.enabled }) {
                if let synapseValue = input[synapse.startNeuronID] {
                    sum += synapseValue * synapse.weight
                }
                else {
                    // One or more input values are missing
                    return nil
                }
            }
            output[neuron.id] = tanh(value: sum)
        }
        return output
    }
    
    func sigmoid(value: Double) -> Double {
        return 1.0 / (1.0 + exp(-value))
    }
    
    func tanh(value: Double) -> Double {
        return 2 * sigmoid(value: 2 * value) - 1
    }
}
