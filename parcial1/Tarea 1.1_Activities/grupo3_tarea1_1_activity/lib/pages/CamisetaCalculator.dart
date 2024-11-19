import 'package:flutter/material.dart';

class CamisetaCalculadorScreen extends StatefulWidget {
  const CamisetaCalculadorScreen({super.key});

  @override
  _CamisetaCalculadorScreenState createState() =>
      _CamisetaCalculadorScreenState();
}

class _CamisetaCalculadorScreenState extends State<CamisetaCalculadorScreen> {
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  String _resultado = "";
  String _detalles = "";

  void calcularCostoTotal() {
    final double? precio = double.tryParse(_priceController.text);
    final int? cantidad = int.tryParse(_quantityController.text);

    if (precio == null || precio <= 0 || cantidad == null || cantidad <= 0) {
      setState(() {
        _resultado = "Por favor, ingrese valores válidos.";
        _detalles = "";
      });
      return;
    }

    double descuento = 0.0;

    if (cantidad > 5) {
      descuento = 0.20; // 20% de descuento
    } else if (cantidad >= 3) {
      descuento = 0.10; // 10% de descuento
    }

    double precioNormal = precio * cantidad;
    double montoDescuento = precioNormal * descuento;
    double precioFinal = precioNormal - montoDescuento;

    setState(() {
      _resultado = "Costo total: \$${precioFinal.toStringAsFixed(2)}";
      _detalles =
          "Precio normal: \$${precioNormal.toStringAsFixed(2)}\n" +
              "Descuento: \$${montoDescuento.toStringAsFixed(2)}\n" +
              "Precio final: \$${precioFinal.toStringAsFixed(2)}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de Camisetas'),
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
                    'https://cdn-icons-png.flaticon.com/512/863/863684.png',
                    height: 100, // Ajusta el tamaño de la imagen
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 20), // Espacio entre la imagen y el contenido
                  const Text(
                    "Calcula el costo de tus camisetas",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Precio por camiseta",
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      labelStyle: TextStyle(color: Colors.blue),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _quantityController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Cantidad de camisetas",
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      labelStyle: TextStyle(color: Colors.blue),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: calcularCostoTotal,
                    child: const Text("Calcular"),
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
                    _resultado.isNotEmpty ? _resultado : "",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (_detalles.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        _detalles,
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
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
