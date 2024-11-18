import 'package:flutter/material.dart';

class SueldoVendedorScreen extends StatefulWidget {
  @override
  _SueldoVendedorScreenState createState() => _SueldoVendedorScreenState();
}

class _SueldoVendedorScreenState extends State<SueldoVendedorScreen> {
  String _resultado = "";
  String _sueldoBase = "";
  String _ventas = "";

  void calcularSueldo() {
    double sueldoBase = double.tryParse(_sueldoBase) ?? 0;
    double ventas = double.tryParse(_ventas) ?? 0;
    double comision = 0;

    if (sueldoBase <= 0 || ventas < 0) {
      setState(() {
        _resultado = "Los datos ingresados no son válidos.";
      });
      return;
    }

    if (ventas < 4000000) {
      comision = 0;
    } else if (ventas >= 4000000 && ventas < 10000000) {
      comision = ventas * 0.03;  // 3% de las ventas
    } else {
      comision = ventas * 0.07;  // 7% de las ventas
    }

    double sueldoMensual = sueldoBase + comision;

    setState(() {
      _resultado = "El sueldo mensual es: \$${sueldoMensual.toStringAsFixed(2)}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora de Sueldo del Vendedor"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Ingrese el sueldo base y las ventas del mes:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextField(
              onChanged: (value) {
                _sueldoBase = value;
              },
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Sueldo Base",
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Colors.blue),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              onChanged: (value) {
                _ventas = value;
              },
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Ventas",
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Colors.blue),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calcularSueldo,
              child: const Text("Calcular Sueldo"),
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
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
