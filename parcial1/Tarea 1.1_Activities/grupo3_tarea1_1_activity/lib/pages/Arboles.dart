import 'package:flutter/material.dart';

class TreeCostCalculatorScreen extends StatefulWidget {
  @override
  _TreeCostCalculatorScreenState createState() =>
      _TreeCostCalculatorScreenState();
}

class _TreeCostCalculatorScreenState extends State<TreeCostCalculatorScreen> {
  String _paltoQty = '';
  String _limonQty = '';
  String _chirimoyoQty = '';
  String _resultado = '';

  // Prices and discount rates
  final int paltoPrice = 1200;
  final int limonPrice = 1000;
  final int chirimoyoPrice = 980;

  final double paltoDiscount100To300 = 0.10;
  final double paltoDiscountAbove300 = 0.18;
  final double limonDiscount100To300 = 0.125;
  final double limonDiscountAbove300 = 0.20;
  final double chirimoyoDiscount100To300 = 0.145;
  final double chirimoyoDiscountAbove300 = 0.19;
  final double additionalDiscountOver1000 = 0.15;
  final double vatRate = 0.19;

  // Method to calculate total cost
  void calcularCosto() {
    int? paltoQty = int.tryParse(_paltoQty);
    int? limonQty = int.tryParse(_limonQty);
    int? chirimoyoQty = int.tryParse(_chirimoyoQty);

    setState(() {
      if (paltoQty == null || limonQty == null || chirimoyoQty == null) {
        _resultado = "Por favor, ingresa solo números válidos.";
        return;
      } else if (paltoQty < 0 || limonQty < 0 || chirimoyoQty < 0) {
        _resultado = "Las cantidades no pueden ser negativas.";
        return;
      }

      // Calculate individual costs with discounts
      double paltoCost = _calculateDiscountedCost(
        paltoQty,
        paltoPrice,
        paltoDiscount100To300,
        paltoDiscountAbove300,
      );
      double limonCost = _calculateDiscountedCost(
        limonQty,
        limonPrice,
        limonDiscount100To300,
        limonDiscountAbove300,
      );
      double chirimoyoCost = _calculateDiscountedCost(
        chirimoyoQty,
        chirimoyoPrice,
        chirimoyoDiscount100To300,
        chirimoyoDiscountAbove300,
      );

      // Calculate total cost
      double totalCost = paltoCost + limonCost + chirimoyoCost;
      int totalQty = paltoQty + limonQty + chirimoyoQty;

      // Apply additional discount if totalQty > 1000
      if (totalQty > 1000) {
        totalCost *= (1 - additionalDiscountOver1000);
      }

      // Add VAT
      double finalCost = totalCost * (1 + vatRate);

      // Display result
      _resultado = "El costo total, incluyendo IVA, es: \$${finalCost.toStringAsFixed(2)}";
    });
  }

  // Helper function to calculate discounted cost
  double _calculateDiscountedCost(
      int qty, int price, double discount100To300, double discountAbove300) {
    if (qty > 300) {
      return qty * price * (1 - discountAbove300);
    } else if (qty > 100) {
      return qty * price * (1 - discount100To300);
    } else {
      return qty * price.toDouble();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora de Costo de Árboles"),
        backgroundColor: Colors.blue, // Cambiado a azul
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
                  'https://st4.depositphotos.com/11956860/26811/v/450/depositphotos_268113698-stock-illustration-illustration-icon-trees.jpg',
                  height: 100,
                  fit: BoxFit.contain,
                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child; // La imagen se ha cargado completamente
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                              : null,
                        ),
                      );
                    }
                  },
                  errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                    return Center(child: Text('Error al cargar la imagen'));
                  },
                ),
                const SizedBox(height: 20),
                const Text(
                  "Calculadora de Árboles",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue, // Cambiado a azul
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                TextField(
                  onChanged: (value) {
                    _paltoQty = value;
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Cantidad de Paltos",
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue), // Cambiado a azul
                    ),
                    labelStyle: TextStyle(color: Colors.blue), // Cambiado a azul
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  onChanged: (value) {
                    _limonQty = value;
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Cantidad de Limones",
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue), // Cambiado a azul
                    ),
                    labelStyle: TextStyle(color: Colors.blue), // Cambiado a azul
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  onChanged: (value) {
                    _chirimoyoQty = value;
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Cantidad de Chirimoyos",
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue), // Cambiado a azul
                    ),
                    labelStyle: TextStyle(color: Colors.blue), // Cambiado a azul
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: calcularCosto,
                  child: const Text("Calcular Costo Total"),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue, // Cambiado a azul
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
                      fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue), // Cambiado a azul
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
