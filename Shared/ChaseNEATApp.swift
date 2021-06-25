//
//  ChaseNEATApp.swift
//  Shared
//
//  Created by Rudigus on 21/06/21.
//

import SwiftUI

@main
struct ChaseNEATApp: App {
    
    var body: some Scene {
        WindowGroup {
            #if os(iOS)
            ContentView()
            #elseif os(macOS)
            ContentView()
                .frame(minWidth: Vector.screenSize.x / 2, maxWidth: Vector.screenSize.x / 2, minHeight: Vector.screenSize.y / 2, maxHeight: Vector.screenSize.y / 2)
            #endif
            
        }
    }
}
