//
//  Population.swift
//  ChaseNEAT
//
//  Created by Rudigus on 21/06/21.
//

import Foundation

// A bunch of individuals
class Population: ObservableObject {
    @Published var individuals: [Individual] = []
    @Published var generation: Int
    var individualCount: Int
    var individualInitialPosition: Vector
    var individualSize: Double
    var individualSpeed: Double
    var mutationRate: Double
    var hasFinishedTask: Bool {
        for individual in individuals {
            if individual.state == .currentlyOnTask {
                return false
            }
        }
        return true
    }
    
    init(individualCount: Int, individualInitialPosition: Vector = .zero, individualSize: Double, individualSpeed: Double, mutationRate: Double) {
        self.generation = 1
        self.individualCount = individualCount
        self.individualInitialPosition = individualInitialPosition
        self.individualSize = individualSize
        self.individualSpeed = individualSpeed
        self.mutationRate = mutationRate
        self.generateIndividuals()
    }
    
    func reset() {
        self.generation = 1
        self.individuals.removeAll()
        self.generateIndividuals()
    }
    
    func update(targetPosition: Vector) {
        self.individuals.forEach { $0.update(targetPosition: targetPosition) }
    }
    
    func generateIndividuals() {
        for _ in 0..<individualCount {
            individuals.append(Individual(initialPosition: individualInitialPosition, size: individualSize, speed: individualSpeed))
        }
    }
    
    func killRemainingIndividuals() {
        for individual in individuals {
            if individual.state == .currentlyOnTask {
                individual.state = .hasFailedTask
            }
        }
    }
    
    func naturalSelection(targetPosition: Vector) {
        var fitnessSum: Double = 0
        var maxFitness: Double = -1
        var maxFitnessIndex = -1
        // Finds fitness sum, maximum fitness and index of the individual with maximum fitness
        for index in 0 ..< individuals.count {
            let individual = individuals[index]
            let individualFitness = individual.fitness(target: targetPosition)
            fitnessSum += individualFitness
            if individualFitness > maxFitness {
                maxFitness = individualFitness
                maxFitnessIndex = index
            }
        }

        let fitnessLotteryValue = Double.random(in: 0...1) * fitnessSum
        var progenitor: Individual? = nil
        var runningSum: Double = 0
        // Chooses a random individual to be the progenitor of the next generation. Individuals with higher fitness have better odds
        for index in 0..<individuals.count {
            runningSum += self.individuals[index].fitness(target: targetPosition)
            if (runningSum >= fitnessLotteryValue) {
                progenitor = self.individuals[index]
                break
            }
        }

        guard let progenitor = progenitor else { return }
        var newIndividuals: [Individual] = []
        // Generates the individuals of the next generation based on the chosen progenitor
        for _ in 1..<individuals.count {
            let newBrain = Brain(copy: progenitor.brain)
            newBrain.mutate(mutationRate: self.mutationRate)

            let newIndividual = Individual(
                brain: newBrain,
                initialPosition: self.individualInitialPosition,
                size: self.individualSize,
                speed: self.individualSpeed
            )

            newIndividuals.append(newIndividual)
        }
        // Adds champion of last generation to the new generation, unchanged
        let champion = individuals[maxFitnessIndex]
        newIndividuals.append(Individual(copy: champion, position: individualInitialPosition))
        
        self.individuals.removeAll()
        self.individuals.append(contentsOf: newIndividuals)
        generation += 1
    }
    
}
