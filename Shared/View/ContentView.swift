//
//  ContentView.swift
//  Shared
//
//  Created by Rudigus on 21/06/21.
//

import SwiftUI

struct ContentView: View {
    let simulationTick = Timer.publish(
        every: (1.0 / 30.0),
        on: .main,
        in: .common
    ).autoconnect()
    let deathTimer = Timer.publish(
        every: 5.0,
        on: .main,
        in: .common
    ).autoconnect()
    
    @StateObject var population: Population
    @StateObject var target: Target
    
    init() {
        let population = Population(individualCount: 100, individualSize: 10, individualSpeed: 8, mutationRate: 0.01)
        self._population = StateObject(wrappedValue: population)
        self._target = StateObject(wrappedValue: Target(population: population, size: 20, margin: 50))
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            Color.blue.edgesIgnoringSafeArea(.all)
            TargetView(target: target)
            ForEach(population.individuals) { (individual: Individual) in
                IndividualView(individual: individual)
            }
        }
        .onReceive(simulationTick) { input in
            if !self.population.hasFinishedTask {
                self.population.update(targetPosition: self.target.position)
            } else {
//                self.target.randomizePosition(population: population)
                self.population.naturalSelection(targetPosition: self.target.position)
            }
//            timer.upstream.connect().cancel()
        }
        .onReceive(deathTimer) { input in
            population.killRemainingIndividuals()
        }
    }
    
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
