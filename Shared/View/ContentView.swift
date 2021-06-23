//
//  ContentView.swift
//  Shared
//
//  Created by Rudigus on 21/06/21.
//

import SwiftUI

struct ContentView: View {
    let timer = Timer.publish(
        every: (1.0 / 30.0),
        on: .main,
        in: .common
    ).autoconnect()
    
    let anotherTimer = Timer.publish(
        every: 4.0,
        on: .main,
        in: .common
    ).autoconnect()
    
    var population = Population(individualCount: 10, individualSize: 10)
    var target: Target
    
    init() {
        target = Target(population: population, size: 10, margin: 50)
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            Color.blue.edgesIgnoringSafeArea(.all)
            ForEach(population.individuals) { (individual: Individual) in
                IndividualView(individual: individual)
            }
            TargetView(target: target)
        }
        .onReceive(timer) { input in
            if !self.population.hasFinishedTask {
                self.population.update(target: self.target.position)
            }
        }
        .onReceive(anotherTimer) { input in
            target.randomizePosition(population: population)
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
