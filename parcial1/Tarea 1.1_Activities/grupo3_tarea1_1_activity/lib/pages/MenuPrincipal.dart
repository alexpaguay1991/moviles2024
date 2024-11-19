import 'package:flutter/material.dart';
import 'package:grupo3_tarea1_1_activity/pages/SueldoVendedorScreen.dart';
import 'package:grupo3_tarea1_1_activity/pages/TarifaElectricaScreen.dart';
import 'package:grupo3_tarea1_1_activity/pages/CamisetaCalculator.dart';
import 'package:grupo3_tarea1_1_activity/pages/edad_checker.dart';
import 'package:grupo3_tarea1_1_activity/pages/TernaPitagorica.dart';
import 'package:grupo3_tarea1_1_activity/pages/Arboles.dart'; // Importamos el archivo Arboles.dart

class MenuPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menú Principal'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Logo pequeño encima del menú
              Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQsVFSqbF7n79uSZNX7yYJeBmBeL4HgeiKudA&s',
                height: 200, // Tamaño del logo
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 20), // Espacio entre el logo y el menú
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EdadVerificadorScreen()),
                  );
                },
                icon: const Icon(Icons.cake, color: Colors.white), // Icono representativo
                label: const Text(
                  'Clasificación por Edad',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TernaPitagoricaScreen()),
                  );
                },
                icon: const Icon(Icons.calculate, color: Colors.white), // Icono representativo
                label: const Text(
                  'Terna Pitagórica',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TarifaElectricaScreen()),
                  );
                },
                icon: const Icon(Icons.electric_bolt, color: Colors.white), // Icono representativo
                label: const Text(
                  'Tarifa Eléctrica',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CamisetaCalculadorScreen()),
                  );
                },
                icon: const Icon(Icons.checkroom, color: Colors.white), // Icono representativo
                label: const Text(
                  'Calculadora de Camisetas',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SueldoVendedorScreen()),
                  );
                },
                icon: const Icon(Icons.monetization_on, color: Colors.white), // Icono representativo
                label: const Text(
                  'Cálculo de Sueldo de Vendedor',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TreeCostCalculatorScreen()), // Nueva opción
                  );
                },
                icon: const Icon(Icons.nature, color: Colors.white), // Icono representativo
                label: const Text(
                  'Gestión de Árboles',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
