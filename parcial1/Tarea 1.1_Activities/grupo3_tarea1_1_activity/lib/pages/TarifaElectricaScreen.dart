import 'package:flutter/material.dart';

class TarifaElectricaScreen extends StatefulWidget {
  @override
  _TarifaElectricaScreenState createState() => _TarifaElectricaScreenState();
}

class _TarifaElectricaScreenState extends State<TarifaElectricaScreen> {
  String _resultado = "";
  String _consumo = "";

  void calcularTarifa() {
    double consumo = double.tryParse(_consumo) ?? 0;
    double costo = 0;
    double iva = 0;

    if (consumo <= 50) {
      costo = consumo * 30;
    } else if (consumo <= 100) {
      double exceso = consumo - 50;
      costo = (50 * 30) + (exceso * 35);
    } else {
      double exceso = consumo - 100;
      costo = (50 * 30) + (50 * 35) + (exceso * 42);
    }

    iva = costo * 0.15; // 15% de IVA
    double costoTotal = costo + iva;

    setState(() {
      _resultado = "El costo total a pagar es: \$${costoTotal.toStringAsFixed(2)}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora de Tarifa Eléctrica"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Imagen en la parte superior
              Image.network(
                'https://cdn-icons-png.flaticon.com/512/10939/10939368.png',
                height: 100, // Ajusta el tamaño de la imagen
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 20), // Espacio entre la imagen y el contenido
              const Text(
                "Ingrese el consumo de electricidad (KWH):",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextField(
                onChanged: (value) {
                  _consumo = value;
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Consumo (KWH)",
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: Colors.blue),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: calcularTarifa,
                child: const Text("Calcular Costo"),
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
      ),
    );
  }
}
