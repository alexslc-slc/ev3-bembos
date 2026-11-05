import Foundation
import Combine

@MainActor
final class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var mensajeError: String = ""
    @Published var estaAutenticado: Bool = false

    func validarCampos() -> Bool {
        let emailNormalizado = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let passwordNormalizada = password
        let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        let emailValido = emailNormalizado.range(of: emailRegex, options: .regularExpression) != nil
        let tieneMayuscula = passwordNormalizada.range(of: "[A-Z]", options: .regularExpression) != nil
        let tieneEspecial = passwordNormalizada.contains { caracter in
            let caracteresEspeciales = Set("!@#$%^&*()_+-=[]{}|;:'\"<>,.?/~`")
            return caracteresEspeciales.contains(caracter)
        }

        if !emailValido {
            mensajeError = "El email ingresado no tiene un formato válido."
            return false
        }

        if passwordNormalizada.count < 6 {
            mensajeError = "La contraseña debe tener mínimo 6 caracteres."
            return false
        }

        if !tieneMayuscula {
            mensajeError = "La contraseña debe incluir al menos una mayúscula."
            return false
        }

        if !tieneEspecial {
            mensajeError = "La contraseña debe incluir al menos un carácter especial."
            return false
        }

        mensajeError = ""
        return true
    }

    func iniciarSesion(usuarios: [Usuario]) -> Bool {
        guard validarCampos() else {
            return false
        }

        let emailNormalizado = email.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let usuarioValido = usuarios.contains {
            $0.email.lowercased() == emailNormalizado && $0.password == password
        }

        if !usuarioValido {
            mensajeError = "Credenciales inválidas. Verifica tu email y contraseña."
            return false
        }

        estaAutenticado = true
        return true
    }
}
