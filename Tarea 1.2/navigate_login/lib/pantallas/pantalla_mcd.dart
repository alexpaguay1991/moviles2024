import 'package:flutter/material.dart';
import 'pantalla_resultado.dart'; // Importa la pantalla de resultados

class PantallaMCD extends StatefulWidget {
  @override
  _PantallaMCDState createState() => _PantallaMCDState();
}

class _PantallaMCDState extends State<PantallaMCD> {
  final TextEditingController _controllerA = TextEditingController();
  final TextEditingController _controllerB = TextEditingController();

  void _calcularMCD() {
    int a = int.tryParse(_controllerA.text) ?? 0;
    int b = int.tryParse(_controllerB.text) ?? 0;
    String resultado = '';
    int mcd = 1;

    // Lógica para calcular el MCD
    for (int i = 1; i <= a && i <= b; i++) {
      if (a % i == 0 && b % i == 0) {
        mcd = i;
      }
    }

    resultado = 'El MCD de $a y $b es: $mcd';

    // Navegar a la pantalla de resultados
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PantallaResultado(
          resultado: resultado,
          pantalla: 'MCD',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cálculo de MCD'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.merge_type,
              size: 100,
              color: Colors.orange,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _controllerA,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Ingrese el primer número',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _controllerB,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Ingrese el segundo número',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calcularMCD,
              child: Text('Calcular MCD'),
            ),
          ],
        ),
      ),
    );
  }
}
