import 'dart:convert';
import 'package:http/http.dart' as http;
import '/modelo/persona_modelo.dart';

class PersonaControlador {
  final String url = 'http://localhost:5000/api/personas';

  // Obtener todas las personas
  Future<List<Persona>> obtenerPersonas() async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((personaJson) => Persona.fromJson(personaJson)).toList();
      } else {
        throw Exception('Error al cargar personas');
      }
    } catch (e) {
      throw Exception('Error al cargar personas: $e');
    }
  }

  //Crear personas
  Future<void> crearPersona(String nombre, String apellido, String telefono) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'nombre': nombre,
          'apellido': apellido,
          'telefono': telefono,
        }),
      );

      // Verificar la respuesta
      print('Respuesta: ${response.statusCode}');
      print('Cuerpo: ${response.body}');

      if (response.statusCode != 201) {
        throw Exception('Error al crear persona');
      }
    } catch (e) {
      print('Error al crear persona: $e');
      throw Exception('Error al crear persona: $e');
    }
  }


  // Actualizar una persona
  Future<void> actualizarPersona(String id, String nombre, String apellido, String telefono) async {
    final response = await http.put(
      Uri.parse('$url/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'nombre': nombre,
        'apellido': apellido,
        'telefono': telefono,
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Error al actualizar persona');
    }
  }

  // Eliminar una persona
  Future<void> eliminarPersona(String id) async {
    final response = await http.delete(Uri.parse('$url/$id'));
    if (response.statusCode != 200) {
      throw Exception('Error al eliminar persona');
    }
  }
}
