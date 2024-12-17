class Personaje {
  String id;
  String nombre;
  String imagen;
  String estado;
  String especie;

  Personaje({
    required this.id,
    required this.nombre,
    required this.imagen,
    required this.estado,
    required this.especie,
  });

  factory Personaje.fromJson(Map<String, dynamic> json) {
    return Personaje(
      id: json['id'].toString(),
      nombre: json['name'] ?? 'Sin Nombre',
      imagen: json['image'] ?? '',
      estado: json['status'] ?? 'Desconocido',
      especie: json['species'] ?? 'Desconocida',
    );
  }

  // Agrega este método toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': nombre,
      'image': imagen,
      'status': estado,
      'species': especie,
    };
  }


}
