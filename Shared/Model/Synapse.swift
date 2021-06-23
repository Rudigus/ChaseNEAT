//
//  Synapse.swift
//  ChaseNEAT
//
//  Created by Rudigus on 21/06/21.
//

import Foundation

// Connects two neurons
struct Synapse {
    var startNeuronID: Int
    var weight: Double
    var enabled: Bool
    
    init(startNeuronID: Int, weight: Double = 0, enabled: Bool = true) {
        self.startNeuronID = startNeuronID
        self.weight = weight
        self.enabled = enabled
    }
}
