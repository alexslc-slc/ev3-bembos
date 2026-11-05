import SwiftUI

struct RegistroView: View {
    @StateObject private var viewModel = RegistroViewModel()
    @EnvironmentObject private var sesion: SesionViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .center, spacing: 16) {

                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 44, height: 44)
                                .overlay(
                                    Image(systemName: "chevron.left")
                                        .font(.system(size: 18, weight: .bold))
                                        .foregroundStyle(ColoresBembos.textoOscuro)
                                )
                        }
                        Spacer()
                    }
                    .padding(.top, 10)

                    HStack {
                        Text("Crear cuenta")
                            .font(.system(size: 26, weight: .bold))
                            .foregroundStyle(ColoresBembos.textoOscuro)
                        Spacer()
                    }
                    .padding(.bottom, 10)

                    VStack(spacing: 16) {
                        GrupoCampo(titulo: "Nombre *", placeholder: "Ej. Camila", icono: "person", texto: $viewModel.nombre)
                        GrupoCampo(titulo: "Correo electrónico *", placeholder: "nombre@dominio.com", icono: "envelope", texto: $viewModel.email)
                        GrupoCampo(titulo: "Contraseña *", placeholder: "********", icono: "lock", texto: $viewModel.password, esSeguro: true)
                        GrupoCampo(titulo: "Confirmar contraseña *", placeholder: "********", icono: "lock", texto: $viewModel.confirmarPassword, esSeguro: true)
                    }

                    if !viewModel.mensajeError.isEmpty {
                        Text(viewModel.mensajeError)
                            .foregroundStyle(ColoresBembos.rojoPrincipal)
                            .font(.system(size: 13, weight: .semibold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }

                    if viewModel.cuentaCreada {
                        Text("Cuenta creada exitosamente")
                            .foregroundStyle(.green)
                            .font(.system(size: 14, weight: .bold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }

                    Button {
                        guard let usuario = viewModel.registrarUsuario(usuariosExistentes: sesion.usuariosRegistrados) else {
                            return
                        }

                        sesion.registrarUsuario(usuario)
                    } label: {
                        Text("Crear cuenta")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(.white)
                            .frame(maxWidth: 300)
                            .frame(height: 48)
                            .background(ColoresBembos.azulMarca)
                            .clipShape(Capsule())
                    }
                    .padding(.top, 10)

                    HStack(spacing: 6) {
                        Text("¿Ya tienes una cuenta?")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundStyle(ColoresBembos.textoOscuro)
                        Button {
                            dismiss()
                        } label: {
                            Text("Inicia sesión")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundStyle(ColoresBembos.azulMarca)
                        }
                    }
                    .padding(.top, 16)

                    Spacer(minLength: 40)
                }
                .padding(.horizontal, 24)
            }
            .background(ColoresBembos.fondoClaro.ignoresSafeArea())
            .navigationBarHidden(true)
        }
    }
}

private struct GrupoCampo: View {
    let titulo: String
    let placeholder: String
    let icono: String
    @Binding var texto: String
    var esSeguro: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(titulo)
                .font(.system(size: 14, weight: .regular))
                .foregroundStyle(ColoresBembos.textoOscuro)

            CampoTexto(
                icono: icono,
                placeholder: placeholder,
                texto: $texto,
                esSeguro: esSeguro
            )
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

