import Foundation

struct Usuario: Identifiable, Equatable {
    let id: UUID
    var nombre: String
    var email: String
    var password: String

    init(id: UUID = UUID(), nombre: String, email: String, password: String) {
        self.id = id
        self.nombre = nombre
        self.email = email
        self.password = password
    }
}
