import SwiftUI

struct TarjetaProducto: View {
    let producto: Producto

    private var precioTexto: String {
        String(format: "%.2f", producto.precio)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .topTrailing) {
                AsyncImage(url: URL(string: producto.imagenURL)) { phase in
                    if let image = phase.image {
                        image.resizable().scaledToFill()
                    } else if phase.error != nil {
                        Color(ColoresBembos.grisSuave)
                            .overlay(Image(systemName: "photo").font(.largeTitle).foregroundColor(.gray))
                    } else {
                        ProgressView()
                    }
                }
                .frame(width: 220, height: 160)
                .clipped()

                if let etiqueta = producto.etiqueta {
                    Text(etiqueta)
                        .font(.system(size: 10, weight: .heavy))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 5)
                        .background(etiqueta.contains("BOMBA") ? ColoresBembos.rojoPrincipal : ColoresBembos.azulMarca)
                        .clipShape(Capsule())
                        .padding(8)
                }

                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Text("Cyber\nBembos")
                            .font(.system(size: 10, weight: .black))
                            .italic()
                            .foregroundStyle(ColoresBembos.azulMarca.opacity(0.6))
                            .multilineTextAlignment(.trailing)
                            .padding(6)
                    }
                }
            }

            VStack(alignment: .leading, spacing: 6) {
                HStack(alignment: .top) {
                    Text(producto.nombre)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(ColoresBembos.textoOscuro)
                        .lineLimit(1)

                    Spacer()

                    Button { print("Favorito") } label: {
                        Image(systemName: "heart")
                            .font(.system(size: 16))
                            .foregroundStyle(ColoresBembos.rojoPrincipal)
                    }
                }

                Text(producto.descripcion)
                    .font(.system(size: 12))
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
                    .frame(height: 34, alignment: .top)

                HStack(alignment: .bottom) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("S/ \(precioTexto)")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundStyle(ColoresBembos.textoOscuro)

                        if let anterior = producto.precioAnterior {
                            let precioAnteriorTexto = String(format: "%.2f", anterior)
                            HStack(spacing: 4) {
                                Text("S/ \(precioAnteriorTexto)")
                                    .font(.system(size: 11))
                                    .strikethrough()
                                    .foregroundStyle(.secondary)

                                if let descuento = producto.descuento {
                                    Text(descuento)
                                        .font(.system(size: 9, weight: .bold))
                                        .foregroundStyle(.white)
                                        .padding(.horizontal, 4)
                                        .padding(.vertical, 2)
                                        .background(ColoresBembos.rojoPrincipal)
                                        .clipShape(RoundedRectangle(cornerRadius: 4))
                                }
                            }
                        }
                    }

                    Spacer()

                    Button { print("Agregar") } label: {
                        Image(systemName: "plus")
                            .foregroundStyle(.white)
                            .font(.system(size: 16, weight: .bold))
                            .frame(width: 36, height: 36)
                            .background(ColoresBembos.azulMarca)
                            .clipShape(Circle())
                    }
                }
                .padding(.top, 4)
            }
            .padding(12)
        }
        .frame(width: 220)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(ColoresBembos.amarilloPrincipal.opacity(0.6), lineWidth: 1.5)
        )
        .shadow(color: Color.black.opacity(0.08), radius: 10, x: 0, y: 5)
    }
}

