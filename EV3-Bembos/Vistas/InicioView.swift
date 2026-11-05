import SwiftUI
import Combine

struct InicioView: View {
    @StateObject private var viewModel = InicioViewModel()
    @EnvironmentObject private var sesion: SesionViewModel

    @State private var timeRemaining: TimeInterval = TimeInterval.random(in: 3600...86400)
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                ColoresBembos.fondoClaro.ignoresSafeArea()

                VStack(spacing: 0) {
                    encabezadoSuperior()

                    ScrollView {
                        VStack(spacing: 24) {
                            barraBusqueda()
                            bannerPromocionalGrande()

                            VStack(spacing: 12) {
                                HStack {
                                    Text("EXPLORA NUESTRO MENÚ")
                                        .font(.system(size: 14, weight: .bold))
                                        .foregroundStyle(ColoresBembos.textoOscuro)
                                    Spacer()
                                    Text("Ver todo")
                                        .font(.system(size: 13, weight: .semibold))
                                        .foregroundStyle(ColoresBembos.azulMarca)
                                        .underline()
                                }
                                .padding(.horizontal, 24)

                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 16) {
                                        ForEach(["Promos exclusivas", "Combos", "Hamburguesas", "Menús bembos", "Complementos"], id: \.self) { categoria in
                                            VStack(spacing: 8) {
                                                Circle()
                                                    .fill(ColoresBembos.blanco)
                                                    .frame(width: 70, height: 70)
                                                    .overlay(
                                                        Image(systemName: "fork.knife")
                                                            .foregroundStyle(ColoresBembos.azulMarca.opacity(0.4))
                                                            .font(.system(size: 24))
                                                    )
                                                    .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 3)

                                                Text(categoria)
                                                    .font(.system(size: 11, weight: .semibold))
                                                    .foregroundStyle(ColoresBembos.textoOscuro)
                                                    .multilineTextAlignment(.center)
                                                    .frame(width: 80)
                                            }
                                        }
                                    }
                                    .padding(.horizontal, 24)
                                }
                            }

                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 10) {
                                    Text("Todos")
                                        .font(.system(size: 13, weight: .bold))
                                        .foregroundStyle(.white)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 8)
                                        .background(ColoresBembos.azulMarca)
                                        .clipShape(Capsule())

                                    ForEach(["Cyber bembos", "Promociones para 2", "Promociones personales"], id: \.self) { filtro in
                                        Text(filtro)
                                            .font(.system(size: 13, weight: .semibold))
                                            .foregroundStyle(ColoresBembos.textoOscuro)
                                            .padding(.horizontal, 16)
                                            .padding(.vertical, 8)
                                            .background(Color.white)
                                            .clipShape(Capsule())
                                            .overlay(Capsule().stroke(ColoresBembos.grisMedio.opacity(0.5), lineWidth: 1))
                                    }
                                }
                                .padding(.horizontal, 24)
                            }

                            VStack(spacing: 12) {
                                HStack {
                                    Text("Recomendados para ti")
                                        .font(.system(size: 18, weight: .bold))
                                        .foregroundStyle(ColoresBembos.textoOscuro)
                                    Spacer()
                                }
                                .padding(.horizontal, 24)

                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 16) {
                                        ForEach(viewModel.itemsFiltrados) { producto in
                                            NavigationLink(value: producto) {
                                                TarjetaProducto(producto: producto)
                                            }
                                            .buttonStyle(.plain)
                                        }
                                    }
                                    .padding(.horizontal, 24)
                                    .padding(.vertical, 5)
                                }
                            }

                            VStack(spacing: 12) {
                                HStack {
                                    Text("Los más vendidos")
                                        .font(.system(size: 18, weight: .bold))
                                        .foregroundStyle(ColoresBembos.textoOscuro)
                                    Spacer()
                                }
                                .padding(.horizontal, 24)

                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 16) {
                                        ForEach(viewModel.itemsFiltrados.reversed()) { producto in
                                            NavigationLink(value: producto) {
                                                TarjetaProducto(producto: producto)
                                            }
                                            .buttonStyle(.plain)
                                        }
                                    }
                                    .padding(.horizontal, 24)
                                    .padding(.vertical, 5)
                                }
                            }

                            VStack {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(ColoresBembos.fondoPromocion)
                                        .frame(height: 120)

                                    HStack {
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text("DALE SABOR A TUS")
                                                .font(.system(size: 12, weight: .bold))
                                                .foregroundStyle(ColoresBembos.rojoPrincipal)
                                            Text("EVENTOS")
                                                .font(.system(size: 24, weight: .black))
                                                .italic()
                                                .foregroundStyle(ColoresBembos.azulMarca)
                                            Text("¡COTIZA AQUÍ!")
                                                .font(.system(size: 10, weight: .bold))
                                                .foregroundStyle(.white)
                                                .padding(.horizontal, 8)
                                                .padding(.vertical, 4)
                                                .background(ColoresBembos.azulMarca)
                                        }
                                        Spacer()
                                        AsyncImage(url: URL(string: "https://www.bembos.com.pe/media/wysiwyg/bembos/CategoriasAsociadasBB/MOBILE.webp")) { phase in
                                            if let image = phase.image {
                                                image
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 140, height: 60)
                                            } else {
                                                Image(systemName: "car.side.fill")
                                                    .font(.system(size: 50))
                                                    .foregroundStyle(ColoresBembos.azulMarca.opacity(0.6))
                                            }
                                        }
                                    }
                                    .padding(.horizontal, 20)
                                }
                                .padding(.horizontal, 24)
                            }
                            .padding(.bottom, 30)
                        }
                        .padding(.top, 16)
                    }
                }
            }
            .navigationDestination(for: Producto.self) { producto in
                DetalleProductoView(producto: producto)
            }
            .navigationBarHidden(true)
            .onReceive(timer) { _ in
                if timeRemaining > 0 { timeRemaining -= 1 }
            }
        }
    }

    private func encabezadoSuperior() -> some View {
        ZStack(alignment: .bottomLeading) {
            ColoresBembos.azulMarca.frame(height: 90).ignoresSafeArea(edges: .top)
            HStack {
                Image(systemName: "person.circle.fill").font(.system(size: 28)).foregroundStyle(.white)
                Spacer()
                Button { sesion.cerrarSesion() } label: {
                    Text("Salir").font(.system(size: 12, weight: .bold)).foregroundStyle(ColoresBembos.azulMarca)
                        .padding(.horizontal, 12).padding(.vertical, 6).background(Color.white).clipShape(Capsule())
                }
                Button { print("Carrito") } label: {
                    Image(systemName: "cart.fill").font(.system(size: 16, weight: .bold)).foregroundStyle(ColoresBembos.azulMarca)
                        .frame(width: 36, height: 36).background(ColoresBembos.amarilloPrincipal).clipShape(Circle())
                }
            }
            .padding(.horizontal, 24).padding(.bottom, 12)
        }
    }

    private func barraBusqueda() -> some View {
        HStack(spacing: 8) {
            HStack {
                Image(systemName: "magnifyingglass").foregroundStyle(ColoresBembos.grisMedio)
                TextField("¿Qué quieres hoy?", text: $viewModel.textoBusqueda).font(.system(size: 14))
                Image(systemName: "mic.fill").foregroundStyle(ColoresBembos.grisMedio)
            }
            .padding(.horizontal, 16).frame(height: 44).background(Color.white).clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(RoundedRectangle(cornerRadius: 12).stroke(ColoresBembos.grisMedio.opacity(0.5), lineWidth: 1))
        }
        .padding(.horizontal, 24)
    }

    private func bannerPromocionalGrande() -> some View {
        VStack(spacing: 10) {
            AsyncImage(url: URL(string: "https://www.bembos.com.pe/media/wysiwyg/bembos/CategoriasAsociadasBB/MOBILE.webp")) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFill()
                } else if phase.error != nil {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(LinearGradient(colors: [ColoresBembos.azulOscuro, ColoresBembos.azulMarca], startPoint: .topLeading, endPoint: .bottomTrailing))
                } else {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(LinearGradient(colors: [ColoresBembos.azulOscuro, ColoresBembos.azulMarca], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .overlay(ProgressView())
                }
            }
            .frame(height: 110)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.black.opacity(0.06), lineWidth: 1)
            )

            HStack(spacing: 10) {
                timeBox(value: calcularTiempo().dias, label: "Días")
                Text(":" ).font(.system(size: 16, weight: .bold)).foregroundStyle(ColoresBembos.textoOscuro)
                timeBox(value: calcularTiempo().horas, label: "Hrs")
                Text(":" ).font(.system(size: 16, weight: .bold)).foregroundStyle(ColoresBembos.textoOscuro)
                timeBox(value: calcularTiempo().minutos, label: "Min")
                Text(":" ).font(.system(size: 16, weight: .bold)).foregroundStyle(ColoresBembos.textoOscuro)
                timeBox(value: calcularTiempo().segundos, label: "Seg")
            }
        }
        .padding(.horizontal, 24)
    }

    private func timeBox(value: String, label: String) -> some View {
        VStack(spacing: 2) {
            Text(value).font(.system(size: 18, weight: .bold)).foregroundStyle(.white)
            Text(label).font(.system(size: 9, weight: .medium)).foregroundStyle(.white.opacity(0.8))
        }
        .frame(width: 50, height: 50).background(ColoresBembos.azulMarca).clipShape(RoundedRectangle(cornerRadius: 10))
    }

    private func calcularTiempo() -> (dias: String, horas: String, minutos: String, segundos: String) {
        let dias = Int(timeRemaining) / 86400
        let horas = (Int(timeRemaining) % 86400) / 3600
        let minutos = (Int(timeRemaining) % 3600) / 60
        let segundos = Int(timeRemaining) % 60
        return (String(format: "%02d", dias), String(format: "%02d", horas), String(format: "%02d", minutos), String(format: "%02d", segundos))
    }
}

