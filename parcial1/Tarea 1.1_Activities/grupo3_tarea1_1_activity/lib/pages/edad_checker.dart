import 'package:flutter/material.dart';

class EdadVerificadorScreen extends StatefulWidget {
  const EdadVerificadorScreen({super.key});

  @override
  _EdadVerificadorScreenState createState() => _EdadVerificadorScreenState();
}

class _EdadVerificadorScreenState extends State<EdadVerificadorScreen> {
  String _edad = '';
  String _resultado = '';

  // Método para calcular la categoría de edad
  void calcularCategoriaEdad() {
    int edad = int.tryParse(_edad) ?? -1;
    setState(() {
      _resultado = verificarEdad(edad);
    });
  }

  @override
  Widget build(BuildContext context) {
    // URL de la imagen en línea
    final String imageUrl =
        'https://cdn-icons-png.flaticon.com/512/5988/5988375.png'; // Cambia esta URL por la correcta

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verificador de Edad'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Imagen desde la red
              Image.network(
                imageUrl,
                height: 150,
                width: 150,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.error,
                    color: Colors.red,
                    size: 150,
                  );
                },
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        "Ingrese su Edad",
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
                          _edad = value;
                        },
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "Edad",
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          labelStyle: TextStyle(color: Colors.blue),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: calcularCategoriaEdad,
                        child: const Text("Verificar Edad"),
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
                        _resultado.isNotEmpty ? "Categoría: $_resultado" : "",
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String verificarEdad(int edad) {
  if (edad < 0) {
    return "Error: La edad no puede ser negativa.";
  } else if (edad <= 10) {
    return "NIÑO";
  } else if (edad >= 11 && edad <= 14) {
    return "PUBER";
  } else if (edad >= 15 && edad <= 18) {
    return "ADOLESCENTE";
  } else if (edad >= 19 && edad <= 25) {
    return "JOVEN";
  } else if (edad >= 26 && edad <= 65) {
    return "ADULTO";
  } else if (edad > 65) {
    return "ANCIANO";
  } else {
    return "Error: Edad inválida.";
  }
}
