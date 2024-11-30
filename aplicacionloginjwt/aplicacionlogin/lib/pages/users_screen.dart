import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart'; // Asegúrate de importar SharedPreferences

class UsersScreen extends StatefulWidget {
  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  List users = [];
  String userName = ''; // Variable para almacenar el nombre del usuario

  // Método para obtener los usuarios de la API
  Future<void> getUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token'); // Obtiene el token JWT de SharedPreferences

    if (token == null) {
      // Si no hay token, muestra un mensaje y no hace la solicitud
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('No estás autenticado'),
      ));
      return;
    }

    final response = await http.get(
      Uri.parse('http://localhost:3000/api/users'), // Cambia la URL al endpoint de tu API
      headers: {
        'Authorization': 'Bearer $token', // Agrega el token JWT al encabezado de la solicitud
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        users = json.decode(response.body)['users'];
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error al obtener usuarios'),
      ));
    }
  }

  // Método para obtener el nombre del usuario desde SharedPreferences
  Future<void> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName') ?? 'Usuario'; // Si no existe, poner 'Usuario' por defecto
    });
  }

  @override
  void initState() {
    super.initState();
    getUserName(); // Llamar a la función para obtener el nombre del usuario
    getUsers(); // Llamar a la función para obtener los usuarios
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Usuarios')),
      body: Column(
        children: [
          // Mostrar el mensaje de bienvenida al usuario
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Bienvenido, $userName',  // Aquí se muestra el nombre del usuario
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(users[index]['username']),
                  subtitle: Text('ID: ${users[index]['id']}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
