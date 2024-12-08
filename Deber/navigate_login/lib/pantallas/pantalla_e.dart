import 'package:flutter/material.dart';
import '../logica/logica_e.dart'; // Asegúrate de que el archivo con la lógica de Euler esté bien importado

class PantallaEuler extends StatefulWidget {
  @override
  State<PantallaEuler> createState() => _PantallaEulerState();
}

class _PantallaEulerState extends State<PantallaEuler> {
  final TextEditingController _nombreController = TextEditingController();

  String _resultadoEuler = '';
  final LogicaEuler _logicaEuler = LogicaEuler(); // Instancia de la lógica para calcular el valor de euler

  void _calcularEuler() {
    // Validar entrada del usuario
    if (_nombreController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, completa el campo de nombre.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      // Obtener el valor de 'e' usando la lógica
      final double resultado = _logicaEuler.calcularE();

      // Mostrar el resultado
      setState(() {
        _resultadoEuler = "¡Hola, ${_nombreController.text}!\nEl valor de 'e' es: ${resultado.toStringAsFixed(4)}";
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error al calcular el valor de e.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora de Euler"),
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Calcula el valor de 'e'",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.blueGrey),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nombreController,
              decoration: InputDecoration(
                labelText: "Nombre",
                prefixIcon: const Icon(Icons.person, color: Colors.blueGrey),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calcularEuler,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                "Calcular Valor de 'e'",
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 30),
            if (_resultadoEuler.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blueGrey[50],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  _resultadoEuler,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20, color: Colors.black87),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
