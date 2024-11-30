import 'package:aplicacionlogin/pages/register_screen.dart';
import 'package:aplicacionlogin/pages/users_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> login() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/api/auth/login'), // Cambia la URL al endpoint de tu API
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final token = data['token'];  // Asegúrate de que 'token' sea correcto según tu API
        final userName = username;  // Ajusta 'username' si es necesario, dependiendo de la respuesta de tu API

        // Almacena el token JWT y el nombre del usuario en SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('jwt_token', token);  // Almacena el token JWT
        await prefs.setString('userName', userName);  // Almacena el nombre del usuario

        // Redirigir a la pantalla de usuario después del login exitoso
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => UsersScreen()),  // Redirige a la pantalla de usuarios
        );
      } else {
        // Error al hacer login
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Usuario o contraseña incorrectos'),
        ));
      }
    } catch (e) {
      // Captura cualquier error en la solicitud HTTP
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error de conexión: $e'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: login,
              child: Text('Iniciar sesión'),
            ),
            SizedBox(height: 20),
            // Agregar el botón de redirección a la pantalla de registro
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                );
              },
              child: Text('¿No tienes cuenta? Regístrate aquí'),
            ),
          ],
        ),
      ),
    );
  }
}
