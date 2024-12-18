import 'package:flutter/material.dart';
import '../vista/persona_vista.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Personas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PersonaVista(),
    );
  }
}
