import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../modelo/personaje_modelo.dart';

class PersonajeControlador {
  final String _claveLista = 'lista_personajes';

  // Obtener personajes desde la API de Rick and Morty
  Future<List<Personaje>> obtenerPersonajesDeApi() async {
    try {
      final response = await http.get(Uri.parse('https://rickandmortyapi.com/api/character'));

      if (response.statusCode == 200) {
        print('Si carga los datos desde la API');
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> personajesJson = data['results'];


        // Guardamos los personajes en SharedPreferences
        await guardarPersonajesDesdeApi(personajesJson);

        return personajesJson.map((json) => Personaje.fromJson(json)).toList();
      } else {
        print('No carga los datos desde la API');
        throw Exception('Error al cargar personajes desde la API');
      }
    } catch (e) {
      print('Error al conectar con la API: $e');
      rethrow;
    }
  }

  // Guardar personajes desde la API en SharedPreferences
  Future<void> guardarPersonajesDesdeApi(List<dynamic> personajesJson) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _claveLista,
      json.encode(personajesJson.map((e) => Personaje.fromJson(e).toJson()).toList()),
    );
    print('Personajes guardados en SharedPreferences');
  }

  // Obtener personajes desde SharedPreferences
  Future<List<Personaje>> obtenerPersonajes() async {
    //await obtenerPersonajesDeApi(); // Esperar el resultado de la API
    final prefs = await SharedPreferences.getInstance();
    final String? datos = prefs.getString(_claveLista);

    if (datos == null || datos.isEmpty) {
      print('No hay datos en SharedPreferences');
      return [];
    }

    final List<dynamic> listaDecodificada = json.decode(datos);
    return listaDecodificada.map((json) => Personaje.fromJson(json)).toList();
  }

  // Guardar personajes en SharedPreferences
  Future<void> guardarPersonajes(List<Personaje> personajes) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _claveLista,
      json.encode(personajes.map((e) => e.toJson()).toList()),
    );
    print('Datos guardados correctamente');
  }

  // Agregar un personaje
  Future<void> agregarPersonaje(Personaje personaje) async {
    final lista = await obtenerPersonajes();
    lista.add(personaje);
    await guardarPersonajes(lista);
  }

  // Eliminar un personaje
  Future<void> eliminarPersonaje(String id) async {
    final lista = await obtenerPersonajes();
    final nuevaLista = lista.where((personaje) => personaje.id != id).toList();
    await guardarPersonajes(nuevaLista);
  }

  // Actualizar un personaje
  Future<void> actualizarPersonaje(Personaje personajeActualizado) async {
    final lista = await obtenerPersonajes();
    final nuevaLista = lista.map((personaje) {
      if (personaje.id == personajeActualizado.id) {
        return personajeActualizado;
      }
      return personaje;
    }).toList();
    await guardarPersonajes(nuevaLista);
  }
}
