import 'package:flutter/material.dart';
import 'pantalla_resultado.dart'; // Importa la pantalla de resultados

class PantallaFactorizacion extends StatefulWidget {
  @override
  _PantallaFactorizacionState createState() => _PantallaFactorizacionState();
}

class _PantallaFactorizacionState extends State<PantallaFactorizacion> {
  final TextEditingController _controller = TextEditingController();

  List<int> _factorizar(int numero) {
    List<int> factores = [];
    for (int i = 2; i <= numero; i++) {
      while (numero % i == 0) {
        factores.add(i);
        numero ~/= i;
      }
    }
    return factores;
  }

  void _calcularFactorizacion() {
    int numero = int.tryParse(_controller.text) ?? 0;
    String resultado = '';

    if (numero <= 1) {
      resultado = 'Por favor, ingresa un número mayor que 1.';
    } else {
      List<int> factores = _factorizar(numero);
      resultado = 'La factorización de $numero es: ${factores.join(' x ')}';
    }

    // Navegar a la pantalla de resultados
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PantallaResultado(
          resultado: resultado,
          pantalla: 'Factorización',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Factorización de Números'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.fact_check,
              size: 100,
              color: Colors.purple,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Ingrese un número para factorizar',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calcularFactorizacion,
              child: Text('Mostrar Factorización'),
            ),
          ],
        ),
      ),
    );
  }
}
