//
//  ContentView.swift
//  Shared
//
//  Created by Rudigus on 21/06/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var population = Population(size: 10)
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.blue.edgesIgnoringSafeArea(.all)
            ForEach(population.members) { (individual: Individual) in
                IndividualView(individual: individual)
            }
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
