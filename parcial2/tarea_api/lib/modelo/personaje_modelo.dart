class Personaje {
  final String id;
  final String nombre;
  final String imagen;

  Personaje({required this.id, required this.nombre, required this.imagen});

  factory Personaje.fromJson(Map<String, dynamic> json) {
    return Personaje(
      id: json['id'].toString(),
      nombre: json['name'] ?? 'Sin Nombre',
      imagen: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': nombre,
      'image': imagen,
    };
  }
}
