//
//  Brain.swift
//  ChaseNEAT
//
//  Created by Rudigus on 21/06/21.
//

import Foundation

class Brain {
    // Genome
    var neuronGenes: [NeuronGene] = []
    var connectionGenes: [ConnectionGene] = []
    
    init(neuronGenes: [NeuronGene], connectionGenes: [ConnectionGene]) {
        self.neuronGenes = neuronGenes
        self.connectionGenes = connectionGenes
    }
    
    func nextDirection() -> Vector {
        return Vector(x: 0, y: -1)
//        for(neuron)
    }
}
