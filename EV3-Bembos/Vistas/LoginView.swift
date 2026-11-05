import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @EnvironmentObject private var sesion: SesionViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .center, spacing: 16) {

                    Spacer(minLength: 40)

                    Image("BembosSplash")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 250, height: 90)
                        .clipped()
                        .padding(.bottom, 20)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Correo electrónico *")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundStyle(ColoresBembos.textoOscuro)

                        CampoTexto(
                            placeholder: "nombre@dominio.com",
                            texto: $viewModel.email
                        )
                        .padding(.bottom, 8)

                        Text("Contraseña *")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundStyle(ColoresBembos.textoOscuro)

                        CampoTexto(
                            placeholder: "********",
                            texto: $viewModel.password,
                            esSeguro: true
                        )
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    HStack {
                        Spacer()
                        Button {
                        } label: {
                            Text("¿Olvidaste tu contraseña?")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundStyle(ColoresBembos.azulMarca)
                        }
                    }
                    .padding(.bottom, 10)

                    if !viewModel.mensajeError.isEmpty {
                        Text(viewModel.mensajeError)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundStyle(ColoresBembos.rojoPrincipal)
                            .font(.system(size: 13, weight: .semibold))
                    }

                    Button {
                        let credencialesValidas = viewModel.iniciarSesion(usuarios: sesion.usuariosRegistrados)
                        if credencialesValidas {
                            if let usuario = sesion.usuariosRegistrados.first(where: {
                                $0.email.lowercased() == viewModel.email.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
                            }) {
                                sesion.usuarioActual = usuario
                            }
                        }
                    } label: {
                        Text("Iniciar sesión")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(.white)
                            .frame(maxWidth: 300)
                            .frame(height: 48)
                            .background(ColoresBembos.azulMarca)
                            .clipShape(Capsule())
                    }
                    .disabled(viewModel.email.isEmpty || viewModel.password.isEmpty)
                    .opacity(viewModel.email.isEmpty || viewModel.password.isEmpty ? 0.6 : 1)

                    Button {
                        print("Continuar con Google")
                    } label: {
                        HStack(spacing: 8) {
                            Image(systemName: "g.circle.fill")
                                .font(.system(size: 18))
                                .foregroundStyle(Color(red: 0.22, green: 0.41, blue: 0.82))
                            Text("Continúa con Google")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundStyle(ColoresBembos.azulMarca)
                        }
                        .frame(maxWidth: 300)
                        .frame(height: 48)
                        .background(Color.white)
                        .clipShape(Capsule())
                        .overlay(
                            Capsule()
                                .stroke(ColoresBembos.azulMarca, lineWidth: 1.5)
                        )
                    }

                    NavigationLink(destination: RegistroView()) {
                        Text("Crear cuenta")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(ColoresBembos.azulMarca)
                            .frame(maxWidth: 300)
                            .frame(height: 48)
                            .background(Color.white)
                            .clipShape(Capsule())
                            .overlay(
                                Capsule()
                                    .stroke(ColoresBembos.azulMarca, lineWidth: 1.5)
                            )
                    }

                    Button {
                        sesion.usuarioActual = Usuario(
                            nombre: "Invitado",
                            email: "invitado@bembos.com",
                            password: "Invitado123!"
                        )
                    } label: {
                        Text("Ingresar como invitado")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundStyle(ColoresBembos.azulMarca)
                            .padding(.top, 10)
                    }

                    NavigationLink(destination: InicioView(), isActive: .constant(sesion.usuarioActual != nil)) {
                        EmptyView()
                    }

                    Spacer(minLength: 40)
                }
                .padding(.horizontal, 24)
            }
            .background(ColoresBembos.fondoClaro.ignoresSafeArea())
            .navigationBarHidden(true)
        }
    }
}

