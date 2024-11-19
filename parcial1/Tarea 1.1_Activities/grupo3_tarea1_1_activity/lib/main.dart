import 'package:flutter/material.dart';
import 'package:grupo3_tarea1_1_activity/pages/MenuPrincipal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Verificador de Edad',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: MenuPrincipal(),
    );
  }
}
