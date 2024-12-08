import 'package:flutter/material.dart';
import 'pantalla_resultado.dart'; // Importa la pantalla de resultados

class PantallaFactorial extends StatefulWidget {
  @override
  _PantallaFactorialState createState() => _PantallaFactorialState();
}

class _PantallaFactorialState extends State<PantallaFactorial> {
  final TextEditingController _controller = TextEditingController();

  void _calcularFactorial() {
    int numero = int.tryParse(_controller.text) ?? 0;
    String resultado = '';

    if (numero < 0) {
      resultado = 'Por favor, ingresa un número entero positivo.';
    } else {
      int factorial = 1;
      for (int i = 1; i <= numero; i++) {
        factorial *= i;
      }
      resultado = 'El factorial de $numero es: $factorial';
    }

    // Navegar a la pantalla de resultados
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PantallaResultado(
          resultado: resultado,
          pantalla: 'Factorial',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cálculo de Factorial'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calculate,
              size: 100,
              color: Colors.green,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Ingrese un número',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calcularFactorial,
              child: Text('Calcular Factorial'),
            ),
          ],
        ),
      ),
    );
  }
}
