class LogicaFactorizacion {
  Map<int, int> factorizar(int numero) {
    if (numero <= 1) throw ArgumentError('El número debe ser mayor que 1.');
    Map<int, int> factores = {};
    for (int i = 2; i <= numero ~/ i; i++) {
      while (numero % i == 0) {
        factores[i] = (factores[i] ?? 0) + 1;
        numero ~/= i;
      }
    }
    if (numero > 1) {
      factores[numero] = 1;
    }
    return factores;
  }
}
