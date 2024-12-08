import 'package:flutter/material.dart';
import 'pantalla_resultado.dart'; // Importa la pantalla de resultados

class PantallaASCII extends StatefulWidget {
  @override
  _PantallaASCIIState createState() => _PantallaASCIIState();
}

class _PantallaASCIIState extends State<PantallaASCII> {
  final TextEditingController _controller = TextEditingController();

  void _generarResultadoASCII() {
    int numero = int.tryParse(_controller.text) ?? 0;
    String resultado = '';

    if (numero >= 32 && numero <= 126) {
      resultado = 'El código ASCII para el número $numero es: ${String.fromCharCode(numero)}';
    } else {
      resultado = 'Por favor, ingresa un número entre 32 y 126 para obtener el carácter ASCII.';
    }

    // Navegar a la pantalla de resultados
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PantallaResultado(
          resultado: resultado,  // Pasar el resultado a la pantalla de resultados
          pantalla: 'Tabla ASCII', // Nombre de la pantalla de origen
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tabla ASCII'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.text_fields,
              size: 100,
              color: Colors.blueGrey,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Ingrese un número (32-126)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _generarResultadoASCII,
              child: Text('Mostrar Resultado ASCII'),
            ),
          ],
        ),
      ),
    );
  }
}
