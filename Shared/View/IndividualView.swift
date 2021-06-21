//
//  IndividualView.swift
//  ChaseNEAT
//
//  Created by Rudigus on 21/06/21.
//

import SwiftUI

struct IndividualView: View {
    let individual: Individual
    
    init(individual: Individual) {
        self.individual = individual
    }
    
    var body: some View {
        Circle()
            .foregroundColor(.red)
            .frame(width: individual.size, height: individual.size)
            .offset(x: CGFloat(individual.position.x), y: CGFloat(individual.position.y))
    }
}

//struct IndividualView_Previews: PreviewProvider {
//    static var previews: some View {
//        IndividualView()
//    }
//}
