//
//  TargetView.swift
//  ChaseNEAT
//
//  Created by Rudigus on 22/06/21.
//

import SwiftUI

struct TargetView: View {
    @ObservedObject var target: Target
    
    init(target: Target) {
        self.target = target
    }
    
    var body: some View {
        Circle()
            .foregroundColor(.yellow)
            .frame(width: target.size, height: target.size)
            .offset(x: CGFloat(target.position.x), y: CGFloat(target.position.y))
    }
}

//struct TargetView_Previews: PreviewProvider {
//    static var previews: some View {
//        TargetView()
//    }
//}
