//
//  Brain.swift
//  ChaseNEAT
//
//  Created by Rudigus on 21/06/21.
//

import Foundation

// Will manage the decisions of an individual
class Brain {
    // Genome
    var layers: [Layer]
    
    init(layers: [Layer]) {
        self.layers = layers
    }
    
    func forwardPropagation(input: [Int: Double]) -> [Int: Double]? {
        var layerValues = input
        for layer in layers {
            if layer.id == 1 {
                continue
            }
            if let output = layer.forward(input: layerValues) {
                layerValues = output
            } else {
                // Missing input
                return nil
            }
        }
        return layerValues
    }
    
    func inputNormalization(vector: Vector, factor: Double = 100) -> Vector {
        return Vector(x: vector.x / factor, y: vector.y / factor)
    }
    
//    func outputDenormalization(vector: Vector, factor: Double = 100) -> Vector {
//        return Vector(x: vector.x * factor, y: vector.y * factor)
//    }
    
    func nextDirection(individualPosition: Vector, targetPosition: Vector) -> Vector {
        let normalizedIndividualPosition = inputNormalization(vector: individualPosition)
        let normalizedTargetPosition = inputNormalization(vector: targetPosition)
        guard let output = forwardPropagation(input: [1: normalizedIndividualPosition.x, 2: normalizedIndividualPosition.y, 3: normalizedTargetPosition.x, 4: normalizedTargetPosition.y]) else {
            // Missing input
            return .zero
        }
        let orderedKeys = output.keys.sorted(by: <)
        if let firstOutputValue = output[orderedKeys[0]], let secondOutputValue = output[orderedKeys[1]] {
            return Vector(x: firstOutputValue, y: secondOutputValue)
        } else {
            // Missing output
            return .zero
        }
    }
}
