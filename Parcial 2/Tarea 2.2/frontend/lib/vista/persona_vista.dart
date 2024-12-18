import 'package:flutter/material.dart';
import '../controlador/persona_controlador.dart';
import '../modelo/persona_modelo.dart';

class PersonaVista extends StatefulWidget {
  @override
  _PersonaVistaState createState() => _PersonaVistaState();
}

class _PersonaVistaState extends State<PersonaVista> {
  late Future<List<Persona>> _personas;

  @override
  void initState() {
    super.initState();
    _personas = PersonaControlador().obtenerPersonas();
  }

  void _mostrarFormularioPersona({Persona? persona}) {
    final nombreController = TextEditingController(text: persona?.nombre ?? '');
    final apellidoController = TextEditingController(text: persona?.apellido ?? '');
    final telefonoController = TextEditingController(text: persona?.telefono ?? '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(persona == null ? 'Agregar Persona' : 'Editar Persona'),
          backgroundColor: Colors.grey[200],
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nombreController,
                decoration: InputDecoration(labelText: 'Nombre'),
              ),
              TextField(
                controller: apellidoController,
                decoration: InputDecoration(labelText: 'Apellido'),
              ),
              TextField(
                controller: telefonoController,
                decoration: InputDecoration(labelText: 'Teléfono'),
                keyboardType: TextInputType.phone,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(backgroundColor: Colors.red),
              child: Text('Cancelar', style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () async {
                if (persona == null) {
                  await PersonaControlador().crearPersona(
                    nombreController.text,
                    apellidoController.text,
                    telefonoController.text,
                  );
                } else {
                  await PersonaControlador().actualizarPersona(
                    persona.id,
                    nombreController.text,
                    apellidoController.text,
                    telefonoController.text,
                  );
                }
                setState(() {
                  _personas = PersonaControlador().obtenerPersonas();
                });
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(backgroundColor: Colors.blue),
              child: Text(persona == null ? 'Agregar' : 'Actualizar', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _confirmarEliminacion(String id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Confirmar eliminación"),
          content: Text("¿Estás seguro de que deseas eliminar este contacto?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el cuadro de diálogo
              },
              child: Text("Cancelar", style: TextStyle(color: Colors.green)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el cuadro de diálogo
                _eliminarPersona(id); // Llama a la función para eliminar
              },
              child: Text("Eliminar", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _eliminarPersona(String id) async {
    await PersonaControlador().eliminarPersona(id);
    setState(() {
      _personas = PersonaControlador().obtenerPersonas();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CONTACTOS',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.green[100],
        child: Column(
          children: [
            SizedBox(height: 20), // Espacio extra para separar la imagen del AppBar
            CircleAvatar(
              radius: 80,
              backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSlfsub3QM8t8XPIzE6la4VpkPBKAenhtgoyg&s'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<Persona>>(
                future: _personas,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No hay personas para mostrar.'));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        Persona persona = snapshot.data![index];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                          color: Colors.orange[100],
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.green[800]!, width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.green[200], // Color verde pastel para destacar
                              child: persona.nombre != null
                                  ? Text(
                                persona.nombre![0].toUpperCase(),
                                style: TextStyle(fontSize: 20, color: Colors.white),
                              )
                                  : Icon(Icons.person, color: Colors.white),
                            ),
                            title: Text('${persona.nombre} ${persona.apellido}', style: TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text(persona.telefono),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit, color: Colors.green[300]),
                                  onPressed: () {
                                    _mostrarFormularioPersona(persona: persona);
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    _confirmarEliminacion(persona.id);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _mostrarFormularioPersona();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green[700],
        tooltip: 'Agregar Persona',
      ),
    );
  }
}
