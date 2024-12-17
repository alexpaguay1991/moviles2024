import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controlador/personaje_controlador.dart';
import '../modelo/personaje_modelo.dart';

class VistaPersonajes extends StatefulWidget {
  @override
  _VistaPersonajesState createState() => _VistaPersonajesState();
}

class _VistaPersonajesState extends State<VistaPersonajes> {
  final PersonajeControlador _controlador = PersonajeControlador();
  late List<Personaje> _personajes;
  late int verificador = 0;

  @override
  void initState() {
    super.initState();
    _personajes = [];
    _cargarVerificador();
  }

  Future<void> _cargarVerificador() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      verificador = prefs.getInt('verificador') ?? 0;
    });
    _cargarPersonajes();
  }

  Future<void> _guardarVerificador(int valor) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('verificador', valor);
  }

  Future<void> _cargarPersonajes() async {
    if (verificador < 1) {
      await _controlador.obtenerPersonajesDeApi();
      await _guardarVerificador(1);
    }
    final listaLocal = await _controlador.obtenerPersonajes();
    setState(() {
      _personajes = listaLocal;
    });
  }

  Future<void> _agregarPersonaje() async {
    final TextEditingController nombreController = TextEditingController();
    final TextEditingController imagenController = TextEditingController();
    final TextEditingController estadoController = TextEditingController();
    final TextEditingController especieController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Agregar Personaje',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _crearCampoTexto(nombreController, 'Nombre del Personaje'),
              _crearCampoTexto(imagenController, 'URL de Imagen'),
              _crearCampoTexto(estadoController, 'Estado (Alive/Dead)'),
              _crearCampoTexto(especieController, 'Especie del Personaje'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                final nuevoPersonaje = Personaje(
                  id: DateTime.now().toString(),
                  nombre: nombreController.text,
                  imagen: imagenController.text,
                  estado: estadoController.text,
                  especie: especieController.text,
                );
                await _controlador.agregarPersonaje(nuevoPersonaje);
                await _cargarPersonajes();
                Navigator.pop(context);
              },
              child: const Text('Agregar', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  Future<void> _actualizarPersonaje(Personaje personaje) async {
    final TextEditingController nombreController = TextEditingController(text: personaje.nombre);
    final TextEditingController imagenController = TextEditingController(text: personaje.imagen);
    final TextEditingController estadoController = TextEditingController(text: personaje.estado);
    final TextEditingController especieController = TextEditingController(text: personaje.especie);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Actualizar Personaje',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _crearCampoTexto(nombreController, 'Nombre del Personaje'),
              _crearCampoTexto(imagenController, 'URL de Imagen'),
              _crearCampoTexto(estadoController, 'Estado (Alive/Dead)'),
              _crearCampoTexto(especieController, 'Especie del Personaje'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                final personajeActualizado = Personaje(
                  id: personaje.id,
                  nombre: nombreController.text,
                  imagen: imagenController.text,
                  estado: estadoController.text,
                  especie: especieController.text,
                );
                await _controlador.actualizarPersonaje(personajeActualizado);
                await _cargarPersonajes();
                Navigator.pop(context);
              },
              child: const Text('Actualizar', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  Widget _crearCampoTexto(TextEditingController controller, String labelText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.blue),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.blue),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.blueAccent),
          ),
        ),
      ),
    );
  }

  Future<void> _eliminarPersonaje(String id) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Eliminación'),
          content: const Text('¿Estás seguro de que quieres eliminar este personaje?'),
          actions: [
            TextButton(
              onPressed: () async {
                await _controlador.eliminarPersonaje(id);
                await _cargarPersonajes();
                Navigator.pop(context);
              },
              child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar', style: TextStyle(color: Colors.blue)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Rick & Morty',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: _personajes.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _personajes.length,
        itemBuilder: (context, index) {
          final personaje = _personajes[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.blue,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                  ),
                ],
              ),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  title: Text(
                    personaje.nombre,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            personaje.estado == 'Alive'
                                ? Icons.circle
                                : Icons.circle_outlined,
                            color: personaje.estado == 'Alive'
                                ? Colors.green
                                : Colors.red,
                            size: 14,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "Estado: ${personaje.estado}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: personaje.estado == 'Alive'
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Especie: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(personaje.especie),
                    ],
                  ),
                  leading: personaje.imagen.isNotEmpty
                      ? Image.network(personaje.imagen, width: 100, height: 100)
                      : const Icon(Icons.person, size: 100, color: Colors.white),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => _actualizarPersonaje(personaje),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _eliminarPersonaje(personaje.id),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _agregarPersonaje,
        tooltip: 'Agregar Personaje',
        child: const Icon(Icons.add),
      ),
    );
  }
}
