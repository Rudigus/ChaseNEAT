//
//  NeuronGene.swift
//  ChaseNEAT
//
//  Created by Rudigus on 21/06/21.
//

import Foundation

enum NeuronType {
    case input, hidden, output
}

struct NeuronGene {
    var id: Int
    var type: NeuronType
}
