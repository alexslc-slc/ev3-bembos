//
//  EV3_BembosApp.swift
//  EV3-Bembos
//
//  Created by Alumno on 5/11/26.
//

import SwiftUI

@main
struct EV3_BembosApp: App {
    @StateObject private var sesion = SesionViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(sesion)
        }
    }
}
