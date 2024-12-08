import 'dart:math';

class LogicaCoseno {
  /// Calcula el coseno de un ángulo dado en grados.
  double calcularCosenoEnGrados(double grados) {
    // Convertir grados a radianes
    double radianes = grados * (pi / 180);
    return cos(radianes);
  }

  /// Calcula el coseno de un ángulo dado en radianes.
  double calcularCosenoEnRadianes(double radianes) {
    return cos(radianes);
  }

  /// Retorna una descripción del resultado en una cadena.
  String calcularCosenoDescripcion(double valor, bool enGrados) {
    double resultado = enGrados ? calcularCosenoEnGrados(valor) : calcularCosenoEnRadianes(valor);
    String unidad = enGrados ? "grados" : "radianes";
    return "El coseno del ángulo $valor $unidad es $resultado.";
  }
}
