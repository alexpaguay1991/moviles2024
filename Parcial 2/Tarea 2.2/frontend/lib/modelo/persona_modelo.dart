class Persona {
  final String id;
  final String nombre;
  final String apellido;
  final String telefono;

  Persona({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.telefono,
  });

  factory Persona.fromJson(Map<String, dynamic> json) {
    return Persona(
      id: json['_id'],
      nombre: json['nombre'],
      apellido: json['apellido'],
      telefono: json['telefono'],
    );
  }}
