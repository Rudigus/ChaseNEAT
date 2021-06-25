//
//  IndividualView.swift
//  ChaseNEAT
//
//  Created by Rudigus on 21/06/21.
//

import SwiftUI

struct IndividualView: View {
    @ObservedObject var individual: Individual
    
    init(individual: Individual) {
        self.individual = individual
    }
    
    var body: some View {
        Circle()
            .foregroundColor(individualColor(individual: individual))
            .frame(width: individual.size, height: individual.size)
            .offset(x: CGFloat(individual.position.x), y: CGFloat(individual.position.y))
    }
    
    func individualColor(individual: Individual) -> Color {
        if individual.state == .hasCompletedTask {
            return .green
        }
        
        if individual.state == .hasFailedTask {
            return .red
        }
        
        if individual.rank == .champion {
            return .black
        }
        
        return .white
    }
}

//struct IndividualView_Previews: PreviewProvider {
//    static var previews: some View {
//        IndividualView()
//    }
//}
