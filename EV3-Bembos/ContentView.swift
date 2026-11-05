//
//  ContentView.swift
//  EV3-Bembos
//
//  Created by Alumno on 5/11/26.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var sesion: SesionViewModel
    @State private var mostrarSplash = true

    var body: some View {
        Group {
            if mostrarSplash {
                SplashView()
            } else if sesion.usuarioActual != nil {
                InicioView()
            } else {
                LoginView()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation(.easeInOut(duration: 0.5)) {
                    mostrarSplash = false
                }
            }
        }
    }
}

