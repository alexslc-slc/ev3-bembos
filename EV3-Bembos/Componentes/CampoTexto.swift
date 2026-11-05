import SwiftUI

struct CampoTexto: View {
    var icono: String? = nil
    var placeholder: String
    @Binding var texto: String
    var esSeguro: Bool = false

    @State private var mostrarTexto = false

    var body: some View {
        HStack(spacing: 12) {
            if let icono = icono {
                Image(systemName: icono)
                    .foregroundStyle(ColoresBembos.grisMedio)
                    .font(.system(size: 16))
            }

            Group {
                if esSeguro && !mostrarTexto {
                    SecureField(placeholder, text: $texto)
                        .font(.system(size: 16))
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.never)
                } else {
                    TextField(placeholder, text: $texto)
                        .font(.system(size: 16))
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.never)
                }
            }
            .foregroundStyle(ColoresBembos.textoOscuro)

            if esSeguro {
                Button {
                    mostrarTexto.toggle()
                } label: {
                    Image(systemName: mostrarTexto ? "eye" : "eye.slash")
                        .foregroundStyle(ColoresBembos.textoOscuro.opacity(0.6))
                        .font(.system(size: 16))
                }
            }
        }
        .padding(.horizontal, 16)
        .frame(height: 50)
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(ColoresBembos.grisMedio.opacity(0.5), lineWidth: 1)
        )
    }
}

