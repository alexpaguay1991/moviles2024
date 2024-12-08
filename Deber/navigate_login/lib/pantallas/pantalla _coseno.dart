import 'package:flutter/material.dart';
import '../logica/logica_coseno.dart';
import 'pantalla_resultado.dart';  // Asegúrate de importar la pantalla de resultados

class PantallaCoseno extends StatefulWidget {
  @override
  State<PantallaCoseno> createState() => _PantallaCosenoState();
}

class _PantallaCosenoState extends State<PantallaCoseno> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _anguloController = TextEditingController();

  final LogicaCoseno _logicaCoseno = LogicaCoseno(); // Instancia de la lógica de coseno

  void _calcularCoseno() {
    // Validar entrada del usuario
    if (_nombreController.text.isEmpty || _anguloController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, completa todos los campos.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      // Convertir el ángulo ingresado a un número
      final double angulo = double.parse(_anguloController.text);

      // Calcular el coseno usando la lógica (en grados)
      final double resultado = _logicaCoseno.calcularCosenoEnGrados(angulo);

      // Redirigir a la pantalla de resultados con el resultado y el nombre
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PantallaResultado(resultado: resultado, nombre: _nombreController.text),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error al procesar el ángulo. Verifica los valores ingresados.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora de Coseno"),
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Calcula el Coseno",
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
            TextField(
              controller: _anguloController,
              decoration: InputDecoration(
                labelText: "Ángulo en grados",
                prefixIcon: const Icon(Icons.calculate, color: Colors.blueGrey),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calcularCoseno,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                "Calcular Coseno",
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
