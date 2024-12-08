import 'package:flutter/material.dart';
import 'pantalla_resultado.dart'; // Importa la pantalla de resultados

class PantallaPrimos extends StatefulWidget {
  @override
  _PantallaPrimosState createState() => _PantallaPrimosState();
}

class _PantallaPrimosState extends State<PantallaPrimos> {
  final TextEditingController _controller = TextEditingController();

  List<int> _obtenerPrimos(int limite) {
    List<int> primos = [];
    for (int i = 2; i <= limite; i++) {
      bool esPrimo = true;
      for (int j = 2; j <= i ~/ 2; j++) {
        if (i % j == 0) {
          esPrimo = false;
          break;
        }
      }
      if (esPrimo) {
        primos.add(i);
      }
    }
    return primos;
  }

  void _calcularPrimos() {
    int limite = int.tryParse(_controller.text) ?? 0;
    String resultado = '';

    if (limite <= 1) {
      resultado = 'Por favor, ingresa un número mayor a 1.';
    } else {
      List<int> primos = _obtenerPrimos(limite);
      resultado = 'Los números primos hasta $limite son: ${primos.join(', ')}';
    }

    // Navegar a la pantalla de resultados
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PantallaResultado(
          resultado: resultado,
          pantalla: 'Números Primos',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Números Primos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.format_list_numbered,
              size: 100,
              color: Colors.green,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Ingrese un número límite',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calcularPrimos,
              child: Text('Mostrar Números Primos'),
            ),
          ],
        ),
      ),
    );
  }
}
