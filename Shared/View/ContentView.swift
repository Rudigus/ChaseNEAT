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
    
    var population = Population(size: 10)
    var target = Target(position: Vector(x: 50, y: 50))
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.blue.edgesIgnoringSafeArea(.all)
            ForEach(population.members) { (individual: Individual) in
                IndividualView(individual: individual)
            }
        }
        .onReceive(timer) { input in
            if !self.population.hasFinishedTask {
                self.population.update(target: self.target.position)
            }
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
