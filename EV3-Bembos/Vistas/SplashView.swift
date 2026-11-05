import SwiftUI

struct SplashView: View {
    @State private var opacidad: Double = 0.0
    @State private var escala: CGFloat = 0.9

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            Image("BembosSplash")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width * 0.65)
                .scaleEffect(escala)
                .opacity(opacidad)
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.7)) {
                opacidad = 1
                escala = 1
            }
        }
    }
}

