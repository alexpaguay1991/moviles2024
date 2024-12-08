import 'package:flutter/material.dart';
import 'pantallas/pantalla_bienvenida.dart'; // Importa la pantalla de bienvenida

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/bienvenida', // Define la ruta inicial a la pantalla de bienvenida
      routes: {
        '/bienvenida': (context) {
          final String usuario = 'Santiago'; // Usuario fijo, puedes modificarlo si deseas pasarlo dinámicamente
          return PantallaBienvenida(usuario: usuario); // Pasa el usuario a la pantalla bienvenida
        },
      },
    );
  }
}
