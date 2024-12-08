import 'dart:math';

class LogicaEuler {
  /// Calcula el valor de 'e' (base del logaritmo natural).
  double calcularE() {
    return exp(1); // exp(1) = e
  }

  /// Retorna una descripción del valor de 'e'.
  String calcularEDescripcion() {
    double e = calcularE();
    return "El valor de 'e' es: $e";
  }
}


