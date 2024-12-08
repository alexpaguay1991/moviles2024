class LogicaFactorial {
  int calcularFactorial(int numero) {
    if (numero < 0) throw ArgumentError('El número debe ser no negativo.');
    return numero == 0 ? 1 : numero * calcularFactorial(numero - 1);
  }
}
