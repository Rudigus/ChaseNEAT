//
//  Neuron.swift
//  ChaseNEAT
//
//  Created by Rudigus on 21/06/21.
//

import Foundation

// The Neural Network's basic unit
struct Neuron {
    var id: Int
    var synapses: [Synapse]
    var bias: Double
    
    mutating func randomizeSynapseWeights() {
        for i in 0 ..< synapses.count {
            synapses[i].weight = Double.random(in: -1 ... 1)
        }
    }
}
