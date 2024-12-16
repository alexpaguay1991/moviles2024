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
  late int verificador=0;

  @override
  void initState() {
    super.initState();
    _personajes = [];


    //_cargarPersonajes();
    _cargarVerificador();
  }

  // Cargar el valor de 'verificador' desde SharedPreferences
  Future<void> _cargarVerificador() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      verificador = prefs.getInt('verificador') ?? 0;
    });
    _cargarPersonajes(); // Llama a cargar personajes una vez que el verificador ha sido leído

  }

  // Guardar el valor de 'verificador' en SharedPreferences
  Future<void> _guardarVerificador(int valor) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('verificador', valor);
  }

  // Cargar personajes desde la memoria local
  Future<void> _cargarPersonajes() async {
    if (verificador < 1) {
      await _controlador.obtenerPersonajesDeApi(); // Solo se ejecuta si 'verificador' es menor a 1
      await _guardarVerificador(1); // Actualiza el verificador para que no vuelva a recargar desde la API
    }

    final listaLocal = await _controlador.obtenerPersonajes();
    print('Datos cargados a memoria: $listaLocal');
    print('Codigo: $verificador'); // Imprime los datos obtenidos
    setState(() {
      _personajes = listaLocal;
    });
  }

  // Agregar un nuevo personaje
  Future<void> _agregarPersonaje() async {
    final TextEditingController nombreController = TextEditingController();
    final TextEditingController imagenController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Agregar Personaje'),
          content: Column(
            children: [
              TextField(
                controller: nombreController,
                decoration: const InputDecoration(hintText: 'Nombre'),
              ),
              TextField(
                controller: imagenController,
                decoration: const InputDecoration(hintText: 'URL Imagen'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                final nuevoPersonaje = Personaje(
                  id: DateTime.now().toString(),
                  nombre: nombreController.text,
                  imagen: imagenController.text,
                );
                await _controlador.agregarPersonaje(nuevoPersonaje);
                await _cargarPersonajes();
                Navigator.pop(context);
              },
              child: const Text('Agregar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  // Actualizar un personaje
  Future<void> _actualizarPersonaje(Personaje personaje) async {
    final TextEditingController nombreController = TextEditingController(text: personaje.nombre);
    final TextEditingController imagenController = TextEditingController(text: personaje.imagen);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Actualizar Personaje'),
          content: Column(
            children: [
              TextField(
                controller: nombreController,
                decoration: const InputDecoration(hintText: 'Nombre'),
              ),
              TextField(
                controller: imagenController,
                decoration: const InputDecoration(hintText: 'URL Imagen'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                final personajeActualizado = Personaje(
                  id: personaje.id,
                  nombre: nombreController.text,
                  imagen: imagenController.text,
                );
                await _controlador.actualizarPersonaje(personajeActualizado);
                await _cargarPersonajes();
                Navigator.pop(context);
              },
              child: const Text('Actualizar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  // Confirmación de eliminación
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
              child: const Text('Eliminar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
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
        title: const Text('Personajes Locales'),
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
                gradient: LinearGradient(
                  colors: [Colors.blueAccent, Colors.purpleAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
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
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  leading: personaje.imagen.isNotEmpty
                      ? Image.network(personaje.imagen)
                      : Icon(Icons.person, size: 40),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _actualizarPersonaje(personaje),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
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
        child: const Icon(Icons.add),
      ),
    );
  }
}