import Foundation

struct Producto: Identifiable, Equatable, Hashable {
    let id: UUID
    let nombre: String
    let descripcion: String
    let precio: Double
    let precioAnterior: Double?
    let descuento: String?
    let categoria: String
    let imagenURL: String
    let etiqueta: String?

    init(
        id: UUID = UUID(),
        nombre: String,
        descripcion: String,
        precio: Double,
        precioAnterior: Double? = nil,
        descuento: String? = nil,
        categoria: String,
        imagenURL: String,
        etiqueta: String? = nil
    ) {
        self.id = id
        self.nombre = nombre
        self.descripcion = descripcion
        self.precio = precio
        self.precioAnterior = precioAnterior
        self.descuento = descuento
        self.categoria = categoria
        self.imagenURL = imagenURL
        self.etiqueta = etiqueta
    }
}

typealias ItemModel = Producto
