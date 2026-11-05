import SwiftUI

struct BotonPrimario: View {
    let titulo: String
    let accion: () -> Void

    var body: some View {
        Button(action: accion) {
            Text(titulo)
                .font(.custom("Arial-BoldMT", size: 20))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .foregroundStyle(.white)
                .background(
                    LinearGradient(
                        colors: [ColoresBembos.azulMarca, ColoresBembos.azulOscuro],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
                .shadow(color: Color.black.opacity(0.08), radius: 6, x: 0, y: 5)
        }
    }
}

