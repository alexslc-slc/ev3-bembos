import SwiftUI
import Combine

@MainActor
final class SesionViewModel: ObservableObject {
    @Published var usuarioActual: Usuario?
    @Published var usuariosRegistrados: [Usuario]

    init() {
        let usuarioDemo = Usuario(
            nombre: "Demo",
            email: "demo@bembos.com",
            password: "Demo123!"
        )
        self.usuarioActual = nil
        self.usuariosRegistrados = [usuarioDemo]
    }

    func iniciarSesion(email: String, password: String) -> Bool {
        let emailNormalizado = email.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let passwordNormalizada = password

        guard let usuario = usuariosRegistrados.first(where: {
            $0.email.lowercased() == emailNormalizado && $0.password == passwordNormalizada
        }) else {
            return false
        }

        usuarioActual = usuario
        return true
    }

    func registrarUsuario(_ usuario: Usuario) {
        usuariosRegistrados.append(usuario)
        usuarioActual = usuario
    }

    func cerrarSesion() {
        usuarioActual = nil
    }

    func existeEmail(_ email: String) -> Bool {
        let emailNormalizado = email.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        return usuariosRegistrados.contains { $0.email.lowercased() == emailNormalizado }
    }
}
