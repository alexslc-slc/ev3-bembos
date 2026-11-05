import SwiftUI

struct DetalleProductoView: View {
    let producto: Producto

    private var precioTexto: String {
        String(format: "%.2f", producto.precio)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ZStack(alignment: .topTrailing) {
                    AsyncImage(url: URL(string: producto.imagenURL)) { phase in
                        if let image = phase.image {
                            image.resizable().scaledToFill()
                        } else {
                            Color(ColoresBembos.grisSuave)
                        }
                    }
                    .frame(height: 260)
                    .clipShape(RoundedRectangle(cornerRadius: 20))

                    if let etiqueta = producto.etiqueta {
                        Text(etiqueta)
                            .font(.system(size: 12, weight: .heavy))
                            .foregroundStyle(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(ColoresBembos.rojoPrincipal)
                            .clipShape(Capsule())
                            .padding(16)
                    }
                }

                Text(producto.nombre)
                    .font(.system(size: 26, weight: .bold))
                    .foregroundStyle(ColoresBembos.textoOscuro)

                HStack {
                    Text("S/ \(precioTexto)")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(ColoresBembos.azulMarca)

                    Spacer()

                    Button {
                        print("Agregar al carrito")
                    } label: {
                        Image(systemName: "plus")
                            .foregroundStyle(.white)
                            .font(.system(size: 20, weight: .bold))
                            .frame(width: 48, height: 48)
                            .background(ColoresBembos.azulMarca)
                            .clipShape(Circle())
                    }
                }

                Text(producto.descripcion)
                    .font(.system(size: 15))
                    .foregroundStyle(.secondary)

                VStack(spacing: 12) {
                    EtiquetaDetalle(titulo: "Categoría", valor: producto.categoria)
                    EtiquetaDetalle(titulo: "Tiempo estimado", valor: "20-30 min")
                    EtiquetaDetalle(titulo: "Calificación", valor: "4.8/5")
                }

                Button {
                    print("Agregar pedido")
                } label: {
                    Text("Agregar al pedido")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: 300)
                        .frame(height: 48)
                        .background(ColoresBembos.azulMarca)
                        .clipShape(Capsule())
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 10)
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 16)
        }
        .background(ColoresBembos.fondoClaro.ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct EtiquetaDetalle: View {
    let titulo: String
    let valor: String

    var body: some View {
        HStack {
            Text(titulo).font(.system(size: 14, weight: .semibold)).foregroundStyle(.secondary)
            Spacer()
            Text(valor).font(.system(size: 14, weight: .bold)).foregroundStyle(ColoresBembos.textoOscuro)
        }
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

