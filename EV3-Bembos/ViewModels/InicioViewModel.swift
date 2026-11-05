import Foundation
import Combine

@MainActor
final class InicioViewModel: ObservableObject {
    @Published var items: [ItemModel]
    @Published var textoBusqueda: String = ""

    init() {
        let productosBembos: [(nombre: String, descripcion: String, precio: Double, categoria: String, imagenURL: String, etiqueta: String, precioAnterior: Double?, descuento: String?)] = [
            ("Dúo Sabroso", "Combo irresistible para compartir con una experiencia Bembos completa.", 18.90, "Promociones", "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=900&q=80", "PROMO", 27.80, "-32%"),
            ("Dúo Queso Tocino", "Doble sabor con queso, tocino y la esencia de Bembos.", 21.90, "Promociones", "https://images.unsplash.com/photo-1550547660-d9450f859349?auto=format&fit=crop&w=900&q=80", "PROMO", 31.50, "-30%"),
            ("Personal Clásica", "La hamburguesa esencial, sabrosa y siempre satisfactoria.", 14.90, "Hamburguesas", "https://images.unsplash.com/photo-1550317138-10000687a72b?auto=format&fit=crop&w=900&q=80", "TOP", 19.90, "-25%"),
            ("Trío Futbolero", "Tres opciones para disfrutar con amigos y sentirse en la cancha.", 26.90, "Combos", "https://images.unsplash.com/photo-1604908176997-125f25cc6f3d?auto=format&fit=crop&w=900&q=80", "BOMBA", 34.20, "-21%"),
            ("Familiar Perfecto", "Ideal para compartir en familia y disfrutar una buena comida.", 32.90, "Combos", "https://images.unsplash.com/photo-1520072959219-c595dc870360?auto=format&fit=crop&w=900&q=80", "FAMILIA", 42.50, "-23%"),
            ("Cyber Personal", "La versión más intensa con sabor y textura premium.", 16.90, "Cyber", "https://images.unsplash.com/photo-1544025162-d76694265947?auto=format&fit=crop&w=900&q=80", "NUEVO", 22.90, "-26%"),
            ("Cyber Extrema", "Maxi sabor con doble proteína y crocante extra.", 23.90, "Cyber", "https://images.unsplash.com/photo-1571091718767-18b5b1457add?auto=format&fit=crop&w=900&q=80", "PREMIUM", 29.90, "-20%"),
            ("Cyber Dúo", "Para dos, con sabor intenso y porción completa.", 25.90, "Cyber", "https://images.unsplash.com/photo-1561758033-d89a9ad46330?auto=format&fit=crop&w=900&q=80", "NUEVO", 33.90, "-24%"),
            ("Cyber para compartir", "Perfecto para compartir y disfrutar entre varias personas.", 29.90, "Cyber", "https://images.unsplash.com/photo-1512152272829-e3139592d56f?auto=format&fit=crop&w=900&q=80", "COMPARTIR", 39.90, "-25%"),
            ("Martes y Jueves", "Promoción especial para tus días favoritos.", 19.90, "Promociones", "https://images.unsplash.com/photo-1525059696034-4967a729002e?auto=format&fit=crop&w=900&q=80", "PROMO", 27.50, "-28%"),
            ("Combo Power", "Potencia y sabor para quienes quieren comer bien.", 28.90, "Combos", "https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=900&q=80", "POWER", 37.80, "-24%"),
            ("Personal Churrita", "Una hamburguesa suave, sabrosa y muy recomendada.", 17.90, "Hamburguesas", "https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?auto=format&fit=crop&w=900&q=80", "HOT", 24.90, "-28%"),
            ("Promo Doble Queso Tocino", "Doble queso, tocino y sabor extremo en cada mordida.", 22.90, "Promociones", "https://images.unsplash.com/photo-1526234427925-df2d7c35c2f5?auto=format&fit=crop&w=900&q=80", "PROMO", 32.40, "-29%"),
            ("Dúo Imperdible", "Especial para quienes quieren un combo contundente.", 24.90, "Combos", "https://images.unsplash.com/photo-1530554764233-e79e16c91d08?auto=format&fit=crop&w=900&q=80", "BOMBA", 31.60, "-21%"),
            ("Combo Royal", "Combo premium con sabor clásico y textura impecable.", 31.90, "Premium", "https://images.unsplash.com/photo-1590080874102-4398b2f2f961?auto=format&fit=crop&w=900&q=80", "ROYAL", 39.90, "-20%"),
            ("Salchipapa", "Crujiente, sabrosa y perfecta para compartir.", 11.90, "Complementos", "https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?auto=format&fit=crop&w=900&q=80", "POPULAR", 15.90, "-25%"),
            ("Hamburguesa A lo Pobre", "Sabor casero con la esencia tradicional de la cocina peruana.", 13.90, "Especiales", "https://images.unsplash.com/photo-1555949258-eb67b1ef0ceb?auto=format&fit=crop&w=900&q=80", "CLÁSICO", 18.90, "-26%"),
            ("Combo Extrema", "La versión extrema del sabor Bembos para paladares exigentes.", 35.90, "Premium", "https://images.unsplash.com/photo-1626700051175-6818013e1d4f?auto=format&fit=crop&w=900&q=80", "EXTREMO", 44.90, "-20%"),
            ("Combo Mexicana", "Sabor intenso con una mezcla vibrante y muy deliciosa.", 30.90, "Especiales", "https://images.unsplash.com/photo-1553979459-d2229ba7433b?auto=format&fit=crop&w=900&q=80", "MEXICANA", 39.80, "-22%"),
            ("Loncherita por la educación - Sundae Hamburguesa", "La opción ideal para quienes buscan sabor y valor.", 12.90, "Loncheritas", "https://images.unsplash.com/photo-1586190848861-99aa4a171e90?auto=format&fit=crop&w=900&q=80", "EDUCACIÓN", 17.90, "-28%"),
            ("Loncherita por la educación - Sundae Nuggets", "Crujiente y divertida para cualquier horario del día.", 11.90, "Loncheritas", "https://images.unsplash.com/photo-1626645738196-c2a7c87a8f58?auto=format&fit=crop&w=900&q=80", "EDUCACIÓN", 16.90, "-29%"),
            ("Dúo Futbolero", "Combinación popular para disfrutar con sabor y energía.", 20.90, "Promociones", "https://images.unsplash.com/photo-1552566626-52f8b828add9?auto=format&fit=crop&w=900&q=80", "PROMO", 28.40, "-26%"),
            ("Compartir Extremo", "Para disfrutar en grupo con sabor de temporada.", 26.90, "Compartir", "https://images.unsplash.com/photo-1559847844-5315695dadae?auto=format&fit=crop&w=900&q=80", "EXTREMO", 34.50, "-22%")
        ]

        self.items = productosBembos.map {
            ItemModel(
                nombre: $0.nombre,
                descripcion: $0.descripcion,
                precio: $0.precio,
                precioAnterior: $0.precioAnterior,
                descuento: $0.descuento,
                categoria: $0.categoria,
                imagenURL: $0.imagenURL,
                etiqueta: $0.etiqueta
            )
        }
    }

    var itemsFiltrados: [ItemModel] {
        if textoBusqueda.isEmpty {
            return items
        }

        return items.filter {
            $0.nombre.lowercased().contains(textoBusqueda.lowercased())
                || $0.descripcion.lowercased().contains(textoBusqueda.lowercased())
                || $0.categoria.lowercased().contains(textoBusqueda.lowercased())
        }
    }
}
