//
//  HUDView.swift
//  ChaseNEAT
//
//  Created by Rudigus on 25/06/21.
//

import SwiftUI

struct HUDView: View {
    @ObservedObject var population: Population
    @ObservedObject var target: Target
    let height: CGFloat = 50
    
    init(population: Population, target: Target) {
        self.population = population
        self.target = target
    }
    
    var body: some View {
        HStack(spacing: 20) {
            Text("Generation \(population.generation)")
            Button("Reset Population") {
                population.reset()
            }
            Button("Change Target Position") {
                target.randomizePosition(population: population)
            }
        }
        .foregroundColor(Color.white)
        .frame(width: Vector.simulationSize.x, height: height, alignment: .center)
        .background(Color.black.opacity(0.5))
        .offset(x: .zero, y: CGFloat(-Vector.simulationMiddle.y + height / 2))
    }
}

//struct HUDView_Previews: PreviewProvider {
//    static var previews: some View {
//        HUDView()
//    }
//}
