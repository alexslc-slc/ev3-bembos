import Foundation
import Combine

@MainActor
final class RegistroViewModel: ObservableObject {
    @Published var nombre: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmarPassword: String = ""
    @Published var mensajeError: String = ""
    @Published var registroExitoso: Bool = false
    @Published var cuentaCreada: Bool = false

    func validarCampos(usuariosExistentes: [Usuario]) -> Bool {
        let nombreLimpio = nombre.trimmingCharacters(in: .whitespacesAndNewlines)
        let emailLimpio = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#

        if nombreLimpio.isEmpty {
            mensajeError = "El nombre no puede estar vacío."
            return false
        }

        if emailLimpio.isEmpty {
            mensajeError = "El email no puede estar vacío."
            return false
        }

        if emailLimpio.range(of: emailRegex, options: .regularExpression) == nil {
            mensajeError = "Ingresa un email válido."
            return false
        }

        if usuariosExistentes.contains(where: { $0.email.lowercased() == emailLimpio.lowercased() }) {
            mensajeError = "Este email ya está registrado."
            return false
        }

        if password.isEmpty || confirmarPassword.isEmpty {
            mensajeError = "Debes completar las contraseñas."
            return false
        }

        if password.count < 6 {
            mensajeError = "La contraseña debe tener al menos 6 caracteres."
            return false
        }

        if !password.contains(where: { $0.isUppercase }) {
            mensajeError = "La contraseña debe incluir al menos una mayúscula."
            return false
        }

        let caracteresEspeciales = Set("!@#$%^&*()_+-=[]{}|;:'\"<>,.?/~`")
        if !password.contains(where: { caracteresEspeciales.contains($0) }) {
            mensajeError = "La contraseña debe incluir al menos un carácter especial."
            return false
        }

        if password != confirmarPassword {
            mensajeError = "Las contraseñas no coinciden."
            return false
        }

        mensajeError = ""
        return true
    }

    func registrarUsuario(usuariosExistentes: [Usuario]) -> Usuario? {
        let nombreLimpio = nombre.trimmingCharacters(in: .whitespacesAndNewlines)
        let emailLimpio = email.trimmingCharacters(in: .whitespacesAndNewlines)

        guard validarCampos(usuariosExistentes: usuariosExistentes) else {
            return nil
        }

        let usuario = Usuario(nombre: nombreLimpio, email: emailLimpio, password: password)
        registroExitoso = true
        cuentaCreada = true
        return usuario
    }
}
