class LogicaASCII {
  // Genera la tabla de caracteres ASCII
  String generarTablaASCII() {
    String tabla = '';
    for (int i = 32; i < 128; i++) {
      tabla += 'Código ASCII $i: ${String.fromCharCode(i)}\n';
    }
    return tabla;
  }
}
