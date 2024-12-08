class LogicaPrimos {
  // Función para verificar si un número es primo
  bool esPrimo(int numero) {
    if (numero <= 1) return false;
    for (int i = 2; i <= numero ~/ 2; i++) {
      if (numero % i == 0) return false;
    }
    return true;
  }

  // Función para generar lista de números primos hasta un número límite
  String generarPrimos(int limite) {
    List<int> primos = [];
    for (int i = 2; i <= limite; i++) {
      if (esPrimo(i)) {
        primos.add(i);
      }
    }
    return primos.join(', ');
  }
}
