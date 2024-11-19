import 'package:flutter/material.dart';

class TernaPitagoricaScreen extends StatefulWidget {
  @override
  _TernaPitagoricaScreenState createState() => _TernaPitagoricaScreenState();
}

class _TernaPitagoricaScreenState extends State<TernaPitagoricaScreen> {
  String _numA = '';
  String _numB = '';
  String _numC = '';
  String _resultado = '';

  // Método para verificar si es una terna pitagórica
  void verificarTerna() {
    int? a = int.tryParse(_numA);
    int? b = int.tryParse(_numB);
    int? c = int.tryParse(_numC);

    setState(() {
      if (a == null || b == null || c == null) {
        _resultado = "Por favor ingresa solo números válidos.";
      } else if (a == 0 || b == 0 || c == 0) {
        _resultado = "Por favor ingresa números mayores a cero.";
      } else if ((a * a + b * b == c * c) ||
          (a * a + c * c == b * b) ||
          (b * b + c * c == a * a)) {
        _resultado = "Es una terna pitagórica";
      } else {
        _resultado = "No es una terna pitagórica";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verificador de Terna Pitagórica"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Imagen en la parte superior
                  Image.network(
                    'https://i0.wp.com/www.webscolar.com/wp-content/uploads/2013/02/webscolar11424-1.jpg?resize=197%2C232',
                    height: 150, // Ajusta el tamaño de la imagen
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 20), // Espacio entre la imagen y el contenido
                  const Text(
                    "Verifique Terna Pitagórica",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    onChanged: (value) {
                      _numA = value;
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Número a",
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      labelStyle: TextStyle(color: Colors.blue),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    onChanged: (value) {
                      _numB = value;
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Número b",
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      labelStyle: TextStyle(color: Colors.blue),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    onChanged: (value) {
                      _numC = value;
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Número c",
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      labelStyle: TextStyle(color: Colors.blue),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: verificarTerna,
                    child: const Text("Verificar Terna Pitagórica"),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      textStyle: const TextStyle(fontSize: 18),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    _resultado,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

bool esTernaPitagorica(int a, int b, int c) {
  return (a * a + b * b == c * c) ||
      (a * a + c * c == b * b) ||
      (b * b + c * c == a * a);
}
